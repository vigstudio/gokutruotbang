package netserver

import (
	"bytes"
	"compress/gzip"
	"context"
	"crypto/subtle"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"math"
	"regexp"
	"sort"
	"strconv"
	"strings"
	"sync"
	"time"

	"gokutruotbang/internal/game"
	"gokutruotbang/internal/store"
)

const (
	reconnectGrace = 60 * time.Second // giữ chỗ cho người rớt mạng
	loadTimeout    = 25 * time.Second // chờ tải tối đa trước khi bắt đầu
	maxInputLog    = 200000
)

type member struct {
	c     *Client
	slot  int
	ready bool
	view  game.View // vùng camera client báo lên (chỉ gửi rồng trong vùng này)
}

type away struct {
	slot   int
	name   string
	until  time.Time
	player int64
}

// Room là một phòng chơi: sảnh chờ (lobby) rồi tới trận đấu.
type Room struct {
	srv      *Server
	id       string
	name     string
	password string // rỗng = không khoá
	private  bool   // không hiện trong danh sách phòng
	seq      int

	mu      sync.Mutex
	members map[int]*member // theo client id
	away    map[int64]*away // theo player id, người rớt mạng trong trận
	host    int64           // player id của chủ phòng
	state   string          // "lobby" | "game"
	g       *game.Game

	startedAt  time.Time
	loadUntil  time.Time
	slotPlayer map[int]store.MatchPlayer
	inputs     [][]any // [tick, slot, loại, ab, x, y]
	saved      bool

	quit chan struct{}
	once sync.Once
}

func newRoom(s *Server, id, name string) *Room {
	return &Room{srv: s, id: id, name: name, members: map[int]*member{}, away: map[int64]*away{}, state: "lobby", quit: make(chan struct{})}
}

func (r *Room) stop() { r.once.Do(func() { close(r.quit) }) }

func (r *Room) alive() bool {
	r.mu.Lock()
	defer r.mu.Unlock()
	return len(r.members) > 0 || len(r.away) > 0
}

func (r *Room) info() roomInfo {
	r.mu.Lock()
	defer r.mu.Unlock()
	ri := roomInfo{ID: r.id, Name: r.name, Locked: r.password != "", seq: r.seq, Players: len(r.members) + len(r.away), Max: game.MaxPlayers, State: r.state}
	if r.g != nil {
		ri.Round = min(r.g.Round, game.FinalRound)
	}
	return ri
}

func (r *Room) add(c *Client, password string) error {
	r.mu.Lock()
	defer r.mu.Unlock()
	if r.password != "" && subtle.ConstantTimeCompare([]byte(r.password), []byte(password)) != 1 {
		return errors.New("Sai mật khẩu phòng")
	}
	if r.state != "lobby" {
		return errors.New("Trận đấu đang diễn ra, hãy đợi ván sau")
	}
	if len(r.members) >= game.MaxPlayers {
		return errors.New("Phòng đã đủ 11 người")
	}
	used := map[int]bool{}
	for _, m := range r.members {
		used[m.slot] = true
		if m.c.player.ID == c.player.ID {
			return errors.New("Bạn đã ở trong phòng này")
		}
	}
	slot := 0
	for used[slot] {
		slot++
	}
	r.members[c.id] = &member{c: c, slot: slot}
	if len(r.members) == 1 {
		r.host = c.player.ID
	}
	r.broadcastRoomLocked()
	return nil
}

// rejoin đưa người chơi vừa rớt mạng trở lại đúng slot của họ.
func (r *Room) rejoin(c *Client) bool {
	r.mu.Lock()
	defer r.mu.Unlock()
	a := r.away[c.player.ID]
	if a == nil || r.g == nil {
		return false
	}
	delete(r.away, c.player.ID)
	r.members[c.id] = &member{c: c, slot: a.slot, ready: true}
	r.srv.st.ClearReconnect(context.Background(), c.player.ID)
	r.broadcastLocked(map[string]any{"t": "chat", "slot": -1, "text": c.name + " đã kết nối lại."})
	r.broadcastRoomLocked()
	return true
}

func (r *Room) remove(c *Client, dropped bool) {
	r.mu.Lock()
	defer r.mu.Unlock()
	m := r.members[c.id]
	if m == nil {
		return
	}
	delete(r.members, c.id)
	inMatch := r.g != nil && (r.g.Phase == game.PhaseLoading || r.g.Phase == game.PhaseCountdown || r.g.Phase == game.PhasePlaying || r.g.Phase == game.PhaseIntermission)
	switch {
	case inMatch && dropped:
		// giữ Goku trong trận, chờ người chơi kết nối lại
		r.away[c.player.ID] = &away{slot: m.slot, name: c.name, until: time.Now().Add(reconnectGrace), player: c.player.ID}
		r.srv.st.SetReconnect(context.Background(), c.player.ID, store.Reconnect{Room: r.id, Slot: m.slot}, reconnectGrace)
		r.broadcastLocked(map[string]any{"t": "chat", "slot": -1, "text": fmt.Sprintf("%s mất kết nối, chờ %d giây để vào lại…", c.name, int(reconnectGrace.Seconds()))})
	case r.g != nil:
		r.g.RemovePlayer(m.slot)
		r.broadcastLocked(map[string]any{"t": "chat", "slot": -1, "text": c.name + " đã ra khỏi game!"})
	}
	if r.host == c.player.ID {
		r.pickHostLocked()
	}
	if len(r.members) > 0 {
		r.broadcastRoomLocked()
	}
}

