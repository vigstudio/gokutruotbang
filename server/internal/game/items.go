package game

import (
	"fmt"
	"math"
)

// ---------------------------------------------------------------- danh mục
// Vật phẩm lấy theo map gốc (bspd, pspd, pman, penr, rwiz, texp, tkno, Goku
// Boots, "twice as good as Pendant of Energy") + vài món mới: Bùa Hồi Sinh,
// Khiên Băng, Đậu Thần. Cửa hàng là 3 quán Krusty Krab (ngme) như map gốc.

type ItemDef struct {
	ID     string `json:"id"`
	Name   string `json:"name"`
	Desc   string `json:"desc"`
	Price  int    `json:"price"` // 0 = không bán ở cửa hàng (chỉ ghép/nhặt)
	Stack  int    `json:"stack"` // số lượng tối đa trong một ô
	Rarity string `json:"rarity"`
	Use    bool   `json:"use"` // bấm để dùng (tiêu hao); còn lại là đồ bị động
}

type Recipe struct {
	ID    string   `json:"id"` // vật phẩm tạo ra
	Needs []string `json:"needs"`
	Gold  int      `json:"gold"`
}

type Wish struct {
	ID   string `json:"id"`
	Name string `json:"name"`
	Desc string `json:"desc"`
}

var Items = []ItemDef{
	{ID: "revive", Name: "Bùa Hồi Sinh", Desc: "Bị rồng chạm sẽ tự sống lại tại chỗ sau 2 giây, không cần đồng đội cứu. Mất bùa sau khi dùng. Giữ tối đa 2.", Price: 250, Stack: 2, Rarity: "epic"},
	{ID: "shield", Name: "Khiên Băng", Desc: "Lướt xuyên qua rồng một lần: khiên vỡ và bất tử 1 giây.", Price: 150, Stack: 2, Rarity: "rare"},
	{ID: "boots", Name: "Giày Tốc Độ", Desc: "+10% tốc độ trượt và đi bộ.", Price: 200, Stack: 1, Rarity: "uncommon"},
	{ID: "speedpot", Name: "Thuốc Tốc Độ", Desc: "Dùng: +50% tốc độ trong 6 giây.", Price: 80, Stack: 3, Rarity: "common", Use: true},
	{ID: "manapot", Name: "Bình Mana", Desc: "Dùng: hồi 150 mana.", Price: 60, Stack: 3, Rarity: "common", Use: true},
	{ID: "pendant", Name: "Mặt Dây Năng Lượng", Desc: "+150 mana tối đa.", Price: 180, Stack: 1, Rarity: "uncommon"},
	{ID: "sobi", Name: "Mặt Nạ Sobi", Desc: "+50% tốc độ hồi mana.", Price: 150, Stack: 1, Rarity: "uncommon"},
	{ID: "tomexp", Name: "Sách Kinh Nghiệm", Desc: "Dùng: +200 kinh nghiệm.", Price: 120, Stack: 3, Rarity: "common", Use: true},
	{ID: "tomepow", Name: "Sách Sức Mạnh", Desc: "Dùng: lên ngay 1 cấp (tối đa 3 lần mỗi trận).", Price: 400, Stack: 1, Rarity: "rare", Use: true},
	{ID: "senzu", Name: "Đậu Thần", Desc: "Dùng: hồi đầy mana và làm mới mọi kỹ năng.", Price: 300, Stack: 2, Rarity: "rare", Use: true},
	{ID: "gokuboots", Name: "Giày Goku", Desc: "+30% tốc độ trượt và đi bộ. Ghép từ Giày Tốc Độ + Thuốc Tốc Độ.", Stack: 1, Rarity: "legend"},
	{ID: "pendant2", Name: "Bùa Kép", Desc: "+300 mana tối đa, hồi mana nhanh gấp đôi. Ghép từ Mặt Dây Năng Lượng + Mặt Nạ Sobi.", Stack: 1, Rarity: "legend"},
}

