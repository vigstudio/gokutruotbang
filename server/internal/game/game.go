// Package game là bản port logic của map "Goku truot bang" sang Go: server
// mô phỏng toàn bộ trận đấu, client chỉ gửi lệnh và vẽ lại trạng thái.
package game

import (
	"fmt"
	"math"
	"math/rand"
	"sort"
	"strings"

	"gokutruotbang/internal/mapdata"
)

type Phase string

const (
	PhaseLoading      Phase = "loading"   // chờ mọi người tải xong
	PhaseCountdown    Phase = "countdown" // đếm ngược trước khi chạy
	PhasePlaying      Phase = "playing"
	PhaseIntermission Phase = "intermission"
	PhaseVictory      Phase = "victory"
	PhaseDefeat       Phase = "defeat"
)

type Hero struct {
	Slot   int
	Name   string
	X, Y   float64
	Facing float64 // độ, 0 = hướng đông, ngược chiều kim đồng hồ
	Alive  bool
	OnIce  bool

	moving     bool
	tx, ty     float64
	startX     float64
	startY     float64
	checkpoint int             // GetUnitUserData: vùng Lvl cao nhất đã qua trong vòng
	inGuard    map[string]bool // để bắt sự kiện "đi vào" SideGuard

	Level       int
	XP          int
	SkillPoints int
	AbLevel     map[string]int
	Cooldown    map[string]float64
	Mana        float64

	FlyHeight  float64
	jumpPhase  int // 0 không nhảy, 1 lên, 2 xuống chậm, 3 hạ cánh
	jumpTimer  float64
	realSpd    float64 // udg_REALSPDn
	driftTimer float64
	windWalk   float64
	wwBonus    float64

	Score     int
	Gold      int
	aliveFlag bool // udg_Alive

	Deaths  int
	Revives int

	Inv           [InvSlots]InvSlot
	Balls         uint8 // Ngọc Rồng đã có (bit 0 = 1 sao ... bit 6 = 7 sao)
	speedPot      float64
	invuln        float64
	pendingRevive bool // đã dùng Bùa Hồi Sinh, đang chờ sống lại
	tomePow       int

	LastSeq uint32 // số thứ tự lệnh cuối cùng đã xử lý (để client đối chiếu dự đoán)
}

func (h *Hero) maxMana() float64 { return 225 + 25*float64(h.Level-1) + h.manaBonus() }
func (h *Hero) manaRegen() float64 {
	return (1.0 + 0.1*float64(h.Level-1)) * h.regenMul()
}

func (h *Hero) moveSpeed() float64 {
	s := HeroBaseSpeed * (1 + h.wwBonus + h.speedBonus())
	return math.Min(s, HeroMaxSpeed)
}

type Dragon struct {
	ID     int
	Big    bool // n001 "Rồng đại ca": to nhưng không giết người
	X, Y   float64
	Facing float64
	HP     float64
	MaxHP  float64
	home   mapdata.Rect
	moving bool
	tx, ty float64
	idle   float64
}

type blocker struct{ X, Y, R float64 }

type Marker struct { // n00D "Goku Zone" - chỗ đồng đội chết
	Slot int
	X, Y float64
}

type Thaw struct {
	Corner int
	Until  float64
	Active bool
}

type Event struct {
	Kind string  `json:"kind"`
	Slot int     `json:"slot"`
	By   int     `json:"by,omitempty"`
	Ab   string  `json:"ab,omitempty"`
	X    float64 `json:"x,omitempty"`
	Y    float64 `json:"y,omitempty"`
	TX   float64 `json:"tx,omitempty"`
	TY   float64 `json:"ty,omitempty"`
	Text string  `json:"text,omitempty"`
	Dur  float64 `json:"dur,omitempty"`
}

type timer struct {
	at float64
	fn func()
}

type Game struct {
	m   *mapdata.Map
	rng *rand.Rand

	TickNo        int64
	Time          float64
	CountdownLeft float64
	Phase         Phase
	Round         int
	Heroes        map[int]*Hero

	dragons   []*Dragon
	nextID    int
	markers   map[int]*Marker
	thaws     []*Thaw
	thawCount []int

	timers []timer
	events []Event

	boxes   []*Box
	boxID   int
	nextBox float64

	starts      map[int][2]float64
	blockers    []blocker // vật trang trí chặn đường (pha lê, cột băng...)
	guards      map[string]mapdata.Rect
	checkpoints []mapdata.Rect
}

