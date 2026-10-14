package game

import (
	"encoding/base64"
	"encoding/binary"
	"math"
)

// HeroState là trạng thái một Goku gửi cho client. Goku của chính người nhận
// có đủ chi tiết; Goku của người khác chỉ gửi phần cần để vẽ (các trường
// omitempty bị bỏ) cho gói tin nhỏ.
type HeroState struct {
	Slot     int                `json:"s"`
	Name     string             `json:"n"`
	X        float64            `json:"x"`
	Y        float64            `json:"y"`
	Facing   float64            `json:"f"`
	Alive    bool               `json:"a"`
	OnIce    bool               `json:"ice"`
	Fly      float64            `json:"h"`
	Level    int                `json:"lv"`
	Score    int                `json:"sc"`
	Mana     float64            `json:"mp"`
	MaxMana  float64            `json:"mmp"`
	Invis    bool               `json:"ww,omitempty"`
	Invuln   bool               `json:"iv,omitempty"`
	Shield   bool               `json:"sh,omitempty"` // đang giữ Khiên Băng (để vẽ quầng khiên)
	Revive   bool               `json:"rv,omitempty"`
	Own      bool               `json:"me,omitempty"` // bản đầy đủ (Goku của người nhận)
	XP       int                `json:"xp,omitempty"`
	XPCur    int                `json:"xp0,omitempty"`
	XPNext   int                `json:"xp1,omitempty"`
	Points   int                `json:"sp,omitempty"`
	AbLevel  map[string]int     `json:"ab,omitempty"`
	Cooldown map[string]float64 `json:"cd,omitempty"`
	Gold     int                `json:"g,omitempty"`
	Seq      uint32             `json:"q,omitempty"`
	Moving   bool               `json:"mv,omitempty"`
	TX       float64            `json:"tx,omitempty"`
	TY       float64            `json:"ty,omitempty"`
	RealSpd  float64            `json:"rs,omitempty"`
	Speed    float64            `json:"spd,omitempty"`
	Drift    bool               `json:"dr,omitempty"`
	Inv      []InvSlot          `json:"inv,omitempty"`
	Balls    uint8              `json:"db,omitempty"`
}

// Snapshot là trạng thái trận gửi cho một người chơi.
//   - dr: rồng trong tầm nhìn, nhị phân base64, 8 byte/con:
//     id u16, x i16, y i16, hướng u8 (0-255 = 0-360°), cờ u8 (bit7 = rồng đại ca, 0-100 = %máu)
//   - mm: toàn bộ rồng cho bản đồ nhỏ (gửi thưa), 3 byte/con: x u8, y u8, đại ca u8
type Snapshot struct {
	Type    string       `json:"t"`
	Tick    int64        `json:"tick"`
	Time    float64      `json:"time"`
	Phase   Phase        `json:"phase"`
	Count   float64      `json:"count,omitempty"` // giây đếm ngược còn lại
	Round   int          `json:"round"`
	Final   int          `json:"final"`
	Heroes  []HeroState  `json:"heroes"`
	DR      string       `json:"dr"`
	MM      string       `json:"mm,omitempty"`
	Markers [][3]float64 `json:"markers"`
	Thaws   [][2]float64 `json:"thaws"`           // [corner, giây còn lại]
	Boxes   [][3]float64 `json:"boxes,omitempty"` // hộp quà [id, x, y]
}

// View là vùng người chơi đang nhìn (tâm camera + bán kính).
type View struct {
	X, Y, R float64
	Set     bool
}

const (
	// rồng gần Goku luôn được gửi (dù camera đang nhìn chỗ khác)
	nearHeroRange = 900.0
	defaultView   = 2400.0
	MaxViewRadius = 4200.0
)

func r1(v float64) float64 { return math.Round(v*10) / 10 }

