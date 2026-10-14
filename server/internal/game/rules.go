package game

// Các hằng số được lấy từ script gốc (docs/original/war3map.j) và dữ liệu
// object (war3map.w3u / w3a). Chú thích ghi rõ trigger/field tương ứng.

const (
	TickRate     = 50 // lần mô phỏng / giây
	SnapshotRate = 25 // lần gửi trạng thái / giây

	MaxPlayers = 11 // slot 0..10 có Goku (Player 12 là phe rồng)

	// P1_Slide: mỗi 0.01s dịch udg_speedMultiplier(4) * speed/defaultSpeed
	// => 400 đơn vị/giây khi tốc độ chạy = mặc định.
	SlideBaseSpeed = 400.0
	HeroBaseSpeed  = 350.0 // E000 umvs
	HeroMaxSpeed   = 522.0 // giới hạn tốc độ của engine WC3
	HeroRadius     = 10.0

	// P1: TriggerRegisterUnitInRange(GetUnitPointValueByType('E000') = 40)
	// cộng bán kính va chạm của rồng (ucol 32) ~ 60.
	KillRange   = 60.0
	ReviveRange = 70.0 // P1_Revive

	DragonSpeed = 300.0
	// rồng: nới vùng tuần tra tới sát tường + tỉ lệ chủ động lao ra mép đường
	dragonHomeMargin = 320.0
	dragonEdgeChance = 0.4
	DragonHP         = 500.0
	BigDragonHP      = 1000.0
	DragonKillXP     = 25
	BigDragonXP      = 100
	DragonWanderMn   = 150.0
	DragonWanderMx   = 650.0

	MaxHeroLevel = 14 // war3mapMisc.txt MaxHeroLevel
	FinalRound   = 4  // Win: khi udg_Round == 5

	StartGold = 200 // Starting_Gold

	// Trigger_Next_Round
	RoundWinXP     = 300
	RoundWinGold   = 200
	RoundAllGold   = 100
	RoundWinScore  = 5
	CheckpointBase = 150.0 // Lvl1..14: 150 * 1.08^score
	CheckpointMul  = 1.08

	// P1_Revive
	ReviveBonusGold = 30
	ReviveBonusXP   = 50
	RevivedGold     = -15
	RevivedXP       = -20

	IceTile  = "Nice"
	RockTile = "Nrck" // Thaw đổi băng thành đá
)

// AbilityDef mô tả một skill của Goku (E000 uhab: A004,A002,A001,A003,A000).
type AbilityDef struct {
	Key      string    `json:"key"`
	Name     string    `json:"name"`
	Desc     string    `json:"desc"`
	MaxLevel int       `json:"maxLevel"`
	Cooldown []float64 `json:"cooldown"`
	Mana     []float64 `json:"mana"`
	Target   string    `json:"target"` // "none" | "point"
	Range    float64   `json:"range"`
}

var Abilities = []AbilityDef{
	{
		Key: "Q", Name: "Nhảy", MaxLevel: 4,
		Desc:     "Bay lên không trung, rồng không chạm được. Cấp càng cao bay càng lâu. (A001 + trigger JUMp)",
		Cooldown: []float64{10, 20, 30, 20}, Mana: []float64{75, 75, 75, 70}, Target: "none",
	},
	{
		Key: "W", Name: "Phong hành", MaxLevel: 3,
		Desc:     "Tàng hình và tăng tốc 20/40/70% trong 25/40/60 giây - trượt băng cũng nhanh hơn. (A004 Wind Walk)",
		Cooldown: []float64{5, 5, 5}, Mana: []float64{75, 75, 75}, Target: "none",
	},
	{
		Key: "E", Name: "Bầy dơi", MaxLevel: 4,
		Desc:     "Phóng bầy dơi theo hình nón gây 80/140/250/350 sát thương lên rồng. (A002 Carrion Swarm)",
		Cooldown: []float64{10, 10, 10, 9}, Mana: []float64{110, 125, 140, 150}, Target: "point", Range: 800,
	},
	{
		Key: "R", Name: "Tăng tốc", MaxLevel: 3,
		Desc:     "Tốc độ trượt x2.25 trong 1.5 giây. (A003 + trigger Drift)",
		Cooldown: []float64{20, 18, 15}, Mana: []float64{80, 80, 80}, Target: "none",
	},
	{
		Key: "A", Name: "Làm tan băng", MaxLevel: 3,
		Desc:     "Sau 1 giây biến ô băng mục tiêu thành đá trong 6/14/29 giây - đứng trên đó sẽ không bị trượt. (A000 + trigger Thaw)",
		Cooldown: []float64{22, 30, 45}, Mana: []float64{75, 100, 150}, Target: "point", Range: 1000,
	},
}