func (r *Room) pickHostLocked() {
	r.host = 0
	best := -1
	for _, mm := range r.members {
		if best < 0 || mm.slot < best {
			best, r.host = mm.slot, mm.c.player.ID
		}
	}
}

var reKick = regexp.MustCompile(`^-ki[cč]?[kh]\s+p?(\d+)$`)

func (r *Room) input(c *Client, msg inMsg) {
	r.mu.Lock()
	defer r.mu.Unlock()
	m := r.members[c.id]
	if m == nil {
		return
	}
	isHost := c.player.ID == r.host
	switch msg.T {
	case "start":
		if !isHost || r.state != "lobby" {
			return
		}
		players := map[int]string{}
		r.slotPlayer = map[int]store.MatchPlayer{}
		for _, mm := range r.members {
			players[mm.slot] = mm.c.name
			r.slotPlayer[mm.slot] = store.MatchPlayer{PlayerID: mm.c.player.ID, Name: mm.c.name, Slot: mm.slot}
			mm.ready = false
		}
		r.g = game.New(r.srv.m, players, time.Now().UnixNano())
		r.g.Hold()
		r.state = "game"
		r.startedAt = time.Now()
		r.loadUntil = time.Now().Add(loadTimeout)
		r.inputs = nil
		r.saved = false
		r.broadcastRoomLocked()
		return
	case "ready":
		m.ready = true
		return
	case "cam": // vùng camera: tâm (x, y), bán kính c
		if !math.IsNaN(msg.X+msg.Y+msg.C) && !math.IsInf(msg.X+msg.Y+msg.C, 0) {
			m.view = game.View{X: msg.X, Y: msg.Y, R: math.Max(600, math.Min(game.MaxViewRadius, msg.C)), Set: true}
		}
		return
	case "lobby":
		if !isHost || r.g == nil || (r.g.Phase != game.PhaseVictory && r.g.Phase != game.PhaseDefeat) {
			return
		}
		r.g = nil
		r.state = "lobby"
		for id, a := range r.away {
			r.srv.st.ClearReconnect(context.Background(), a.player)
			delete(r.away, id)
		}
		r.broadcastRoomLocked()
		return
	case "chat":
		text := strings.TrimSpace(msg.Text)
		if text == "" {
			return
		}
		if rs := []rune(text); len(rs) > 200 {
			text = string(rs[:200])
		}
		// Kick2..Kick11: chủ phòng gõ "-kick p2" (bản gốc là "-kich p2").
		if km := reKick.FindStringSubmatch(strings.ToLower(text)); km != nil && isHost {
			n, _ := strconv.Atoi(km[1])
			r.kickLocked(n - 1)
			return
		}
		r.broadcastLocked(map[string]any{"t": "chat", "slot": m.slot, "name": c.name, "text": text})
		return
	}
	if r.g == nil {
		return
	}
	switch msg.T {
	case "order":
		r.g.Order(m.slot, msg.X, msg.Y)
	case "stop":
		r.g.Stop(m.slot)
	case "cast":
		r.g.Cast(m.slot, msg.Ab, msg.X, msg.Y)
	case "learn":
		r.g.Learn(m.slot, msg.Ab)
	case "buy":
		r.g.Buy(m.slot, msg.Ab)
	case "sell":
		r.g.Sell(m.slot, int(msg.X))
	case "craft":
		r.g.Craft(m.slot, msg.Ab)
	case "use":
		r.g.UseItem(m.slot, int(msg.X))
	case "wish":
		r.g.MakeWish(m.slot, msg.Ab)
	default:
		return
	}
	r.g.Ack(m.slot, msg.Seq)
	if len(r.inputs) < maxInputLog {
		r.inputs = append(r.inputs, []any{r.g.TickNo, m.slot, msg.T, msg.Ab, int(msg.X), int(msg.Y)})
	}
}

func (r *Room) kickLocked(slot int) {
	for id, mm := range r.members {
		if mm.slot == slot && mm.c.player.ID != r.host {
			if r.g != nil {
				r.g.Kick(slot)
			}
			mm.c.sendJSON(map[string]any{"t": "kicked", "text": "Bị kick rồi!"})
			delete(r.members, id)
			go r.srv.detachKicked(mm.c, r)
			r.broadcastRoomLocked()
			return
		}
	}
}

