package store

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"strconv"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"
	"golang.org/x/crypto/bcrypt"
)

const schema = `
CREATE TABLE IF NOT EXISTS players (
	id          BIGSERIAL PRIMARY KEY,
	name        TEXT NOT NULL,
	token_hash  TEXT NOT NULL UNIQUE,
	created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
	last_seen   TIMESTAMPTZ NOT NULL DEFAULT now(),
	games       BIGINT NOT NULL DEFAULT 0,
	wins        BIGINT NOT NULL DEFAULT 0,
	total_score BIGINT NOT NULL DEFAULT 0,
	best_round  BIGINT NOT NULL DEFAULT 0,
	banned      BOOLEAN NOT NULL DEFAULT false
);
CREATE INDEX IF NOT EXISTS players_score_idx ON players (total_score DESC);
ALTER TABLE players ADD COLUMN IF NOT EXISTS username TEXT;
ALTER TABLE players ADD COLUMN IF NOT EXISTS password_hash TEXT;
CREATE UNIQUE INDEX IF NOT EXISTS players_username_idx ON players (lower(username));

CREATE TABLE IF NOT EXISTS matches (
	id         BIGSERIAL PRIMARY KEY,
	room_name  TEXT NOT NULL,
	started_at TIMESTAMPTZ NOT NULL,
	ended_at   TIMESTAMPTZ NOT NULL,
	result     TEXT NOT NULL,
	rounds     INT NOT NULL,
	inputs     BYTEA
);

CREATE TABLE IF NOT EXISTS match_players (
	match_id  BIGINT NOT NULL REFERENCES matches(id) ON DELETE CASCADE,
	player_id BIGINT NOT NULL REFERENCES players(id) ON DELETE CASCADE,
	slot      INT NOT NULL,
	name      TEXT NOT NULL,
	score     INT NOT NULL,
	level     INT NOT NULL,
	deaths    INT NOT NULL,
	revives   INT NOT NULL,
	gold      INT NOT NULL,
	PRIMARY KEY (match_id, player_id)
);

CREATE TABLE IF NOT EXISTS cheat_events (
	id        BIGSERIAL PRIMARY KEY,
	player_id BIGINT REFERENCES players(id) ON DELETE SET NULL,
	kind      TEXT NOT NULL,
	detail    TEXT NOT NULL,
	at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
`

const (
	keySession = "goku:session:"    // token hash -> player id (cache)
	keyReconn  = "goku:reconnect:"  // player id -> json Reconnect
	keyLB      = "goku:leaderboard" // ZSET player id -> total score
	keyLBCache = "goku:leaderboard:rows"
)

// Postgres lưu dữ liệu bền vững; Redis (nếu có) giữ phiên, thông tin vào
// lại trận và cache bảng xếp hạng.
type Postgres struct {
	db  *pgxpool.Pool
	rdb *redis.Client
}

func NewPostgres(ctx context.Context, dsn, redisURL string) (*Postgres, error) {
	cfg, err := pgxpool.ParseConfig(dsn)
	if err != nil {
		return nil, err
	}
	cfg.MaxConns = 10
	var db *pgxpool.Pool
	for i := 0; i < 30; i++ { // chờ container Postgres khởi động
		if db, err = pgxpool.NewWithConfig(ctx, cfg); err == nil {
			if err = db.Ping(ctx); err == nil {
				break
			}
			db.Close()
		}
		time.Sleep(time.Second)
	}
	if err != nil {
		return nil, fmt.Errorf("kết nối Postgres: %w", err)
	}
	if _, err := db.Exec(ctx, schema); err != nil {
		return nil, fmt.Errorf("tạo bảng: %w", err)
	}
	s := &Postgres{db: db}
	if redisURL != "" {
		opt, err := redis.ParseURL(redisURL)
		if err != nil {
			return nil, err
		}
		s.rdb = redis.NewClient(opt)
		if err := s.rdb.Ping(ctx).Err(); err != nil {
			return nil, fmt.Errorf("kết nối Redis: %w", err)
		}
	}
	return s, nil
}

func (s *Postgres) Close() {
	s.db.Close()
	if s.rdb != nil {
		s.rdb.Close()
	}
}

func (s *Postgres) Register(ctx context.Context, username, password string) (Player, string, error) {
	if err := CheckCredentials(username, password); err != nil {
		return Player{}, "", err
	}
	h, err := hashPassword(password)
	if err != nil {
		return Player{}, "", err
	}
	t := newToken()
	var id int64
	err = s.db.QueryRow(ctx, `INSERT INTO players (name, username, password_hash, token_hash) VALUES ($1,$1,$2,$3) RETURNING id`,
		username, h, hashToken(t)).Scan(&id)
	if err != nil {
		if strings.Contains(err.Error(), "players_username_idx") {
			return Player{}, "", ErrTaken
		}
		return Player{}, "", err
	}
	return Player{ID: id, Name: username}, t, nil
}

func (s *Postgres) Login(ctx context.Context, username, password string) (Player, string, error) {
	var id int64
	var name, hash string
	var banned bool
	err := s.db.QueryRow(ctx, `SELECT id, username, COALESCE(password_hash,''), banned FROM players WHERE lower(username)=lower($1)`, username).Scan(&id, &name, &hash, &banned)
	if err == pgx.ErrNoRows || (err == nil && hash == "") {
		bcrypt.CompareHashAndPassword(dummyHash, []byte(password))
		return Player{}, "", ErrBadLogin
	}
	if err != nil {
		return Player{}, "", err
	}
	if !checkPassword(hash, password) {
		return Player{}, "", ErrBadLogin
	}
	if banned {
		return Player{}, "", ErrBanned
	}
	t := newToken()
	if _, err := s.db.Exec(ctx, `UPDATE players SET token_hash=$1, last_seen=now() WHERE id=$2`, hashToken(t), id); err != nil {
		return Player{}, "", err
	}
	return Player{ID: id, Name: name}, t, nil
}

