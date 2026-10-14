package store

import (
	"context"
	"log"
	"sort"
	"sync"
	"time"

	"golang.org/x/crypto/bcrypt"
)

// Memory là Store trong bộ nhớ, dùng khi chạy dev không có Postgres/Redis.
type Memory struct {
	mu       sync.Mutex
	nextID   int64
	byToken  map[string]*memPlayer
	byUser   map[string]*memPlayer
	players  map[int64]*memPlayer
	reconn   map[int64]memReconn
	matches  int
	cheatLog int
}

type memPlayer struct {
	LeaderRow
	pass string
}

type memReconn struct {
	r   Reconnect
	exp time.Time
}

func NewMemory() *Memory {
	return &Memory{byToken: map[string]*memPlayer{}, byUser: map[string]*memPlayer{}, players: map[int64]*memPlayer{}, reconn: map[int64]memReconn{}}
}

func (m *Memory) Register(_ context.Context, username, password string) (Player, string, error) {
	if err := CheckCredentials(username, password); err != nil {
		return Player{}, "", err
	}
	h, err := hashPassword(password)
	if err != nil {
		return Player{}, "", err
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	if _, ok := m.byUser[normUser(username)]; ok {
		return Player{}, "", ErrTaken
	}
	m.nextID++
	p := &memPlayer{LeaderRow: LeaderRow{PlayerID: m.nextID, Name: username}, pass: h}
	m.players[p.PlayerID] = p
	m.byUser[normUser(username)] = p
	t := newToken()
	m.byToken[hashToken(t)] = p
	return Player{ID: p.PlayerID, Name: username}, t, nil
}

func (m *Memory) Login(_ context.Context, username, password string) (Player, string, error) {
	m.mu.Lock()
	p := m.byUser[normUser(username)]
	m.mu.Unlock()
	if p == nil {
		bcrypt.CompareHashAndPassword(dummyHash, []byte(password))
		return Player{}, "", ErrBadLogin
	}
	if !checkPassword(p.pass, password) {
		return Player{}, "", ErrBadLogin
	}
	m.mu.Lock()
	defer m.mu.Unlock()
	for k, v := range m.byToken { // một phiên mỗi tài khoản
		if v == p {
			delete(m.byToken, k)
		}
	}
	t := newToken()
	m.byToken[hashToken(t)] = p
	return Player{ID: p.PlayerID, Name: p.Name}, t, nil
}

func (m *Memory) Resume(_ context.Context, token string) (Player, error) {
	m.mu.Lock()
	defer m.mu.Unlock()
	p, ok := m.byToken[hashToken(token)]
	if !ok || !validToken(token) {
		return Player{}, ErrBadSession
	}
	return Player{ID: p.PlayerID, Name: p.Name}, nil
}

func (m *Memory) SaveMatch(_ context.Context, mt Match) error {
	m.mu.Lock()
	defer m.mu.Unlock()
	m.matches++
	for _, mp := range mt.Players {
		p := m.players[mp.PlayerID]
		if p == nil {
			continue
		}
		p.Games++
		p.TotalScore += int64(mp.Score)
		if mt.Result == "victory" {
			p.Wins++
		}
		p.BestRound = max(p.BestRound, int64(mt.Rounds))
	}
	return nil
}

func (m *Memory) LogCheat(_ context.Context, playerID int64, kind, detail string) {
	m.mu.Lock()
	m.cheatLog++
	m.mu.Unlock()
	log.Printf("[chống gian lận] player=%d %s: %s", playerID, kind, detail)
}

func (m *Memory) Leaderboard(_ context.Context, n int) ([]LeaderRow, error) {
	m.mu.Lock()
	defer m.mu.Unlock()
	out := []LeaderRow{}
	for _, p := range m.players {
		if p.Games > 0 {
			out = append(out, p.LeaderRow)
		}
	}
	sort.Slice(out, func(i, j int) bool { return out[i].TotalScore > out[j].TotalScore })
	if len(out) > n {
		out = out[:n]
	}
	return out, nil
}

func (m *Memory) SetReconnect(_ context.Context, id int64, r Reconnect, ttl time.Duration) {
	m.mu.Lock()
	m.reconn[id] = memReconn{r, time.Now().Add(ttl)}
	m.mu.Unlock()
}

func (m *Memory) GetReconnect(_ context.Context, id int64) (Reconnect, bool) {
	m.mu.Lock()
	defer m.mu.Unlock()
	r, ok := m.reconn[id]
	if !ok || time.Now().After(r.exp) {
		return Reconnect{}, false
	}
	return r.r, true
}

func (m *Memory) ClearReconnect(_ context.Context, id int64) {
	m.mu.Lock()
	delete(m.reconn, id)
	m.mu.Unlock()
}

func (m *Memory) Close() {}