// New tạo trận mới cho các slot đang có người (trigger Not_here xóa Goku
// của slot trống).
func New(m *mapdata.Map, players map[int]string, seed int64) *Game {
	g := &Game{
		m:         m,
		rng:       rand.New(rand.NewSource(seed)),
		Phase:     PhasePlaying,
		Round:     1,
		Heroes:    map[int]*Hero{},
		markers:   map[int]*Marker{},
		thawCount: make([]int, m.Terrain.Cols*m.Terrain.Rows),
		starts:    map[int][2]float64{},
		guards:    map[string]mapdata.Rect{},
	}
	for name, r := range m.Regions {
		if strings.HasPrefix(name, "SideGuard") {
			g.guards[name] = r
		}
	}
	for i := 1; i <= 14; i++ {
		g.checkpoints = append(g.checkpoints, m.Regions[fmt.Sprintf("Lvl%d", i)])
	}

	for _, d := range m.Doodads {
		if r := DoodadBlockRadius[d.Type]; r > 0 {
			sc := d.Scale
			if sc <= 0 {
				sc = 1
			}
			g.blockers = append(g.blockers, blocker{d.X, d.Y, r * sc})
		}
	}
	for _, u := range m.Units {
		switch u.Type {
		case "E000":
			g.starts[u.Owner] = [2]float64{u.X, u.Y}
		case "nwwg":
			g.addDragon(u.X, u.Y, u.Facing, false, g.homeFor(u.X, u.Y))
		case "n001":
			g.addDragon(u.X, u.Y, u.Facing, true, g.homeFor(u.X, u.Y))
		}
	}
	for slot, name := range players {
		st, ok := g.starts[slot]
		if !ok {
			continue
		}
		h := &Hero{
			Slot: slot, Name: name, X: st[0], Y: st[1], Facing: 285,
			Alive: true, startX: st[0], startY: st[1],
			Level: 1, SkillPoints: 1,
			AbLevel: map[string]int{}, Cooldown: map[string]float64{},
			realSpd: 1, Gold: StartGold, aliveFlag: true,
			inGuard: map[string]bool{},
		}
		h.Mana = h.maxMana()
		g.Heroes[slot] = h
	}
	return g
}

// Hold giữ trận ở trạng thái chờ tải (mọi thứ đứng yên).
func (g *Game) Hold() { g.Phase = PhaseLoading }

// CountdownSeconds: thời gian đếm ngược trước khi trận bắt đầu.
const CountdownSeconds = 5.0

// Start bắt đầu đếm ngược sau khi mọi người đã tải xong.
func (g *Game) Start() {
	if g.Phase != PhaseLoading {
		return
	}
	g.Phase = PhaseCountdown
	g.CountdownLeft = CountdownSeconds
	g.emit(Event{Kind: "msg", Text: msgWelcome, Dur: 6})
}

// Ack ghi nhận lệnh có số thứ tự seq của slot đã được xử lý.
func (g *Game) Ack(slot int, seq uint32) {
	if h := g.Heroes[slot]; h != nil && seq > h.LastSeq {
		h.LastSeq = seq
	}
}

// validPoint loại toạ độ NaN/Inf hoặc nằm quá xa bản đồ (client gian lận/lỗi).
func (g *Game) validPoint(x, y float64) bool {
	if math.IsNaN(x) || math.IsNaN(y) || math.IsInf(x, 0) || math.IsInf(y, 0) {
		return false
	}
	b := g.m.Bounds
	return x > b.MinX-2000 && x < b.MaxX+2000 && y > b.MinY-2000 && y < b.MaxY+2000
}

func (g *Game) homeFor(x, y float64) mapdata.Rect {
	for _, n := range wolfAreas {
		if r, ok := g.m.Regions[n]; ok && mapdata.Contains(r, x, y) {
			return r
		}
	}
	return mapdata.Rect{MinX: x - 300, MinY: y - 300, MaxX: x + 300, MaxY: y + 300}
}

func (g *Game) addDragon(x, y, facing float64, big bool, home mapdata.Rect) {
	g.nextID++
	hp := DragonHP
	if big {
		hp = BigDragonHP
	}
	g.dragons = append(g.dragons, &Dragon{
		ID: g.nextID, Big: big, X: x, Y: y, Facing: facing, HP: hp, MaxHP: hp, home: home,
		idle: g.rng.Float64() * 2,
	})
}

