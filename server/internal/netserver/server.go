// Package netserver: HTTP + WebSocket, đăng nhập, phòng chơi, vòng lặp mô
// phỏng cho mỗi phòng và các lớp chống gian lận ở tầng mạng.
package netserver

import (
	"context"
	"crypto/rand"
	"encoding/json"
	"fmt"
	"log"
	"math"
	"mime"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"sort"
	"strconv"
	"strings"
	"sync"
	"time"
	"unicode"

	"github.com/gorilla/websocket"

	"gokutruotbang/internal/game"
	"gokutruotbang/internal/mapdata"
	"gokutruotbang/internal/store"
)

type inMsg struct {
	T        string  `json:"t"`
	Name     string  `json:"name"`
	Token    string  `json:"token"`
	Username string  `json:"username"`
	Password string  `json:"password"`
	Private  bool    `json:"private"`
	Room     string  `json:"room"`
	X        float64 `json:"x"`
	Y        float64 `json:"y"`
	Ab       string  `json:"ab"`
	Text     string  `json:"text"`
	Seq      uint32  `json:"s"`
	C        float64 `json:"c"` // thời gian client (ping)
}

// Các loại lệnh hợp lệ; lệnh lạ bị tính là đáng ngờ.
var knownMsg = map[string]bool{
	"hello": true, "register": true, "login": true, "logout": true, "rooms": true, "create": true, "join": true, "leave": true,
	"start": true, "lobby": true, "chat": true, "ready": true, "ping": true,
	"order": true, "stop": true, "cast": true, "learn": true,
	"buy": true, "sell": true, "craft": true, "use": true, "wish": true, "cam": true,
}

type Config struct {
	AllowedOrigins []string // rỗng = cho phép mọi origin (dev)
	StaticDir      string
}

type Server struct {
	m        *mapdata.Map
	st       store.Store
	cfg      Config
	upgrader websocket.Upgrader

	mu       sync.Mutex
	rooms    map[string]*Room
	byPlayer map[int64]*Client // mỗi tài khoản chỉ một kết nối
	nextID   int
	nextRm   int
	fails    map[string]*loginFail // chống dò mật khẩu
}

type loginFail struct {
	n     int
	until time.Time
}

const (
	maxLoginFails = 5
	loginLockout  = 5 * time.Minute
)

func New(m *mapdata.Map, st store.Store, cfg Config) *Server {
	s := &Server{m: m, st: st, cfg: cfg, rooms: map[string]*Room{}, byPlayer: map[int64]*Client{}, fails: map[string]*loginFail{}}
	s.upgrader = websocket.Upgrader{
		ReadBufferSize:    1024,
		WriteBufferSize:   1 << 15,
		EnableCompression: true, // permessage-deflate: snapshot JSON nén ~5-8 lần
		CheckOrigin:       s.checkOrigin,
	}
	return s
}

func (s *Server) checkOrigin(r *http.Request) bool {
	if len(s.cfg.AllowedOrigins) == 0 {
		return true
	}
	o := r.Header.Get("Origin")
	u, err := url.Parse(o)
	if err != nil {
		return false
	}
	for _, a := range s.cfg.AllowedOrigins {
		if strings.EqualFold(u.Host, a) || strings.EqualFold(o, a) {
			return true
		}
	}
	return false
}

func init() {
	_ = mime.AddExtensionType(".webmanifest", "application/manifest+json")
}

