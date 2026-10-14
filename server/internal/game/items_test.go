package game

import (
	"math"
	"testing"
)

func init() { ItemsEnabled = true }

// đặt Goku cạnh quán gần nhất có chỗ đứng được
func atShop(t *testing.T, g *Game, h *Hero) {
	t.Helper()
	for _, s := range Shops {
		for r := 0.0; r <= ShopRange-20; r += 20 {
			for a := 0.0; a < 360; a += 15 {
				x, y := s[0]+r*math.Cos(a*math.Pi/180), s[1]+r*math.Sin(a*math.Pi/180)
				if g.canStand(x, y) && g.tileAt(x, y) != IceTile {
					h.X, h.Y = x, y
					return
				}
			}
		}
	}
	t.Fatal("không quán nào có chỗ đứng trong tầm")
}

func TestShopsReachable(t *testing.T) {
	g := New(load(t), map[int]string{0: "A"}, 1)
	for i, s := range Shops {
		ok := false
		for r := 0.0; r <= ShopRange-20 && !ok; r += 20 {
			for a := 0.0; a < 360 && !ok; a += 15 {
				x, y := s[0]+r*math.Cos(a*math.Pi/180), s[1]+r*math.Sin(a*math.Pi/180)
				ok = g.canStand(x, y) && g.tileAt(x, y) != IceTile
			}
		}
		if !ok {
			t.Errorf("quán %d (%v) không có chỗ đứng trong tầm", i, s)
		}
	}
}

func TestBuySellCraft(t *testing.T) {
	g := New(load(t), map[int]string{0: "A"}, 1)
	h := g.Heroes[0]
	h.Gold = 1000
	h.X, h.Y = 0, 0
	g.Buy(0, "boots")
	if h.has("boots") {
		t.Fatal("mua được khi ở xa quán")
	}
	atShop(t, g, h)
	g.Buy(0, "boots")
	g.Buy(0, "speedpot")
	if !h.has("boots") || !h.has("speedpot") || h.Gold != 1000-200-80 {
		t.Fatalf("mua sai: inv=%v gold=%d", h.Inv, h.Gold)
	}
	base := h.moveSpeed()
	g.Craft(0, "gokuboots")
	if !h.has("gokuboots") || h.has("boots") || h.has("speedpot") || h.Gold != 720-150 {
		t.Fatalf("ghép sai: inv=%v gold=%d", h.Inv, h.Gold)
	}
	if h.moveSpeed() <= base {
		t.Fatal("Giày Goku không tăng tốc")
	}
	g.Buy(0, "gokuboots") // không bán trực tiếp
	if h.count("gokuboots") != 1 {
		t.Fatal("mua được đồ chỉ để ghép")
	}
	gold := h.Gold
	g.Sell(0, 0)
	if h.has("gokuboots") || h.Gold != gold+(150+200+80)/2 {
		t.Fatalf("bán sai: gold %d -> %d", gold, h.Gold)
	}
	h.Gold = 10
	g.Buy(0, "revive")
	if h.has("revive") {
		t.Fatal("mua được khi thiếu vàng")
	}
	// túi đầy
	h.Gold = 99999
	for i := 0; i < 6; i++ {
		g.Buy(0, "boots")
	}
	g.Buy(0, "pendant")
	if h.has("pendant") {
		t.Fatal("mua được khi túi đầy")
	}
}

func TestReviveCharmAndShield(t *testing.T) {
	g := New(load(t), map[int]string{0: "A"}, 1)
	g.Phase = PhasePlaying
	h := g.Heroes[0]
	h.add("shield")
	h.add("revive")
	d := g.dragons[0]
	d.X, d.Y = h.X, h.Y
	g.collisions()
	if !h.Alive || h.has("shield") || h.invuln <= 0 {
		t.Fatal("Khiên Băng không cứu được")
	}
	h.invuln = 0
	g.collisions()
	if h.Alive || !h.pendingRevive || h.has("revive") {
		t.Fatal("chết lẽ ra phải dùng Bùa Hồi Sinh")
	}
	if g.Phase != PhasePlaying {
		t.Fatal("đang chờ hồi sinh mà đã thua")
	}
	d.X += 5000
	for i := 0; i < 50*3; i++ {
		g.Tick(0.02)
	}
	if !h.Alive || h.pendingRevive {
		t.Fatal("không tự hồi sinh")
	}
	// lần chết tiếp theo không còn bùa -> thua
	h.invuln = 0
	d.X, d.Y = h.X, h.Y
	g.collisions()
	if h.Alive || g.Phase != PhaseDefeat {
		t.Fatalf("hết bùa mà không thua: alive=%v phase=%s", h.Alive, g.Phase)
	}
}

func TestUseItemsAndBoxes(t *testing.T) {
	g := New(load(t), map[int]string{0: "A"}, 1)
	g.Phase = PhasePlaying
	g.dragons = nil
	h := g.Heroes[0]
	h.Mana = 0
	h.add("manapot")
	g.UseItem(0, 0)
	if h.Mana != 150 || h.has("manapot") {
		t.Fatalf("Bình Mana: mana=%v", h.Mana)
	}
	h.add("tomepow")
	g.UseItem(0, 0)
	if h.Level != 2 {
		t.Fatalf("Sách Sức Mạnh: level=%d", h.Level)
	}
	h.add("boots")
	g.UseItem(0, 0) // đồ bị động: không dùng được
	if !h.has("boots") {
		t.Fatal("đồ bị động bị tiêu hao")
	}
	for i := 0; i < 50*30; i++ {
		g.Tick(0.02)
	}
	if len(g.boxes) == 0 {
		t.Fatal("không sinh hộp quà")
	}
	for _, b := range g.boxes {
		if g.tileAt(b.X, b.Y) != IceTile {
			t.Fatal("hộp quà nằm ngoài băng")
		}
	}
	b := g.boxes[0]
	gold, n := h.Gold, len(g.boxes)
	h.X, h.Y = b.X, b.Y
	g.pickBoxes(h)
	if len(g.boxes) != n-1 {
		t.Fatal("không nhặt được hộp")
	}
	got := h.Gold != gold || h.Balls != 0
	for _, s := range h.Inv {
		if s.ID != "" && s.ID != "boots" {
			got = true
		}
	}
	if !got {
		t.Fatal("hộp quà rỗng")
	}
}

func TestDragonBallWish(t *testing.T) {
	g := New(load(t), map[int]string{0: "A", 1: "B"}, 1)
	g.Phase = PhasePlaying
	a, b := g.Heroes[0], g.Heroes[1]
	for i := 0; i < 7; i++ {
		if g.giveBall(a) == 0 {
			t.Fatal("thiếu ngọc")
		}
	}
	if a.Balls != AllBalls || g.giveBall(a) != 0 {
		t.Fatal("ngọc rồng sai")
	}
	g.killHero(b)
	g.MakeWish(0, "wish_revive")
	if !b.Alive || a.Balls != 0 {
		t.Fatal("điều ước hồi sinh không chạy")
	}
	g.MakeWish(0, "wish_gold") // hết ngọc: không có tác dụng
	if a.Gold != StartGold {
		t.Fatal("ước được khi không đủ 7 ngọc")
	}
}