func (g *Game) emit(e Event) { g.events = append(g.events, e) }

// DrainEvents trả về các sự kiện phát sinh từ lần gọi trước.
func (g *Game) DrainEvents() []Event {
	ev := g.events
	g.events = nil
	return ev
}

func (g *Game) after(sec float64, fn func()) {
	g.timers = append(g.timers, timer{at: g.Time + sec, fn: fn})
}

// ---------------------------------------------------------------- lệnh

// Order: click chuột phải. Trên băng chỉ đổi hướng (Master_Turn_Point),
// trên nền thường thì đi bộ tới điểm đó.
func (g *Game) Order(slot int, x, y float64) {
	h := g.Heroes[slot]
	if h == nil || !h.Alive || g.Phase != PhasePlaying || !g.validPoint(x, y) {
		return
	}
	if dx, dy := x-h.X, y-h.Y; dx != 0 || dy != 0 {
		h.Facing = normDeg(math.Atan2(dy, dx) * 180 / math.Pi)
	}
	if h.OnIce {
		h.moving = false
		return
	}
	h.moving, h.tx, h.ty = true, x, y
}

// Stop: phím S - dừng đi bộ (trên băng thì vẫn trượt).
func (g *Game) Stop(slot int) {
	if h := g.Heroes[slot]; h != nil {
		h.moving = false
	}
}

// Learn nâng cấp skill bằng điểm kỹ năng.
func (g *Game) Learn(slot int, key string) {
	h := g.Heroes[slot]
	def := abilityByKey(key)
	if h == nil || def == nil || h.SkillPoints <= 0 {
		return
	}
	next := h.AbLevel[key] + 1
	if next > def.MaxLevel || h.Level < 2*next-1 {
		return
	}
	h.AbLevel[key] = next
	h.SkillPoints--
}

// Cast dùng skill. x, y là điểm mục tiêu cho skill cần chọn điểm.
func (g *Game) Cast(slot int, key string, x, y float64) {
	h := g.Heroes[slot]
	def := abilityByKey(key)
	if h == nil || def == nil || !h.Alive || g.Phase != PhasePlaying || !g.validPoint(x, y) {
		return
	}
	lvl := h.AbLevel[key]
	if lvl == 0 || h.Cooldown[key] > 0 {
		return
	}
	cost := levelOr(def.Mana, lvl)
	if h.Mana < cost {
		g.emit(Event{Kind: "error", Slot: slot, Text: "Không đủ mana"})
		return
	}
	if def.Target == "point" {
		if def.Range > 0 && math.Hypot(x-h.X, y-h.Y) > def.Range+50 {
			g.emit(Event{Kind: "error", Slot: slot, Text: "Mục tiêu quá xa"})
			return
		}
		h.Facing = normDeg(math.Atan2(y-h.Y, x-h.X) * 180 / math.Pi)
	}
	h.Mana -= cost
	h.Cooldown[key] = levelOr(def.Cooldown, lvl)
	g.emit(Event{Kind: "cast", Slot: slot, Ab: key, X: h.X, Y: h.Y, TX: x, TY: y})

	switch key {
	case "Q": // JUMp1: bay lên 600 với tốc độ 800, chờ lvl/6s, hạ về 1 với tốc độ 500, chờ lvl/6s, hạ cánh
		h.jumpPhase, h.jumpTimer = 1, float64(lvl)/6
	case "W":
		h.windWalk = levelOr(windWalkDur, lvl)
		h.wwBonus = levelOr(windWalkSpeed, lvl)
	case "E":
		g.carrionSwarm(h, x, y, levelOr(swarmDamage, lvl))
	case "R": // Drift1: REALSPD += 1.25 trong 1.5s rồi đặt lại 1
		h.realSpd += driftBonus
		h.driftTimer = driftDuration
	case "A":
		g.thaw(x, y, levelOr(thawDuration, lvl))
	}
}