// Handler trả về mux: /ws, /api/*, /healthz và file tĩnh của client.
func (s *Server) Handler() http.Handler {
	mux := http.NewServeMux()
	mux.HandleFunc("/ws", s.serveWS)
	mux.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) { w.Write([]byte("ok")) })
	mux.HandleFunc("/api/map", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Header().Set("Cache-Control", "public, max-age=3600")
		w.Write(mapdata.Raw())
	})
	mux.HandleFunc("/metrics", func(w http.ResponseWriter, r *http.Request) {
		s.mu.Lock()
		rooms, clients, games := len(s.rooms), 0, 0
		for _, rm := range s.rooms {
			rm.mu.Lock()
			clients += len(rm.members)
			if rm.g != nil {
				games++
			}
			rm.mu.Unlock()
		}
		s.mu.Unlock()
		w.Header().Set("Cache-Control", "no-store")
		writeJSON(w, metrics.report(rooms, clients, games))
	})
	mux.HandleFunc("/api/items", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Cache-Control", "no-cache")
		writeJSON(w, game.Catalog())
	})
	mux.HandleFunc("/api/rooms", func(w http.ResponseWriter, r *http.Request) {
		writeJSON(w, s.roomList())
	})
	mux.HandleFunc("/api/leaderboard", func(w http.ResponseWriter, r *http.Request) {
		rows, err := s.st.Leaderboard(r.Context(), 20)
		if err != nil {
			http.Error(w, "lỗi", 500)
			return
		}
		writeJSON(w, rows)
	})
	if dir := s.cfg.StaticDir; dir != "" {
		if st, err := os.Stat(dir); err == nil && st.IsDir() {
			fs := http.FileServer(http.Dir(dir))
			mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
				p := filepath.Join(dir, filepath.FromSlash(r.URL.Path))
				st, err := os.Stat(p)
				if err != nil || st.IsDir() || strings.HasSuffix(r.URL.Path, ".html") {
					// index.html luôn lấy bản mới để người chơi nhận ngay bản deploy mới
					w.Header().Set("Cache-Control", "no-cache")
					if err != nil {
						http.ServeFile(w, r, filepath.Join(dir, "index.html"))
						return
					}
				} else if strings.HasPrefix(r.URL.Path, "/assets/") {
					w.Header().Set("Cache-Control", "public, max-age=86400")
				} else {
					// og.jpg, icon, robots.txt, sitemap.xml...
					w.Header().Set("Cache-Control", "public, max-age=3600")
				}
				fs.ServeHTTP(w, r)
			})
		} else {
			log.Printf("Không thấy thư mục client %q - chỉ chạy API/WebSocket", dir)
		}
	}
	return mux
}

func simLatency() time.Duration {
	ms, _ := strconv.Atoi(os.Getenv("SIM_LATENCY_MS"))
	return time.Duration(ms) * time.Millisecond
}

func writeJSON(w http.ResponseWriter, v any) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(v)
}

// ---------------------------------------------------------------- client

type Client struct {
	id     int
	name   string
	player store.Player // ID = 0 khi chưa đăng nhập
	conn   *websocket.Conn
	send   chan []byte
	room   *Room // chỉ đọc/ghi dưới Server.mu
	once   sync.Once

	// token bucket chống spam lệnh
	tokens  float64
	last    time.Time
	dropped int
	strikes int
	lat     time.Duration // độ trễ giả lập (chỉ khi test)
}

const (
	rateLimit  = 30.0 // lệnh / giây
	rateBurst  = 60.0
	maxDropped = 300 // vượt quá thì ngắt kết nối và ghi log gian lận
	maxStrikes = 20
)

func (c *Client) allow() bool {
	now := time.Now()
	c.tokens = math.Min(rateBurst, c.tokens+now.Sub(c.last).Seconds()*rateLimit)
	c.last = now
	if c.tokens < 1 {
		c.dropped++
		return false
	}
	c.tokens--
	return true
}

func (c *Client) sendJSON(v any) {
	b, err := json.Marshal(v)
	if err != nil {
		log.Println("json:", err)
		return
	}
	c.sendRaw(b)
}

func (c *Client) sendRaw(b []byte) {
	if c.lat > 0 {
		time.AfterFunc(c.lat/2, func() { c.push(b) })
		return
	}
	c.push(b)
}

func (c *Client) push(b []byte) {
	defer func() { recover() }() // kênh có thể đã đóng
	select {
	case c.send <- b:
	default: // client quá chậm: ngắt kết nối
		c.close()
	}
}

func (c *Client) close() {
	c.once.Do(func() { close(c.send) })
}

