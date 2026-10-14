package game

import (
	"math"
	"testing"

	"gokutruotbang/internal/mapdata"
)

func load(t *testing.T) *mapdata.Map {
	t.Helper()
	m, err := mapdata.Load()
	if err != nil {
		t.Fatal(err)
	}
	return m
}

func TestMapData(t *testing.T) {
	m := load(t)
	if len(m.Regions) < 80 {
		t.Fatalf("ít region: %d", len(m.Regions))
	}
	if _, ok := m.Regions["Next_Round"]; !ok {
		t.Fatal("thiếu Next_Round")
	}
	g := New(m, map[int]string{0: "A"}, 1)
	h := g.Heroes[0]
	if !g.canStand(h.X, h.Y) {
		t.Fatalf("điểm xuất phát không đi được: %.0f,%.0f", h.X, h.Y)
	}
	if g.tileAt(h.X, h.Y) == IceTile {
		t.Fatalf("điểm xuất phát lẽ ra không phải băng")
	}
	if len(g.dragons) != 116 {
		t.Fatalf("số rồng ban đầu = %d, muốn 116", len(g.dragons))
	}
}

func TestSlideAndWall(t *testing.T) {
	m := load(t)
	g := New(m, map[int]string{0: "A"}, 1)
	g.dragons = nil // không có rồng để thử trượt
	h := g.Heroes[0]
	// đi sang phải, ra khỏi vùng an toàn và lên băng
	g.Order(0, h.X+2000, h.Y)
	slid := false
	for i := 0; i < 50*20; i++ {
		g.Tick(0.02)
		if h.OnIce {
			slid = true
		}
	}
	if !slid {
		t.Fatalf("Goku không lên được băng, đang ở %.0f,%.0f tile=%s", h.X, h.Y, g.tileAt(h.X, h.Y))
	}
	// 20 giây trượt 400/s về phía đông thì phải tới cuối đường và bị tường chặn
	if h.X < 2000 {
		t.Fatalf("trượt chưa đủ xa: x=%.0f", h.X)
	}
	if !g.canStand(h.X, h.Y) {
		t.Fatalf("Goku đứng trong tường: %.0f,%.0f", h.X, h.Y)
	}
}

func TestDeathAndRevive(t *testing.T) {
	m := load(t)
	g := New(m, map[int]string{0: "A", 1: "B"}, 1)
	a, b := g.Heroes[0], g.Heroes[1]
	g.dragons = []*Dragon{{ID: 99, X: a.X + 10, Y: a.Y, HP: 1, MaxHP: 1, idle: 100}}
	g.Tick(0.02)
	if a.Alive {
		t.Fatal("A lẽ ra phải chết khi chạm rồng")
	}
	if a.Score != -1 {
		t.Fatalf("điểm A = %d, muốn -1", a.Score)
	}
	g.dragons = nil
	b.X, b.Y = a.X, a.Y
	g.Tick(0.02)
	if !a.Alive || b.Score != 1 || b.Gold != StartGold+ReviveBonusGold {
		t.Fatalf("hồi sinh sai: alive=%v scoreB=%d goldB=%d", a.Alive, b.Score, b.Gold)
	}
}

func TestJumpAvoidsDragon(t *testing.T) {
	m := load(t)
	g := New(m, map[int]string{0: "A"}, 1)
	h := g.Heroes[0]
	h.AbLevel["Q"] = 1
	g.dragons = nil
	g.Cast(0, "Q", 0, 0)
	g.Tick(0.1)
	g.dragons = []*Dragon{{ID: 99, X: h.X, Y: h.Y, HP: 1, MaxHP: 1, idle: 100}}
	g.Tick(0.02)
	if !h.Alive {
		t.Fatal("đang bay mà vẫn chết")
	}
	for i := 0; i < 100; i++ {
		g.Tick(0.02)
	}
	if h.Alive {
		t.Fatal("hạ cánh rồi lẽ ra phải chết")
	}
}

func TestRoundAndVictory(t *testing.T) {
	m := load(t)
	g := New(m, map[int]string{0: "A"}, 1)
	g.dragons = nil
	h := g.Heroes[0]
	r := m.Regions["Next_Round"]
	for round := 1; round <= FinalRound; round++ {
		g.dragons = nil
		h.X, h.Y = (r.MinX+r.MaxX)/2, (r.MinY+r.MaxY)/2
		g.Tick(0.02)
		if g.Phase != PhaseIntermission {
			t.Fatalf("vòng %d: phase=%s", round, g.Phase)
		}
		for i := 0; i < 50*6; i++ {
			g.Tick(0.02)
			if g.Phase == PhaseVictory {
				break
			}
		}
	}
	if g.Phase != PhaseVictory {
		t.Fatalf("phase=%s round=%d, muốn victory", g.Phase, g.Round)
	}
	if math.Abs(h.X-h.startX) > 1e-6 && g.Phase != PhaseVictory {
		t.Fatal("không về chỗ xuất phát")
	}
}

func TestLevelUp(t *testing.T) {
	m := load(t)
	g := New(m, map[int]string{0: "A"}, 1)
	h := g.Heroes[0]
	g.addXP(h, 500)
	if h.Level != 3 || h.SkillPoints != 3 {
		t.Fatalf("level=%d sp=%d", h.Level, h.SkillPoints)
	}
	g.Learn(0, "Q")
	g.Learn(0, "Q") // cấp 2 cần hero level 3
	g.Learn(0, "Q") // cấp 3 cần level 5 -> không được
	if h.AbLevel["Q"] != 2 || h.SkillPoints != 1 {
		t.Fatalf("Q=%d sp=%d", h.AbLevel["Q"], h.SkillPoints)
	}
}