func (g *Game) carrionSwarm(h *Hero, x, y, dmg float64) {
	ang := math.Atan2(y-h.Y, x-h.X)
	dx, dy := math.Cos(ang), math.Sin(ang)
	kept := g.dragons[:0]
	for _, d := range g.dragons {
		rx, ry := d.X-h.X, d.Y-h.Y
		along := rx*dx + ry*dy
		perp := math.Abs(-rx*dy + ry*dx)
		half := swarmStartHalf + (swarmEndHalf-swarmStartHalf)*along/swarmLength
		if along >= 0 && along <= swarmLength && perp <= half+32 {
			d.HP -= dmg
		}
		if d.HP <= 0 {
			xp := DragonKillXP
			if d.Big {
				xp = BigDragonXP
			}
			g.addXP(h, xp)
			g.emit(Event{Kind: "dragonDie", Slot: h.Slot, X: d.X, Y: d.Y})
			if g.rng.Float64() < BallDropDragon {
				g.giveBall(h)
			}
			continue
		}
		kept = append(kept, d)
	}
	g.dragons = kept
}

// Thaw: sau 1s đổi ô địa hình thành 'Nrck' rồi trả lại băng khi hết hạn.
func (g *Game) thaw(x, y, dur float64) {
	c := g.m.CornerIndex(x, y)
	if c < 0 {
		return
	}
	t := &Thaw{Corner: c}
	g.thaws = append(g.thaws, t)
	g.after(thawDelay, func() {
		t.Active = true
		t.Until = g.Time + dur + 1
		g.thawCount[c]++
	})
}

// Chat xử lý lệnh của host ("-kick p2" như trigger Kick2..Kick11).
func (g *Game) Kick(slot int) bool {
	h := g.Heroes[slot]
	if h == nil {
		return false
	}
	g.RemovePlayer(slot)
	g.emit(Event{Kind: "msg", Text: fmt.Sprintf("%s bị kick rồi!", h.Name), Dur: 8})
	return true
}

// RemovePlayer khi người chơi thoát (PlayerLeft).
func (g *Game) RemovePlayer(slot int) {
	delete(g.Heroes, slot)
	delete(g.markers, slot)
	g.checkGameOver()
}

// ---------------------------------------------------------------- mô phỏng

func (g *Game) Tick(dt float64) {
	if g.Phase == PhaseLoading {
		return
	}
	// TickNo chạy đều cả lúc đếm ngược: client đồng bộ đồng hồ theo nó, nếu
	// đứng yên 5 giây thì lúc xuất phát client tưởng server đi trước vài giây
	// và phần dự đoán vị trí bị "đóng băng".
	g.TickNo++
	if g.Phase == PhaseCountdown {
		g.CountdownLeft -= dt
		if g.CountdownLeft <= 0 {
			g.CountdownLeft = 0
			g.Phase = PhasePlaying
			g.emit(Event{Kind: "go"})
		}
		return
	}
	g.Time += dt
	g.runTimers()
	if g.Phase != PhasePlaying {
		return
	}
	for _, h := range g.sortedHeroes() {
		g.tickHero(h, dt)
		if g.Phase != PhasePlaying { // có người vừa về đích: dừng toàn bộ
			return
		}
	}
	for _, d := range g.dragons {
		g.tickDragon(d, dt)
	}
	g.tickThaws()
	g.tickBoxes()
	g.collisions()
}

func (g *Game) runTimers() {
	for {
		idx := -1
		for i, t := range g.timers {
			if t.at <= g.Time && (idx < 0 || t.at < g.timers[idx].at) {
				idx = i
			}
		}
		if idx < 0 {
			return
		}
		fn := g.timers[idx].fn
		g.timers = append(g.timers[:idx], g.timers[idx+1:]...)
		fn()
	}
}

func (g *Game) sortedHeroes() []*Hero {
	out := make([]*Hero, 0, len(g.Heroes))
	for _, h := range g.Heroes {
		out = append(out, h)
	}
	sort.Slice(out, func(i, j int) bool { return out[i].Slot < out[j].Slot })
	return out
}

func (g *Game) tileAt(x, y float64) string {
	c := g.m.CornerIndex(x, y)
	if c < 0 {
		return ""
	}
	if g.thawCount[c] > 0 {
		return RockTile
	}
	return g.m.TileName(c)
}

func (g *Game) canStand(x, y float64) bool {
	m := g.m
	if !(m.Walkable(x, y) &&
		m.Walkable(x+HeroRadius, y) && m.Walkable(x-HeroRadius, y) &&
		m.Walkable(x, y+HeroRadius) && m.Walkable(x, y-HeroRadius)) {
		return false
	}
	for _, b := range g.blockers {
		if dx, dy := x-b.X, y-b.Y; dx*dx+dy*dy < (b.R+HeroRadius)*(b.R+HeroRadius) {
			return false
		}
	}
	return true
}

