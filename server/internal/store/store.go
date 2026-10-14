// Package store lưu dữ liệu lâu dài: người chơi, lịch sử trận, bảng xếp hạng,
// nhật ký gian lận. Có hai bản: Postgres (+ Redis làm cache/phiên) cho
// production và bản trong bộ nhớ để chạy thử không cần database.
package store

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"regexp"
	"strings"
	"time"

	"golang.org/x/crypto/bcrypt"
)

var (
	ErrBadLogin   = errors.New("Sai tên tài khoản hoặc mật khẩu")
	ErrTaken      = errors.New("Tên tài khoản đã có người dùng")
	ErrBadSession = errors.New("Phiên đăng nhập đã hết hạn, hãy đăng nhập lại")
	ErrBanned     = errors.New("Tài khoản đã bị khoá vì gian lận")
	reUsername    = regexp.MustCompile(`^[A-Za-z0-9_]{5,16}$`)
)

// CheckCredentials kiểm tra định dạng tên/mật khẩu khi đăng ký.
func CheckCredentials(username, password string) error {
	if !reUsername.MatchString(username) {
		return errors.New("Tên tài khoản 5-16 ký tự, chỉ gồm chữ không dấu, số và _")
	}
	if ReservedUsername(username) {
		return errors.New("Tên tài khoản này không được phép dùng, hãy chọn tên khác")
	}
	if len(password) < 6 || len(password) > 72 {
		return errors.New("Mật khẩu cần từ 6 đến 72 ký tự")
	}
	return nil
}

// Tên dành riêng: người chơi không được tự đặt để giả danh quản trị / hệ thống.
// reservedParts bị cấm nếu xuất hiện ở bất kỳ đâu trong tên (kể cả viết kiểu
// a_d_m_1_n, 4dm1n); reservedExact chỉ cấm khi cả tên trùng khớp.
var (
	reservedParts = []string{
		"admin", "administrator", "sysadmin", "superuser", "superadmin", "root",
		"moderator", "support", "system", "staff", "owner", "official", "webmaster",
		"gamemaster", "operator", "security", "quantri", "quanly", "kiemduyet",
		"hotro", "nghiane", "vietnghiavnn",
	}
	reservedExact = []string{
		"mod", "mods", "gm", "sys", "server", "host", "bot", "null", "nil", "undefined",
		"guest", "anonymous", "everyone", "here", "player", "goku", "dev", "developer",
	}
	leet = strings.NewReplacer("0", "o", "1", "i", "3", "e", "4", "a", "5", "s", "7", "t", "8", "b", "9", "g", "$", "s", "@", "a")
)

// ReservedUsername cho biết tên có thuộc nhóm tên dành riêng hay không.
func ReservedUsername(u string) bool {
	plain := strings.ReplaceAll(strings.ToLower(u), "_", "")
	forms := []string{
		plain,
		leet.Replace(plain),
		strings.TrimRight(plain, "0123456789"), // admin123 -> admin
	}
	// 1 còn hay bị dùng thay cho "l"
	forms = append(forms, strings.ReplaceAll(forms[1], "i", "l"))
	for _, f := range forms {
		for _, w := range reservedParts {
			if strings.Contains(f, w) {
				return true
			}
		}
		for _, w := range reservedExact {
			if f == w {
				return true
			}
		}
	}
	return false
}

func hashPassword(p string) (string, error) {
	b, err := bcrypt.GenerateFromPassword([]byte(p), 10)
	return string(b), err
}

func checkPassword(hash, p string) bool {
	return bcrypt.CompareHashAndPassword([]byte(hash), []byte(p)) == nil
}

// dummyHash dùng khi tài khoản không tồn tại để thời gian phản hồi như nhau.
var dummyHash, _ = bcrypt.GenerateFromPassword([]byte("dummy-password"), 10)

func normUser(u string) string { return strings.ToLower(strings.TrimSpace(u)) }

type Player struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
}

type MatchPlayer struct {
	PlayerID int64  `json:"playerId"`
	Name     string `json:"name"`
	Slot     int    `json:"slot"`
	Score    int    `json:"score"`
	Level    int    `json:"level"`
	Deaths   int    `json:"deaths"`
	Revives  int    `json:"revives"`
	Gold     int    `json:"gold"`
}

type Match struct {
	RoomName  string
	StartedAt time.Time
	EndedAt   time.Time
	Result    string // "victory" | "defeat" | "abandoned"
	Rounds    int
	Players   []MatchPlayer
	Inputs    []byte // log lệnh đã nén gzip, để xem lại khi nghi gian lận
}

type LeaderRow struct {
	PlayerID   int64  `json:"playerId"`
	Name       string `json:"name"`
	TotalScore int64  `json:"totalScore"`
	Games      int64  `json:"games"`
	Wins       int64  `json:"wins"`
	BestRound  int64  `json:"bestRound"`
}

// Reconnect: thông tin để người chơi rớt mạng vào lại đúng trận, đúng slot.
type Reconnect struct {
	Room string `json:"room"`
	Slot int    `json:"slot"`
}

type Store interface {
	// Register tạo tài khoản mới, trả về phiên đăng nhập (token).
	Register(ctx context.Context, username, password string) (p Player, token string, err error)
	// Login kiểm tra mật khẩu, tạo phiên mới (phiên cũ mất hiệu lực).
	Login(ctx context.Context, username, password string) (p Player, token string, err error)
	// Resume khôi phục phiên từ token đã lưu ở trình duyệt.
	Resume(ctx context.Context, token string) (Player, error)
	SaveMatch(ctx context.Context, m Match) error
	LogCheat(ctx context.Context, playerID int64, kind, detail string)
	Leaderboard(ctx context.Context, n int) ([]LeaderRow, error)
	SetReconnect(ctx context.Context, playerID int64, r Reconnect, ttl time.Duration)
	GetReconnect(ctx context.Context, playerID int64) (Reconnect, bool)
	ClearReconnect(ctx context.Context, playerID int64)
	Close()
}

func newToken() string {
	b := make([]byte, 32)
	rand.Read(b)
	return hex.EncodeToString(b)
}

func hashToken(t string) string {
	h := sha256.Sum256([]byte(t))
	return hex.EncodeToString(h[:])
}

func validToken(t string) bool {
	if len(t) != 64 {
		return false
	}
	_, err := hex.DecodeString(t)
	return err == nil
}