func (g *Game) heroState(h *Hero, full bool) HeroState {
	s := HeroState{
		Slot: h.Slot, Name: h.Name, X: math.Round(h.X*100) / 100, Y: math.Round(h.Y*100) / 100, Facing: r1(h.Facing),
		Alive: h.Alive, OnIce: h.OnIce, Fly: math.Round(h.FlyHeight), Level: h.Level, Score: h.Score,
		Mana: math.Floor(h.Mana), MaxMana: h.maxMana(), Invis: h.windWalk > 0, Invuln: h.invuln > 0,
		Shield: h.has("shield"), Revive: h.pendingRevive,
	}
	if !full {
		return s
	}
	cd := map[string]float64{}
	for k, v := range h.Cooldown {
		if v > 0 {
			cd[k] = r1(v)
		}
	}
	ab := map[string]int{}
	for k, v := range h.AbLevel {
		ab[k] = v
	}
	inv := h.Inv // sao chép: snapshot không được trỏ vào túi đồ đang thay đổi
	s.Own = true
	s.XP, s.XPCur, s.XPNext = h.XP, xpForLevel(h.Level), xpForLevel(min(h.Level+1, MaxHeroLevel))
	s.Points, s.AbLevel, s.Cooldown, s.Gold = h.SkillPoints, ab, cd, h.Gold
	s.Seq, s.Moving, s.TX, s.TY = h.LastSeq, h.moving, r1(h.tx), r1(h.ty)
	s.RealSpd, s.Speed, s.Drift = h.realSpd, h.moveSpeed(), h.driftTimer > 0
	s.Inv, s.Balls = inv[:], h.Balls
	return s
}

// SnapshotFor dựng snapshot cho người chơi ở `slot` (slot < 0: khán giả).
// Rồng chỉ gửi trong vùng nhìn; `minimap` = kèm vị trí thô của mọi con rồng.
func (g *Game) SnapshotFor(slot int, v View, minimap bool) Snapshot {
	s := Snapshot{Type: "snap", Tick: g.TickNo, Time: r1(g.Time), Phase: g.Phase, Count: r1(g.CountdownLeft), Round: g.Round, Final: FinalRound}
	me := g.Heroes[slot]
	for _, h := range g.sortedHeroes() {
		s.Heroes = append(s.Heroes, g.heroState(h, h == me))
	}
	if !v.Set {
		v = View{R: defaultView}
		if me != nil {
			v.X, v.Y = me.X, me.Y
		}
	}
	buf := make([]byte, 0, 8*len(g.dragons))
	for _, d := range g.dragons {
		in := math.Abs(d.X-v.X) <= v.R && math.Abs(d.Y-v.Y) <= v.R
		if !in && me != nil {
			in = math.Abs(d.X-me.X) <= nearHeroRange && math.Abs(d.Y-me.Y) <= nearHeroRange
		}
		if in {
			buf = packDragon(buf, d)
		}
	}
	s.DR = base64.StdEncoding.EncodeToString(buf)
	if minimap {
		b := g.m.Bounds
		mm := make([]byte, 0, 3*len(g.dragons))
		for _, d := range g.dragons {
			big := byte(0)
			if d.Big {
				big = 1
			}
			mm = append(mm, u8((d.X-b.MinX)/(b.MaxX-b.MinX)), u8((d.Y-b.MinY)/(b.MaxY-b.MinY)), big)
		}
		s.MM = base64.StdEncoding.EncodeToString(mm)
	}
	for _, m := range g.markers {
		s.Markers = append(s.Markers, [3]float64{float64(m.Slot), math.Round(m.X), math.Round(m.Y)})
	}
	for _, t := range g.thaws {
		if t.Active {
			s.Thaws = append(s.Thaws, [2]float64{float64(t.Corner), r1(t.Until - g.Time)})
		}
	}
	for _, b := range g.boxes {
		s.Boxes = append(s.Boxes, [3]float64{float64(b.ID), math.Round(b.X), math.Round(b.Y)})
	}
	return s
}

// Snapshot: bản nhìn toàn cảnh (khán giả / kiểm thử).
func (g *Game) Snapshot() Snapshot {
	return g.SnapshotFor(-1, View{R: 1e9, Set: true}, true)
}

func u8(f float64) byte { return byte(math.Max(0, math.Min(255, math.Round(f*255)))) }

func packDragon(buf []byte, d *Dragon) []byte {
	var b [8]byte
	binary.LittleEndian.PutUint16(b[0:], uint16(d.ID))
	binary.LittleEndian.PutUint16(b[2:], uint16(int16(math.Round(d.X))))
	binary.LittleEndian.PutUint16(b[4:], uint16(int16(math.Round(d.Y))))
	b[6] = byte(int(math.Round(normDeg(d.Facing)/360*256)) & 255)
	flags := byte(math.Max(0, math.Min(100, math.Round(d.HP/d.MaxHP*100))))
	if d.Big {
		flags |= 0x80
	}
	b[7] = flags
	return append(buf, b[:]...)
}