// pushOut: Goku lỡ nằm trong vòng chặn của vật trang trí (vd hồi sinh tại
// đó) thì bị đẩy ra mép vòng chặn, theo hướng từ tâm vật ra.
func (g *Game) pushOut(h *Hero) {
	for _, b := range g.blockers {
		dx, dy := h.X-b.X, h.Y-b.Y
		d := math.Hypot(dx, dy)
		min := b.R + HeroRadius
		if d >= min {
			continue
		}
		if d < 1e-6 {
			dx, dy, d = 1, 0, 1
		}
		nx, ny := b.X+dx/d*(min+0.5), b.Y+dy/d*(min+0.5)
		if g.m.Walkable(nx, ny) {
			h.X, h.Y = nx, ny
		}
	}
}

// step di chuyển có chặn tường. SetUnitPosition trong WC3 đẩy unit về điểm
// đi được gần nhất: thử lệch sang hai bên (lách qua vật cản nhỏ), rồi thử
// trượt dọc theo tường.
func (g *Game) step(x, y, dx, dy float64) (float64, float64, bool) {
	if g.canStand(x+dx, y+dy) {
		return x + dx, y + dy, true
	}
	if l := math.Hypot(dx, dy); l > 0 {
		px, py := -dy/l, dx/l
		for off := 4.0; off <= 40; off += 4 {
			for _, s := range [2]float64{1, -1} {
				nx, ny := x+dx+px*off*s, y+dy+py*off*s
				// chỉ lách nếu đường tới điểm lệch không xuyên tường
				if g.canStand(nx, ny) && g.canStand(x+px*off*s, y+py*off*s) {
					return nx, ny, false
				}
			}
		}
	}
	if dx != 0 && g.canStand(x+dx, y) {
		return x + dx, y, false
	}
	if dy != 0 && g.canStand(x, y+dy) {
		return x, y + dy, false
	}
	return x, y, false
}

func (g *Game) tickHero(h *Hero, dt float64) {
	for k, v := range h.Cooldown {
		if v > 0 {
			h.Cooldown[k] = math.Max(0, v-dt)
		}
	}
	if !h.Alive {
		return
	}
	h.speedPot = math.Max(0, h.speedPot-dt)
	h.invuln = math.Max(0, h.invuln-dt)
	h.Mana = math.Min(h.maxMana(), h.Mana+h.manaRegen()*dt)
	if h.driftTimer > 0 {
		if h.driftTimer -= dt; h.driftTimer <= 0 {
			h.realSpd = 1
		}
	}
	if h.windWalk > 0 {
		if h.windWalk -= dt; h.windWalk <= 0 {
			h.wwBonus = 0
		}
	}
	g.tickJump(h, dt)

	// Master_Slide: băng 'Nice' bật trigger trượt của người chơi.
	h.OnIce = g.tileAt(h.X, h.Y) == IceTile
	if h.OnIce {
		h.moving = false
		dist := SlideBaseSpeed * (h.moveSpeed() / HeroBaseSpeed) * h.realSpd * dt
		rad := h.Facing * math.Pi / 180
		h.X, h.Y, _ = g.step(h.X, h.Y, math.Cos(rad)*dist, math.Sin(rad)*dist)
	} else if h.moving {
		dx, dy := h.tx-h.X, h.ty-h.Y
		d := math.Hypot(dx, dy)
		v := h.moveSpeed() * dt
		if d <= v {
			nx, ny, _ := g.step(h.X, h.Y, dx, dy)
			h.X, h.Y = nx, ny
			h.moving = false
		} else {
			nx, ny, _ := g.step(h.X, h.Y, dx/d*v, dy/d*v)
			if nx == h.X && ny == h.Y {
				h.moving = false
			}
			h.X, h.Y = nx, ny
		}
	}

	g.pushOut(h)
	g.sideGuards(h)
	g.checkpointsFor(h)
	g.pickBoxes(h)
	if r, ok := g.m.Regions["Next_Round"]; ok && mapdata.Contains(r, h.X, h.Y) {
		g.roundComplete(h)
	}
}