func (s *Server) serveWS(w http.ResponseWriter, r *http.Request) {
	conn, err := s.upgrader.Upgrade(w, r, nil)
	if err != nil {
		return
	}
	conn.EnableWriteCompression(true)
	conn.SetCompressionLevel(1)
	s.mu.Lock()
	s.nextID++
	c := &Client{id: s.nextID, name: fmt.Sprintf("Goku%d", s.nextID), conn: conn, send: make(chan []byte, 256), tokens: rateBurst, last: time.Now()}
	s.mu.Unlock()

	lat := simLatency()
	c.lat = lat
	go func() { // writer
		defer conn.Close()
		for b := range c.send {
			conn.SetWriteDeadline(time.Now().Add(10 * time.Second))
			if err := conn.WriteMessage(websocket.TextMessage, b); err != nil {
				return
			}
			metrics.sent(len(b))
		}
		conn.WriteMessage(websocket.CloseMessage, nil)
	}()

	c.sendJSON(map[string]any{
		"t": "welcome", "id": c.id, "abilities": game.Abilities, "colors": game.PlayerColors,
		"tickRate": game.TickRate, "snapshotRate": game.SnapshotRate,
	})

	conn.SetReadLimit(2048)
	conn.SetReadDeadline(time.Now().Add(60 * time.Second))
	conn.SetPongHandler(func(string) error { conn.SetReadDeadline(time.Now().Add(60 * time.Second)); return nil })
	for {
		var msg inMsg
		if err := conn.ReadJSON(&msg); err != nil {
			break
		}
		conn.SetReadDeadline(time.Now().Add(60 * time.Second))
		if !c.allow() {
			if c.dropped > maxDropped {
				s.st.LogCheat(context.Background(), c.player.ID, "flood", fmt.Sprintf("gửi quá %d lệnh vượt giới hạn %v/s", c.dropped, rateLimit))
				c.sendJSON(map[string]any{"t": "kicked", "text": "Bị ngắt kết nối vì gửi lệnh bất thường"})
				break
			}
			continue
		}
		if !knownMsg[msg.T] {
			c.strikes++
			if c.strikes > maxStrikes {
				s.st.LogCheat(context.Background(), c.player.ID, "protocol", "gửi nhiều lệnh không hợp lệ: "+msg.T)
				break
			}
			continue
		}
		if lat > 0 { // giả lập mạng chậm khi test (SIM_LATENCY_MS)
			m := msg
			time.AfterFunc(lat/2, func() { s.handle(c, m) })
			continue
		}
		s.handle(c, msg)
	}
	s.disconnect(c)
	c.close()
}

func (s *Server) handle(c *Client, msg inMsg) {
	if msg.T == "ping" {
		c.sendJSON(map[string]any{"t": "pong", "c": msg.C})
		return
	}
	switch msg.T {
	case "hello":
		s.resume(c, msg.Token)
		return
	case "register", "login":
		s.authenticate(c, msg)
		return
	case "logout":
		s.disconnect(c)
		c.player = store.Player{}
		c.sendJSON(map[string]any{"t": "auth"})
		return
	}
	if c.player.ID == 0 {
		return // phải đăng nhập trước
	}
	switch msg.T {
	case "rooms":
		c.sendJSON(map[string]any{"t": "rooms", "rooms": s.roomList()})
	case "create":
		s.leaveRoom(c)
		name := cleanRoomName(msg.Name)
		if name == "" {
			name = "Phòng của " + c.name
		}
		pass := msg.Password
		if len(pass) > 32 {
			pass = pass[:32]
		}
		s.mu.Lock()
		s.nextRm++
		id := s.newRoomCode()
		room := newRoom(s, id, name)
		room.password, room.private, room.seq = pass, msg.Private, s.nextRm
		s.rooms[id] = room
		s.mu.Unlock()
		go room.run()
		s.joinRoom(c, room, pass)
	case "join":
		s.mu.Lock()
		room := s.rooms[strings.ToUpper(strings.TrimSpace(msg.Room))]
		s.mu.Unlock()
		if room == nil {
			c.sendJSON(map[string]any{"t": "error", "text": "Không tìm thấy phòng với mã này"})
			return
		}
		s.leaveRoom(c)
		s.joinRoom(c, room, msg.Password)
	case "leave":
		s.leaveRoom(c)
		c.sendJSON(map[string]any{"t": "rooms", "rooms": s.roomList()})
	default:
		s.mu.Lock()
		room := c.room
		s.mu.Unlock()
		if room != nil {
			room.input(c, msg)
		}
	}
}

func (s *Server) resume(c *Client, token string) {
	if token == "" {
		c.sendJSON(map[string]any{"t": "auth"})
		return
	}
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	p, err := s.st.Resume(ctx, token)
	if err != nil {
		c.sendJSON(map[string]any{"t": "auth", "text": err.Error()})
		return
	}
	s.startSession(c, p, token)
}

func (s *Server) authenticate(c *Client, msg inMsg) {
	user := strings.TrimSpace(msg.Username)
	key := strings.ToLower(user)
	s.mu.Lock()
	f := s.fails[key]
	locked := f != nil && time.Now().Before(f.until)
	s.mu.Unlock()
	if locked {
		c.sendJSON(map[string]any{"t": "auth", "text": "Sai mật khẩu quá nhiều lần, hãy thử lại sau ít phút"})
		return
	}
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	var p store.Player
	var token string
	var err error
	if msg.T == "register" {
		p, token, err = s.st.Register(ctx, user, msg.Password)
	} else {
		p, token, err = s.st.Login(ctx, user, msg.Password)
	}
	if err != nil {
		if err == store.ErrBadLogin {
			s.mu.Lock()
			if f == nil || time.Now().After(f.until.Add(loginLockout)) {
				f = &loginFail{}
				s.fails[key] = f
			}
			f.n++
			if f.n >= maxLoginFails {
				f.until = time.Now().Add(loginLockout)
				f.n = 0
				go s.st.LogCheat(context.Background(), 0, "bruteforce", "sai mật khẩu nhiều lần cho tài khoản "+key)
			}
			s.mu.Unlock()
		}
		c.sendJSON(map[string]any{"t": "auth", "text": err.Error()})
		return
	}
	s.mu.Lock()
	delete(s.fails, key)
	s.mu.Unlock()
	s.startSession(c, p, token)
}