func (s *Postgres) Resume(ctx context.Context, token string) (Player, error) {
	if !validToken(token) {
		return Player{}, ErrBadSession
	}
	var id int64
	var name string
	var banned bool
	err := s.db.QueryRow(ctx, `SELECT id, COALESCE(username,name), banned FROM players WHERE token_hash=$1 AND password_hash IS NOT NULL`, hashToken(token)).Scan(&id, &name, &banned)
	if err == pgx.ErrNoRows {
		return Player{}, ErrBadSession
	}
	if err != nil {
		return Player{}, err
	}
	if banned {
		return Player{}, ErrBanned
	}
	s.db.Exec(ctx, `UPDATE players SET last_seen=now() WHERE id=$1`, id)
	return Player{ID: id, Name: name}, nil
}

func (s *Postgres) SaveMatch(ctx context.Context, m Match) error {
	tx, err := s.db.Begin(ctx)
	if err != nil {
		return err
	}
	defer tx.Rollback(ctx)
	var mid int64
	err = tx.QueryRow(ctx, `INSERT INTO matches (room_name, started_at, ended_at, result, rounds, inputs) VALUES ($1,$2,$3,$4,$5,$6) RETURNING id`,
		m.RoomName, m.StartedAt, m.EndedAt, m.Result, m.Rounds, m.Inputs).Scan(&mid)
	if err != nil {
		return err
	}
	win := 0
	if m.Result == "victory" {
		win = 1
	}
	for _, p := range m.Players {
		if _, err := tx.Exec(ctx, `INSERT INTO match_players (match_id, player_id, slot, name, score, level, deaths, revives, gold) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
			mid, p.PlayerID, p.Slot, p.Name, p.Score, p.Level, p.Deaths, p.Revives, p.Gold); err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, `UPDATE players SET games=games+1, wins=wins+$2, total_score=total_score+$3, best_round=GREATEST(best_round,$4) WHERE id=$1`,
			p.PlayerID, win, p.Score, m.Rounds); err != nil {
			return err
		}
	}
	if err := tx.Commit(ctx); err != nil {
		return err
	}
	if s.rdb != nil {
		pipe := s.rdb.TxPipeline()
		for _, p := range m.Players {
			pipe.ZIncrBy(ctx, keyLB, float64(p.Score), strconv.FormatInt(p.PlayerID, 10))
		}
		pipe.Del(ctx, keyLBCache)
		_, _ = pipe.Exec(ctx)
	}
	return nil
}

func (s *Postgres) LogCheat(ctx context.Context, playerID int64, kind, detail string) {
	log.Printf("[chống gian lận] player=%d %s: %s", playerID, kind, detail)
	var pid any
	if playerID > 0 {
		pid = playerID
	}
	if _, err := s.db.Exec(ctx, `INSERT INTO cheat_events (player_id, kind, detail) VALUES ($1,$2,$3)`, pid, kind, detail); err != nil {
		log.Println("ghi cheat_events:", err)
	}
}

// Leaderboard đọc từ cache Redis (30s), hết hạn thì truy vấn Postgres.
func (s *Postgres) Leaderboard(ctx context.Context, n int) ([]LeaderRow, error) {
	if s.rdb != nil {
		if b, err := s.rdb.Get(ctx, keyLBCache).Bytes(); err == nil {
			var rows []LeaderRow
			if json.Unmarshal(b, &rows) == nil {
				return rows, nil
			}
		}
	}
	r, err := s.db.Query(ctx, `SELECT id, name, total_score, games, wins, best_round FROM players WHERE games > 0 AND NOT banned ORDER BY total_score DESC, wins DESC LIMIT $1`, n)
	if err != nil {
		return nil, err
	}
	defer r.Close()
	rows := []LeaderRow{}
	for r.Next() {
		var x LeaderRow
		if err := r.Scan(&x.PlayerID, &x.Name, &x.TotalScore, &x.Games, &x.Wins, &x.BestRound); err != nil {
			return nil, err
		}
		rows = append(rows, x)
	}
	if s.rdb != nil {
		if b, err := json.Marshal(rows); err == nil {
			s.rdb.Set(ctx, keyLBCache, b, 30*time.Second)
		}
	}
	return rows, r.Err()
}

func (s *Postgres) SetReconnect(ctx context.Context, id int64, r Reconnect, ttl time.Duration) {
	if s.rdb == nil {
		return
	}
	b, _ := json.Marshal(r)
	s.rdb.Set(ctx, keyReconn+strconv.FormatInt(id, 10), b, ttl)
}

func (s *Postgres) GetReconnect(ctx context.Context, id int64) (Reconnect, bool) {
	if s.rdb == nil {
		return Reconnect{}, false
	}
	b, err := s.rdb.Get(ctx, keyReconn+strconv.FormatInt(id, 10)).Bytes()
	if err != nil {
		return Reconnect{}, false
	}
	var r Reconnect
	return r, json.Unmarshal(b, &r) == nil
}

func (s *Postgres) ClearReconnect(ctx context.Context, id int64) {
	if s.rdb != nil {
		s.rdb.Del(ctx, keyReconn+strconv.FormatInt(id, 10))
	}
}