func (g *Game) tickJump(h *Hero, dt float64) {
	lvl := float64(h.AbLevel["Q"])
	switch h.jumpPhase {
	case 1:
		h.FlyHeight = math.Min(600, h.FlyHeight+800*dt)
		if h.jumpTimer -= dt; h.jumpTimer <= 0 {
			h.jumpPhase, h.jumpTimer = 2, lvl/6
		}
	case 2:
		h.FlyHeight = math.Max(1, h.FlyHeight-500*dt)
		if h.jumpTimer -= dt; h.jumpTimer <= 0 {
			h.jumpPhase = 3
		}
	case 3:
		h.FlyHeight = math.Max(0, h.FlyHeight-800*dt)
		if h.FlyHeight == 0 {
			h.jumpPhase = 0
		}
	}
}

// SideGuard*: khi đi vào dải sát mép đường băng, hướng bị nắn thẳng theo
// trục để Goku không bị kẹt vào tường.
func (g *Game) sideGuards(h *Hero) {
	for name, r := range g.guards {
		in := mapdata.Contains(r, h.X, h.Y)
		if in && !h.inGuard[name] {
			if strings.HasPrefix(name, "SideGuardTop") || strings.HasPrefix(name, "SideGuardBottom") {
				if h.Facing > 90 && h.Facing < 270 {
					h.Facing = 180
				} else {
					h.Facing = 0
				}
			} else {
				if h.Facing > 0 && h.Facing < 180 {
					h.Facing = 90
				} else {
					h.Facing = 270
				}
			}
		}
		h.inGuard[name] = in
	}
}

// Lvl1..Lvl14: điểm mốc trên đường đi, mỗi vòng thưởng XP một lần.
func (g *Game) checkpointsFor(h *Hero) {
	for i, r := range g.checkpoints {
		k := i + 1
		if h.checkpoint < k && mapdata.Contains(r, h.X, h.Y) {
			g.addXP(h, int(CheckpointBase*math.Pow(CheckpointMul, float64(h.Score))))
			h.checkpoint = k
		}
	}
}

func (g *Game) addXP(h *Hero, amount int) {
	if amount < 0 {
		h.XP = max(h.XP+amount, xpForLevel(h.Level))
		return
	}
	h.XP += amount
	for h.Level < MaxHeroLevel && h.XP >= xpForLevel(h.Level+1) {
		h.Level++
		h.SkillPoints++
		g.emit(Event{Kind: "levelup", Slot: h.Slot, X: h.X, Y: h.Y})
	}
	if h.Level >= MaxHeroLevel {
		h.XP = min(h.XP, xpForLevel(MaxHeroLevel))
	}
}

func (g *Game) tickDragon(d *Dragon, dt float64) {
	if d.idle > 0 {
		d.idle -= dt
		return
	}
	if !d.moving {
		g.pickWander(d)
		return
	}
	dx, dy := d.tx-d.X, d.ty-d.Y
	dist := math.Hypot(dx, dy)
	v := DragonSpeed * dt
	if d.Big {
		v *= 0.6
	}
	if dist <= v {
		d.X, d.Y = d.tx, d.ty
		d.moving = false
		d.idle = 0.3 + g.rng.Float64()*2.2
		return
	}
	nx, ny := d.X+dx/dist*v, d.Y+dy/dist*v
	if !g.m.Walkable(nx, ny) {
		d.moving = false
		d.idle = 0.2
		return
	}
	d.X, d.Y = nx, ny
	d.Facing = normDeg(math.Atan2(dy, dx) * 180 / math.Pi)
}

// Awan (Wander) + Wolf_Area_*: đi lang thang ngẫu nhiên trong vùng của mình.
// Vùng tuần tra gốc không phủ sát mép tường nên dải sát mép thành chỗ trốn an
// toàn; vì vậy vùng được nới tới sát tường và thỉnh thoảng rồng lao thẳng ra
// mép đường. Điểm đến luôn phải là băng (rồng không lên ô đá an toàn).
func (g *Game) pickWander(d *Dragon) {
	r := d.home
	r.MinX -= dragonHomeMargin
	r.MinY -= dragonHomeMargin
	r.MaxX += dragonHomeMargin
	r.MaxY += dragonHomeMargin
	if mapdata.Contains(r, d.X, d.Y) && g.rng.Float64() < dragonEdgeChance {
		if x, y, ok := g.edgeTarget(d, r); ok {
			d.tx, d.ty, d.moving = x, y, true
			return
		}
	}
	for i := 0; i < 8; i++ {
		var x, y float64
		if mapdata.Contains(r, d.X, d.Y) {
			a := g.rng.Float64() * 2 * math.Pi
			l := DragonWanderMn + g.rng.Float64()*(DragonWanderMx-DragonWanderMn)
			x = clamp(d.X+math.Cos(a)*l, r.MinX, r.MaxX)
			y = clamp(d.Y+math.Sin(a)*l, r.MinY, r.MaxY)
		} else {
			x = r.MinX + g.rng.Float64()*(r.MaxX-r.MinX)
			y = r.MinY + g.rng.Float64()*(r.MaxY-r.MinY)
		}
		if g.m.Walkable(x, y) && g.tileAt(x, y) == IceTile {
			d.tx, d.ty, d.moving = x, y, true
			return
		}
	}
	d.idle = 0.5
}