var Recipes = []Recipe{
	{ID: "gokuboots", Needs: []string{"boots", "speedpot"}, Gold: 150},
	{ID: "pendant2", Needs: []string{"pendant", "sobi"}, Gold: 100},
	{ID: "revive", Needs: []string{"shield", "shield"}, Gold: 100},
}

var Wishes = []Wish{
	{ID: "wish_revive", Name: "Hồi sinh cả đội", Desc: "Mọi Goku đã ngã sống lại ngay bên cạnh bạn."},
	{ID: "wish_lives", Name: "Mạng cho mọi người", Desc: "Mỗi người chơi nhận 1 Bùa Hồi Sinh (nếu túi còn chỗ)."},
	{ID: "wish_gold", Name: "Kho báu", Desc: "Bạn nhận 500 vàng, mọi người khác nhận 150 vàng."},
}

// ItemsEnabled bật hệ thống cửa hàng/vật phẩm/hộp quà/Ngọc Rồng. Tắt khi
// giao diện client chưa sẵn sàng (server bỏ qua mọi lệnh liên quan).
var ItemsEnabled = true

// Shops: vị trí 3 quán Krusty Krab trong map gốc (CreateUnit 'ngme').
var Shops = [][2]float64{{-3136, 2432}, {-2368, -2752}, {1664, 1280}}

const (
	InvSlots       = 6
	ShopRange      = 420.0
	SellRatio      = 0.5
	BoxInterval    = 5.0 // Spawn: mỗi 5 giây
	MaxBoxes       = 8
	BoxLife        = 45.0
	BoxPickRange   = 70.0 // Collect_n: TriggerRegisterUnitInRangeSimple 70
	ReviveDelay    = 2.0
	ShieldInvuln   = 1.0
	ReviveInvuln   = 2.0
	SpeedPotTime   = 6.0
	MaxTomePow     = 3
	BallDropDragon = 0.08 // tỉ lệ rơi Ngọc Rồng khi hạ rồng bằng E
	BallDropBox    = 0.04
	AllBalls       = 0x7f
)

func itemByID(id string) *ItemDef {
	for i := range Items {
		if Items[i].ID == id {
			return &Items[i]
		}
	}
	return nil
}

func recipeByID(id string) *Recipe {
	for i := range Recipes {
		if Recipes[i].ID == id {
			return &Recipes[i]
		}
	}
	return nil
}

// Catalog gửi cho client (một nguồn dữ liệu duy nhất cho giá/tên/mô tả).
func Catalog() map[string]any {
	return map[string]any{"items": Items, "recipes": Recipes, "wishes": Wishes, "shops": Shops, "shopRange": ShopRange, "slots": InvSlots}
}

// ---------------------------------------------------------------- túi đồ

type InvSlot struct {
	ID string `json:"i"`
	N  int    `json:"n"`
}

func (h *Hero) count(id string) int {
	n := 0
	for _, s := range h.Inv {
		if s.ID == id {
			n += s.N
		}
	}
	return n
}

func (h *Hero) has(id string) bool { return h.count(id) > 0 }

// canAdd: còn chỗ cho 1 cái `id` không (cộng dồn vào ô cũ hoặc ô trống).
func (h *Hero) canAdd(id string) bool {
	def := itemByID(id)
	if def == nil {
		return false
	}
	if id == "revive" && h.count("revive") >= def.Stack {
		return false
	}
	for _, s := range h.Inv {
		if s.ID == id && s.N < def.Stack {
			return true
		}
	}
	for _, s := range h.Inv {
		if s.ID == "" {
			return true
		}
	}
	return false
}

func (h *Hero) add(id string) bool {
	if !h.canAdd(id) {
		return false
	}
	def := itemByID(id)
	for i := range h.Inv {
		if h.Inv[i].ID == id && h.Inv[i].N < def.Stack {
			h.Inv[i].N++
			return true
		}
	}
	for i := range h.Inv {
		if h.Inv[i].ID == "" {
			h.Inv[i] = InvSlot{ID: id, N: 1}
			return true
		}
	}
	return false
}