func (s *Server) startSession(c *Client, p store.Player, token string) {
	c.player, c.name = p, p.Name

	// một tài khoản một kết nối: kết nối cũ bị thay thế
	s.mu.Lock()
	old := s.byPlayer[p.ID]
	s.byPlayer[p.ID] = c
	s.mu.Unlock()
	if old != nil && old != c {
		old.sendJSON(map[string]any{"t": "kicked", "text": "Tài khoản vừa đăng nhập ở nơi khác"})
		old.close()
	}
	c.sendJSON(map[string]any{"t": "session", "token": token, "playerId": p.ID, "name": p.Name})

	// vào lại trận đang chơi dở nếu vừa rớt mạng
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if rc, ok := s.st.GetReconnect(ctx, p.ID); ok {
		s.mu.Lock()
		room := s.rooms[rc.Room]
		s.mu.Unlock()
		if room != nil && room.rejoin(c) {
			s.mu.Lock()
			c.room = room
			s.mu.Unlock()
			return
		}
	}
	c.sendJSON(map[string]any{"t": "rooms", "rooms": s.roomList()})
}

// newRoomCode tạo mã phòng 5 ký tự dễ đọc (dùng để mời vào phòng riêng).
func (s *Server) newRoomCode() string {
	const abc = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"
	for {
		b := make([]byte, 5)
		rand.Read(b)
		for i := range b {
			b[i] = abc[int(b[i])%len(abc)]
		}
		if _, ok := s.rooms[string(b)]; !ok {
			return string(b)
		}
	}
}

func cleanRoomName(n string) string {
	n = strings.Map(func(r rune) rune {
		if unicode.IsControl(r) || r == '|' {
			return -1
		}
		return r
	}, strings.TrimSpace(n))
	if r := []rune(n); len(r) > 30 {
		n = string(r[:30])
	}
	return n
}

func (s *Server) joinRoom(c *Client, room *Room, password string) {
	if err := room.add(c, password); err != nil {
		c.sendJSON(map[string]any{"t": "error", "text": err.Error()})
		return
	}
	s.mu.Lock()
	c.room = room
	s.mu.Unlock()
}

func (s *Server) leaveRoom(c *Client) { s.detachFrom(c, false) }

func (s *Server) disconnect(c *Client) {
	s.mu.Lock()
	if s.byPlayer[c.player.ID] == c {
		delete(s.byPlayer, c.player.ID)
	}
	s.mu.Unlock()
	s.detachFrom(c, true)
}

// detachFrom gỡ client khỏi phòng; dropped = rớt mạng (được giữ chỗ để vào lại).
func (s *Server) detachFrom(c *Client, dropped bool) {
	s.mu.Lock()
	room := c.room
	c.room = nil
	s.mu.Unlock()
	if room == nil {
		return
	}
	room.remove(c, dropped)
	s.gcRoom(room)
}

func (s *Server) gcRoom(room *Room) {
	if room.alive() {
		return
	}
	s.mu.Lock()
	if s.rooms[room.id] == room {
		delete(s.rooms, room.id)
	}
	s.mu.Unlock()
	room.stop()
}

type roomInfo struct {
	ID      string `json:"id"`
	Name    string `json:"name"`
	Locked  bool   `json:"locked"`
	seq     int
	Players int    `json:"players"`
	Max     int    `json:"max"`
	State   string `json:"state"`
	Round   int    `json:"round"`
}

func (s *Server) roomList() []roomInfo {
	s.mu.Lock()
	rooms := make([]*Room, 0, len(s.rooms))
	for _, r := range s.rooms {
		rooms = append(rooms, r)
	}
	s.mu.Unlock()
	out := []roomInfo{}
	for _, r := range rooms {
		if r.private {
			continue // phòng riêng không hiện trong danh sách, vào bằng mã
		}
		out = append(out, r.info())
	}
	sort.Slice(out, func(i, j int) bool { return out[i].seq < out[j].seq })
	return out
}