// edgeTarget: đi thẳng theo một trong 4 hướng (đường trong map chạy dọc/ngang)
// tới sát tường, dừng cách tường vài đơn vị.
func (g *Game) edgeTarget(d *Dragon, r mapdata.Rect) (float64, float64, bool) {
	dirs := [4][2]float64{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
	k := g.rng.Intn(4)
	for n := 0; n < 4; n++ {
		dx, dy := dirs[(k+n)%4][0], dirs[(k+n)%4][1]
		x, y := d.X, d.Y
		for s := 0.0; s < DragonWanderMx*2; s += 12 {
			nx, ny := x+dx*12, y+dy*12
			if !g.m.Walkable(nx, ny) || g.tileAt(nx, ny) != IceTile || !mapdata.Contains(r, nx, ny) {
				break
			}
			x, y = nx, ny
		}
		// phải đi được một đoạn và dừng ngay sát tường (không phải ô đá an toàn / hết vùng)
		wx, wy := x+dx*12, y+dy*12
		if math.Hypot(x-d.X, y-d.Y) > 60 && !g.m.Walkable(wx, wy) {
			return x - dx*4, y - dy*4, true
		}
	}
	return 0, 0, false
}

func (g *Game) tickThaws() {
	kept := g.thaws[:0]
	for _, t := range g.thaws {
		if t.Active && g.Time >= t.Until {
			g.thawCount[t.Corner]--
			continue
		}
		kept = append(kept, t)
	}
	g.thaws = kept
}

func (g *Game) collisions() {
	heroes := g.sortedHeroes()
	// P1: rồng 'nwwg' chạm Goku đang đứng dưới đất thì Goku chết.
	for _, h := range heroes {
		if !h.Alive || h.FlyHeight >= 1 || h.invuln > 0 {
			continue
		}
		for _, d := range g.dragons {
			if !d.Big && math.Hypot(d.X-h.X, d.Y-h.Y) < KillRange {
				if h.take("shield") { // Khiên Băng: lướt xuyên qua một lần
					h.invuln = ShieldInvuln
					g.emit(Event{Kind: "shield", Slot: h.Slot, X: h.X, Y: h.Y})
				} else {
					g.killHero(h)
				}
				break
			}
		}
	}
	// P1_Revive: Goku còn sống chạm "Goku Zone" của đồng đội thì hồi sinh họ.
	for _, h := range heroes {
		if !h.Alive {
			continue
		}
		for _, mk := range g.markers {
			if mk.Slot == h.Slot || math.Hypot(mk.X-h.X, mk.Y-h.Y) >= ReviveRange {
				continue
			}
			g.revive(mk.Slot, h)
		}
	}
}

func (g *Game) killHero(h *Hero) {
	h.Alive = false
	h.moving = false
	h.jumpPhase, h.FlyHeight = 0, 0
	h.realSpd, h.driftTimer = 1, 0
	h.windWalk, h.wwBonus = 0, 0
	g.markers[h.Slot] = &Marker{Slot: h.Slot, X: h.X, Y: h.Y}
	h.Deaths++
	h.speedPot = 0
	g.emit(Event{Kind: "death", Slot: h.Slot, X: h.X, Y: h.Y})
	if h.aliveFlag {
		h.Score--
		h.aliveFlag = false
	}
	if h.take("revive") { // Bùa Hồi Sinh: tự sống lại tại chỗ
		h.pendingRevive = true
		round := g.Round
		g.after(ReviveDelay, func() {
			if !h.pendingRevive || h.Alive || g.Round != round || g.Heroes[h.Slot] != h {
				return
			}
			h.pendingRevive = false
			delete(g.markers, h.Slot)
			h.Alive, h.aliveFlag, h.moving = true, true, false
			h.invuln = ReviveInvuln
			g.emit(Event{Kind: "revive", Slot: h.Slot, By: h.Slot, X: h.X, Y: h.Y})
		})
	}
	g.checkGameOver()
}

func (g *Game) revive(slot int, by *Hero) {
	t := g.Heroes[slot]
	delete(g.markers, slot)
	if t == nil {
		return
	}
	g.addXP(t, RevivedXP)
	t.Gold = max(0, t.Gold+RevivedGold)
	by.Gold += ReviveBonusGold
	g.addXP(by, ReviveBonusXP)
	by.Score++
	by.Revives++
	if t.pendingRevive { // được cứu trước khi bùa kịp có tác dụng: trả lại bùa
		t.pendingRevive = false
		t.add("revive")
	}
	t.X, t.Y, t.Facing = by.X, by.Y, by.Facing
	t.Alive, t.aliveFlag = true, true
	t.moving = false
	g.emit(Event{Kind: "revive", Slot: slot, By: by.Slot, X: t.X, Y: t.Y})
}

func (g *Game) checkGameOver() {
	if g.Phase != PhasePlaying {
		return
	}
	for _, h := range g.Heroes {
		if h.Alive || h.pendingRevive {
			return
		}
	}
	// Game_Over: không còn ai sống.
	g.Phase = PhaseDefeat
	g.emit(Event{Kind: "msg", Text: msgLose, Dur: 30})
	g.emit(Event{Kind: "end", Text: "defeat"})
}

// Trigger_Next_Round + Next_Round + Set_level + Win.
func (g *Game) roundComplete(winner *Hero) {
	g.Phase = PhaseIntermission
	g.addXP(winner, RoundWinXP)
	winner.Gold += RoundWinGold
	for _, h := range g.Heroes {
		h.Gold += RoundAllGold
		h.moving = false
	}
	winner.Score += RoundWinScore
	finished := g.Round
	g.emit(Event{Kind: "round", Slot: winner.Slot, Text: fmt.Sprintf("%s đã về đích vòng %d!", winner.Name, finished)})
	if msg, ok := roundMessages[finished]; ok {
		g.emit(Event{Kind: "msg", Text: msg, Dur: 8})
	}
	g.Round++

	g.after(3, func() {
		g.markers = map[int]*Marker{}
		for _, h := range g.Heroes {
			h.X, h.Y = h.startX, h.startY
			h.Facing = 285
			h.Alive, h.aliveFlag = true, true
			if h.pendingRevive { // vòng mới: mọi người sống lại, trả lại bùa
				h.pendingRevive = false
				h.add("revive")
			}
			h.speedPot, h.invuln = 0, 0
			h.jumpPhase, h.FlyHeight = 0, 0
			h.realSpd, h.driftTimer = 1, 0
			for k := range h.inGuard {
				h.inGuard[k] = false
			}
		}
		g.Phase = PhasePlaying
		g.after(2, func() {
			for _, h := range g.Heroes {
				h.checkpoint = 0
			}
			g.spawnRoundDragons()
			if g.Round > FinalRound && g.Phase == PhasePlaying {
				g.Phase = PhaseVictory
				g.emit(Event{Kind: "msg", Text: msgWin, Dur: 30})
				g.emit(Event{Kind: "end", Text: "victory"})
			}
		})
	})
}

func (g *Game) spawnRoundDragons() {
	for _, s := range roundSpawns {
		r, ok := g.m.Regions[s.Area]
		if !ok {
			continue
		}
		for i := 0; i < s.Count; i++ {
			x, y := (r.MinX+r.MaxX)/2, (r.MinY+r.MaxY)/2
			if !s.Center {
				for k := 0; k < 10; k++ {
					x = r.MinX + g.rng.Float64()*(r.MaxX-r.MinX)
					y = r.MinY + g.rng.Float64()*(r.MaxY-r.MinY)
					if g.m.Walkable(x, y) {
						break
					}
				}
			}
			g.addDragon(x, y, g.rng.Float64()*360, false, r)
		}
	}
	g.emit(Event{Kind: "msg", Text: fmt.Sprintf("Rồng đã tăng lên %d con!", len(g.dragons)), Dur: 5})
}

func normDeg(a float64) float64 {
	a = math.Mod(a, 360)
	if a < 0 {
		a += 360
	}
	return a
}

func clamp(v, lo, hi float64) float64 { return math.Max(lo, math.Min(hi, v)) }