// take bỏ 1 cái `id` khỏi túi (ưu tiên ô cuối).
func (h *Hero) take(id string) bool {
	for i := len(h.Inv) - 1; i >= 0; i-- {
		if h.Inv[i].ID == id {
			h.Inv[i].N--
			if h.Inv[i].N <= 0 {
				h.Inv[i] = InvSlot{}
			}
			return true
		}
	}
	return false
}

func (h *Hero) speedBonus() float64 {
	b := 0.0
	if h.has("gokuboots") {
		b = 0.30
	} else if h.has("boots") {
		b = 0.10
	}
	if h.speedPot > 0 {
		b += 0.5
	}
	return b
}

func (h *Hero) manaBonus() float64 {
	if h.has("pendant2") {
		return 300
	}
	if h.has("pendant") {
		return 150
	}
	return 0
}

func (h *Hero) regenMul() float64 {
	if h.has("pendant2") {
		return 2
	}
	if h.has("sobi") {
		return 1.5
	}
	return 1
}

// ---------------------------------------------------------------- lệnh

func (g *Game) nearShop(h *Hero) bool {
	for _, s := range Shops {
		if math.Hypot(s[0]-h.X, s[1]-h.Y) <= ShopRange {
			return true
		}
	}
	return false
}

func (g *Game) itemMsg(h *Hero, ok bool, id, text string) {
	if ok {
		g.emit(Event{Kind: "item", Slot: h.Slot, Ab: id, Text: text, X: h.X, Y: h.Y})
	} else {
		g.emit(Event{Kind: "error", Slot: h.Slot, Text: text})
	}
}

// shopCheck: điều kiện chung để mua/bán/ghép.
func (g *Game) shopCheck(slot int) *Hero {
	if !ItemsEnabled {
		return nil
	}
	h := g.Heroes[slot]
	if h == nil || !h.Alive || (g.Phase != PhasePlaying && g.Phase != PhaseIntermission) {
		return nil
	}
	if !g.nearShop(h) {
		g.itemMsg(h, false, "", "Hãy tới gần quán Krusty Krab")
		return nil
	}
	return h
}

func (g *Game) Buy(slot int, id string) {
	h := g.shopCheck(slot)
	def := itemByID(id)
	if h == nil || def == nil || def.Price <= 0 {
		return
	}
	if h.Gold < def.Price {
		g.itemMsg(h, false, id, "Không đủ vàng")
		return
	}
	if !h.add(id) {
		g.itemMsg(h, false, id, "Túi đồ đã đầy")
		return
	}
	h.Gold -= def.Price
	g.itemMsg(h, true, id, "Đã mua "+def.Name)
}

func (g *Game) Sell(slot, idx int) {
	h := g.shopCheck(slot)
	if h == nil || idx < 0 || idx >= InvSlots || h.Inv[idx].ID == "" {
		return
	}
	def := itemByID(h.Inv[idx].ID)
	price := def.Price
	if price == 0 { // đồ ghép: tính theo nguyên liệu
		if r := recipeByID(def.ID); r != nil {
			price = r.Gold
			for _, n := range r.Needs {
				price += itemByID(n).Price
			}
		}
	}
	h.Inv[idx].N--
	if h.Inv[idx].N <= 0 {
		h.Inv[idx] = InvSlot{}
	}
	gold := int(float64(price) * SellRatio)
	h.Gold += gold
	g.itemMsg(h, true, def.ID, fmt.Sprintf("Đã bán %s (+%d vàng)", def.Name, gold))
}