func (s *Server) detachKicked(c *Client, room *Room) {
	s.mu.Lock()
	if c.room == room {
		c.room = nil
	}
	s.mu.Unlock()
	c.sendJSON(map[string]any{"t": "rooms", "rooms": s.roomList()})
}

func (r *Room) run() {
	tick := time.NewTicker(time.Second / game.TickRate)
	defer tick.Stop()
	dt := 1.0 / game.TickRate
	every := game.TickRate / game.SnapshotRate
	n := 0
	for {
		select {
		case <-r.quit:
			return
		case <-tick.C:
		}
		t0 := time.Now()
		r.mu.Lock()
		if r.g != nil {
			r.stepLocked(dt)
			n++
			if n%every == 0 {
				r.sendSnapshotsLocked(n%(every*12) == 0)
			}
		}
		expired := r.expireAwayLocked()
		r.mu.Unlock()
		metrics.tick(time.Since(t0))
		if expired && !r.alive() {
			r.srv.gcRoom(r)
			return
		}
	}
}

func (r *Room) stepLocked(dt float64) {
	g := r.g
	if g.Phase == game.PhaseLoading {
		all := true
		for _, m := range r.members {
			all = all && m.ready
		}
		if all || time.Now().After(r.loadUntil) {
			g.Start()
		}
	}
	g.Tick(dt)
	if ev := g.DrainEvents(); len(ev) > 0 {
		r.broadcastLocked(map[string]any{"t": "events", "events": ev})
	}
	if !r.saved && (g.Phase == game.PhaseVictory || g.Phase == game.PhaseDefeat) {
		r.saved = true
		r.saveMatchLocked(string(g.Phase))
	}
}

func (r *Room) expireAwayLocked() bool {
	now := time.Now()
	changed := false
	for id, a := range r.away {
		if now.After(a.until) {
			delete(r.away, id)
			if r.g != nil {
				r.g.RemovePlayer(a.slot)
			}
			r.broadcastLocked(map[string]any{"t": "chat", "slot": -1, "text": a.name + " đã ra khỏi game!"})
			changed = true
		}
	}
	return changed
}

// saveMatchLocked lưu kết quả + log lệnh (gzip) vào database ở goroutine riêng.
func (r *Room) saveMatchLocked(result string) {
	mt := store.Match{
		RoomName: r.name, StartedAt: r.startedAt, EndedAt: time.Now(), Result: result,
		Rounds: min(r.g.Round, game.FinalRound),
	}
	if result == "victory" {
		mt.Rounds = game.FinalRound
	}
	for slot, h := range r.g.Heroes {
		mp, ok := r.slotPlayer[slot]
		if !ok {
			continue
		}
		mp.Score, mp.Level, mp.Deaths, mp.Revives, mp.Gold = h.Score, h.Level, h.Deaths, h.Revives, h.Gold
		mt.Players = append(mt.Players, mp)
	}
	var buf bytes.Buffer
	zw := gzip.NewWriter(&buf)
	json.NewEncoder(zw).Encode(r.inputs)
	zw.Close()
	mt.Inputs = buf.Bytes()
	go func() {
		ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()
		if err := r.srv.st.SaveMatch(ctx, mt); err != nil {
			log.Println("lưu trận:", err)
		}
	}()
}

// sendSnapshotsLocked: mỗi người một snapshot riêng (Goku của mình đầy đủ,
// rồng chỉ trong vùng nhìn); `minimap` = kèm vị trí thô mọi con rồng (~2 lần/s).
func (r *Room) sendSnapshotsLocked(minimap bool) {
	for _, m := range r.members {
		b, err := json.Marshal(r.g.SnapshotFor(m.slot, m.view, minimap))
		if err != nil {
			continue
		}
		m.c.sendRaw(b)
	}
}

func (r *Room) broadcastLocked(v any) {
	b, err := json.Marshal(v)
	if err != nil {
		return
	}
	for _, m := range r.members {
		m.c.sendRaw(b)
	}
}

type memberInfo struct {
	ID    int64  `json:"id"`
	Name  string `json:"name"`
	Slot  int    `json:"slot"`
	Color string `json:"color"`
	Away  bool   `json:"away,omitempty"`
}

func (r *Room) broadcastRoomLocked() {
	list := []memberInfo{}
	for _, m := range r.members {
		list = append(list, memberInfo{ID: m.c.player.ID, Name: m.c.name, Slot: m.slot, Color: game.PlayerColors[m.slot]})
	}
	for _, a := range r.away {
		list = append(list, memberInfo{ID: a.player, Name: a.name, Slot: a.slot, Color: game.PlayerColors[a.slot], Away: true})
	}
	sort.Slice(list, func(i, j int) bool { return list[i].Slot < list[j].Slot })
	for _, m := range r.members {
		m.c.sendJSON(map[string]any{
			"t": "room", "id": r.id, "name": r.name, "host": r.host, "state": r.state,
			"members": list, "you": m.c.player.ID, "slot": m.slot,
			"private": r.private, "locked": r.password != "",
		})
	}
}