func abilityByKey(k string) *AbilityDef {
	for i := range Abilities {
		if Abilities[i].Key == k {
			return &Abilities[i]
		}
	}
	return nil
}

func levelOr(v []float64, lvl int) float64 {
	if lvl < 1 {
		lvl = 1
	}
	if lvl > len(v) {
		lvl = len(v)
	}
	return v[lvl-1]
}

var (
	windWalkSpeed = []float64{0.2, 0.4, 0.7}
	windWalkDur   = []float64{25, 40, 60}
	swarmDamage   = []float64{80, 140, 250, 350}
	thawDuration  = []float64{6, 14, 29}
)

const (
	swarmLength    = 800.0
	swarmStartHalf = 50.0  // độ rộng đầu 100
	swarmEndHalf   = 150.0 // độ rộng cuối 300
	driftBonus     = 1.25
	driftDuration  = 1.5
	thawDelay      = 1.0
)

// XP cần để đạt level L (công thức mặc định của WC3: 200, 500, 900, ...).
func xpForLevel(l int) int {
	if l <= 1 {
		return 0
	}
	return xpForLevel(l-1) + 100*l
}

// Rồng tăng thêm sau mỗi vòng (trigger Set_level). Center = sinh tại tâm vùng.
type spawnSpec struct {
	Area   string
	Count  int
	Center bool
}

var roundSpawns = []spawnSpec{
	{"Wolf_Area_One", 11, false},
	{"Wofl_Area_Three", 11, false},
	{"Wofl_Area_Five", 11, false},
	{"Wolf_Area_Seven", 11, false},
	{"Wofl_Area_Nine", 3, false},
	{"Wofl_Area_Eleven", 3, false},
	{"Wolf_Area_Thirteen", 3, false},
	{"Wolf_Area_Fifteen", 3, false},
	{"Wolf_Area_Two", 3, false},
	{"Wolf_Area_Four", 2, true},
	{"Wolf_Area_Six", 2, true},
	{"Wolf_Area_Eight", 2, true},
	{"Wolf_Area_Ten", 2, true},
	{"Wolf_Area_Twelve", 2, true},
}

// Các vùng rồng đi lang thang (Wolf_Area_*: rời vùng thì bị ra lệnh quay lại).
var wolfAreas = []string{
	"Wolf_Area_One", "Wolf_Area_Two", "Wofl_Area_Three", "Wolf_Area_Four", "Wofl_Area_Five",
	"Wolf_Area_Six", "Wolf_Area_Seven", "Wolf_Area_Eight", "Wofl_Area_Nine", "Wolf_Area_Ten",
	"Wofl_Area_Eleven", "Wolf_Area_Twelve", "Wolf_Area_Thirteen", "Wolf_Area_Fourteen", "Wolf_Area_Fifteen",
}

// Thông báo khi qua vòng (TRIGSTR_293..295), viết lại có dấu.
var roundMessages = map[int]string{
	1: "Vòng 2. Chúc may mắn!",
	2: "Vòng 3, coi chừng lên bàn thờ ông bà!",
	3: "Vòng cuối! Đến được vòng này là giỏi rồi, nhưng đừng lo, coi chừng chết!",
}

const (
	msgWelcome = "Goku trượt băng!!! Chào mừng đã đến!!!"
	msgWin     = "WIN!!! Bạn giỏi thật!!!"
	msgLose    = "Goku trượt tuyết thư giãn... Tất cả đã bị rồng hạ gục!"
)

// Màu người chơi WC3 theo slot.
var PlayerColors = []string{
	"#ff0303", "#0042ff", "#1ce6b9", "#540081", "#fffc01", "#fe8a0e",
	"#20c000", "#e55bb0", "#959697", "#7ebff1", "#106246", "#4e2a04",
}

// DoodadBlockRadius: bán kính chặn đường của vật trang trí (theo kích thước
// hiển thị, nhân với scale của doodad). 0 = không chặn (vd vòng trang trí).
// Client (web/src/game/predict.ts) dùng đúng bảng này để dự đoán khớp server.
var DoodadBlockRadius = map[string]float64{
	"IOst": 34, // cụm pha lê lớn ở góc đường
	"NRic": 24, // tảng băng
	// IWbg (tinh thể nhỏ) không chặn: 64 viên xếp thành vạch đích Next_Round
	"IOob": 20, // cột băng
	"YOfb": 24, // bát lửa
	"D000": 18,
	"ITig": 18,
}