func (g *Game) Craft(slot int, id string) {
	h := g.shopCheck(slot)
	r := recipeByID(id)
	if h == nil || r == nil {
		return
	}
	need := map[string]int{}
	for _, n := range r.Needs {
		need[n]++
	}
	for n, c := range need {
		if h.count(n) < c {
			g.itemMsg(h, false, id, "Thiếu nguyên liệu: "+itemByID(n).Name)
			return
		}
	}
	if h.Gold < r.Gold {
		g.itemMsg(h, false, id, "Không đủ vàng")
		return
	}
	// thử trên bản sao để chắc chắn còn chỗ cho thành phẩm
	backup := h.Inv
	for _, n := range r.Needs {
		h.take(n)
	}
	if !h.add(id) {
		h.Inv = backup
		g.itemMsg(h, false, id, "Túi đồ đã đầy")
		return
	}
	h.Gold -= r.Gold
	g.itemMsg(h, true, id, "Đã ghép "+itemByID(id).Name)
}

// UseItem: bấm phím 1-6.
func (g *Game) UseItem(slot, idx int) {
	h := g.Heroes[slot]
	if !ItemsEnabled || h == nil || !h.Alive || g.Phase != PhasePlaying || idx < 0 || idx >= InvSlots || h.Inv[idx].ID == "" {
		return
	}
	def := itemByID(h.Inv[idx].ID)
	if def == nil || !def.Use {
		return
	}
	switch def.ID {
	case "speedpot":
		h.speedPot = SpeedPotTime
	case "manapot":
		if h.Mana >= h.maxMana() {
			g.itemMsg(h, false, def.ID, "Mana đã đầy")
			return
		}
		h.Mana = math.Min(h.maxMana(), h.Mana+150)
	case "tomexp":
		g.addXP(h, 200)
	case "tomepow":
		if h.tomePow >= MaxTomePow || h.Level >= MaxHeroLevel {
			g.itemMsg(h, false, def.ID, "Không thể dùng thêm Sách Sức Mạnh")
			return
		}
		h.tomePow++
		g.addXP(h, max(0, xpForLevel(h.Level+1)-h.XP))
	case "senzu":
		h.Mana = h.maxMana()
		for k := range h.Cooldown {
			h.Cooldown[k] = 0
		}
	}
	h.Inv[idx].N--
	if h.Inv[idx].N <= 0 {
		h.Inv[idx] = InvSlot{}
	}
	g.emit(Event{Kind: "use", Slot: slot, Ab: def.ID, X: h.X, Y: h.Y})
}

// MakeWish: đủ 7 Ngọc Rồng thì gọi Rồng Thần.
func (g *Game) MakeWish(slot int, id string) {
	h := g.Heroes[slot]
	if !ItemsEnabled || h == nil || !h.Alive || g.Phase != PhasePlaying || h.Balls != AllBalls {
		return
	}
	switch id {
	case "wish_revive":
		for s := range g.markers {
			if t := g.Heroes[s]; t != nil && !t.Alive {
				delete(g.markers, s)
				t.X, t.Y, t.Facing = h.X, h.Y, h.Facing
				t.Alive, t.aliveFlag, t.moving = true, true, false
				t.invuln = ReviveInvuln
				t.pendingRevive = false
				g.emit(Event{Kind: "revive", Slot: s, By: slot, X: t.X, Y: t.Y})
			}
		}
	case "wish_lives":
		for _, o := range g.Heroes {
			o.add("revive")
		}
	case "wish_gold":
		for _, o := range g.Heroes {
			if o == h {
				o.Gold += 500
			} else {
				o.Gold += 150
			}
		}
	default:
		return
	}
	h.Balls = 0
	name := ""
	for _, w := range Wishes {
		if w.ID == id {
			name = w.Name
		}
	}
	g.emit(Event{Kind: "wish", Slot: slot, Ab: id, X: h.X, Y: h.Y, Text: fmt.Sprintf("%s đã gọi Rồng Thần: %s!", h.Name, name)})
}

// ---------------------------------------------------------------- Ngọc Rồng + hộp quà

// giveBall trao một viên Ngọc Rồng còn thiếu; trả về số sao (1-7) hoặc 0.
func (g *Game) giveBall(h *Hero) int {
	if !ItemsEnabled {
		return 0
	}
	var missing []int
	for i := 0; i < 7; i++ {
		if h.Balls&(1<<i) == 0 {
			missing = append(missing, i)
		}
	}
	if len(missing) == 0 {
		return 0
	}
	i := missing[g.rng.Intn(len(missing))]
	h.Balls |= 1 << i
	g.emit(Event{Kind: "ball", Slot: h.Slot, X: h.X, Y: h.Y, Dur: float64(i + 1), Text: fmt.Sprintf("%s nhặt được Ngọc Rồng %d sao!", h.Name, i+1)})
	return i + 1
}

type Box struct {
	ID    int
	X, Y  float64
	Until float64
}

// trọng số vật phẩm trong hộp (theo bảng RandomDistAddItem của map gốc)
var boxLoot = []struct {
	id string
	w  int
}{{"manapot", 20}, {"speedpot", 20}, {"tomexp", 12}, {"shield", 10}, {"boots", 5}, {"sobi", 5}, {"pendant", 5}, {"senzu", 3}, {"revive", 2}, {"tomepow", 1}}

func (g *Game) tickBoxes() {
	if !ItemsEnabled {
		return
	}
	kept := g.boxes[:0]
	for _, b := range g.boxes {
		if b.Until > g.Time {
			kept = append(kept, b)
		}
	}
	g.boxes = kept
	if g.Time < g.nextBox {
		return
	}
	g.nextBox = g.Time + BoxInterval
	if len(g.boxes) >= MaxBoxes {
		return
	}
	b := g.m.Bounds
	for try := 0; try < 40; try++ {
		x := b.MinX + g.rng.Float64()*(b.MaxX-b.MinX)
		y := b.MinY + g.rng.Float64()*(b.MaxY-b.MinY)
		if g.tileAt(x, y) != IceTile || !g.canStand(x, y) {
			continue
		}
		g.boxID++
		g.boxes = append(g.boxes, &Box{ID: g.boxID, X: x, Y: y, Until: g.Time + BoxLife})
		return
	}
}

func (g *Game) pickBoxes(h *Hero) {
	if !h.Alive || h.FlyHeight > 100 {
		return
	}
	for i, b := range g.boxes {
		if math.Hypot(b.X-h.X, b.Y-h.Y) > BoxPickRange {
			continue
		}
		g.boxes = append(g.boxes[:i], g.boxes[i+1:]...)
		g.openBox(h)
		return
	}
}

func (g *Game) openBox(h *Hero) {
	roll := g.rng.Float64()
	if roll < BallDropBox && g.giveBall(h) > 0 {
		return
	}
	if roll < 0.55 {
		gold := 25 + g.rng.Intn(36)
		h.Gold += gold
		g.emit(Event{Kind: "pickup", Slot: h.Slot, X: h.X, Y: h.Y, Text: fmt.Sprintf("+%d vàng", gold)})
		return
	}
	total := 0
	for _, l := range boxLoot {
		total += l.w
	}
	r := g.rng.Intn(total)
	id := boxLoot[0].id
	for _, l := range boxLoot {
		if r < l.w {
			id = l.id
			break
		}
		r -= l.w
	}
	def := itemByID(id)
	if h.add(id) {
		g.emit(Event{Kind: "pickup", Slot: h.Slot, Ab: id, X: h.X, Y: h.Y, Text: def.Name})
		return
	}
	gold := int(float64(def.Price) * SellRatio)
	h.Gold += gold
	g.emit(Event{Kind: "pickup", Slot: h.Slot, X: h.X, Y: h.Y, Text: fmt.Sprintf("Túi đầy: %s → +%d vàng", def.Name, gold)})
}
