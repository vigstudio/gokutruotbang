package w3x

import (
	"bufio"
	"bytes"
	"encoding/binary"
	"errors"
	"fmt"
	"math"
	"regexp"
	"strconv"
	"strings"
)

// Terrain is war3map.w3e: a grid of tile corners, 128 world units apart.
type Terrain struct {
	Tileset  string
	Tiles    []string // ground tileset ids, e.g. "Nice" (băng), "Xblm" (đá hoa)
	Cliffs   []string
	Cols     int
	Rows     int
	OriginX  float64
	OriginY  float64
	Ground   []uint8 // index into Tiles, per corner, row-major from bottom-left
	Layer    []uint8 // cliff level per corner
	Height   []int16
	Water    []uint8 // 1 if the corner has the water flag
	Boundary []uint8 // 1 if the corner is a map boundary
}

func ParseW3E(b []byte) (*Terrain, error) {
	if len(b) < 16 || string(b[:4]) != "W3E!" {
		return nil, errors.New("w3e: sai magic")
	}
	r := bytes.NewReader(b[4:])
	var ver uint32
	binary.Read(r, binary.LittleEndian, &ver)
	t := &Terrain{}
	ts, _ := r.ReadByte()
	t.Tileset = string(ts)
	var custom, n uint32
	binary.Read(r, binary.LittleEndian, &custom)
	readIDs := func() []string {
		binary.Read(r, binary.LittleEndian, &n)
		ids := make([]string, n)
		for i := range ids {
			var id [4]byte
			r.Read(id[:])
			ids[i] = string(id[:])
		}
		return ids
	}
	t.Tiles = readIDs()
	t.Cliffs = readIDs()
	var w, h uint32
	var ox, oy float32
	binary.Read(r, binary.LittleEndian, &w)
	binary.Read(r, binary.LittleEndian, &h)
	binary.Read(r, binary.LittleEndian, &ox)
	binary.Read(r, binary.LittleEndian, &oy)
	t.Cols, t.Rows = int(w), int(h)
	t.OriginX, t.OriginY = float64(ox), float64(oy)
	cnt := t.Cols * t.Rows
	if r.Len() < cnt*7 {
		return nil, fmt.Errorf("w3e: thiếu dữ liệu (%d corner)", cnt)
	}
	t.Ground = make([]uint8, cnt)
	t.Layer = make([]uint8, cnt)
	t.Height = make([]int16, cnt)
	t.Water = make([]uint8, cnt)
	t.Boundary = make([]uint8, cnt)
	var rec [7]byte
	for i := 0; i < cnt; i++ {
		r.Read(rec[:])
		t.Height[i] = int16(binary.LittleEndian.Uint16(rec[0:]))
		wl := binary.LittleEndian.Uint16(rec[2:])
		t.Boundary[i] = uint8(wl >> 14 & 1)
		flags := rec[4] >> 4
		t.Ground[i] = rec[4] & 0x0F
		if flags&0x4 != 0 {
			t.Water[i] = 1
		}
		t.Layer[i] = rec[6] & 0x0F
	}
	return t, nil
}

// Pathing is war3map.wpm: one byte per 32x32 world-unit cell.
type Pathing struct {
	Cols, Rows int
	Cells      []uint8
}

const (
	PathNoWalk  = 0x02
	PathNoFly   = 0x04
	PathNoBuild = 0x08
)

func ParseWPM(b []byte) (*Pathing, error) {
	if len(b) < 16 || string(b[:4]) != "MP3W" {
		return nil, errors.New("wpm: sai magic")
	}
	w := int(binary.LittleEndian.Uint32(b[8:]))
	h := int(binary.LittleEndian.Uint32(b[12:]))
	if len(b) < 16+w*h {
		return nil, errors.New("wpm: thiếu dữ liệu")
	}
	return &Pathing{Cols: w, Rows: h, Cells: b[16 : 16+w*h]}, nil
}

// ParseWTS parses the trigger string table: STRING n { text }.
func ParseWTS(b []byte) map[int]string {
	b = bytes.TrimPrefix(b, []byte{0xEF, 0xBB, 0xBF})
	out := map[int]string{}
	sc := bufio.NewScanner(bytes.NewReader(b))
	sc.Buffer(make([]byte, 1<<20), 1<<20)
	id := -1
	var cur []string
	in := false
	for sc.Scan() {
		line := strings.TrimRight(sc.Text(), "\r")
		switch {
		case !in && strings.HasPrefix(line, "STRING "):
			id, _ = strconv.Atoi(strings.TrimSpace(line[7:]))
		case !in && line == "{":
			in, cur = true, nil
		case in && line == "}":
			out[id] = strings.Join(cur, "\n")
			in = false
		case in:
			cur = append(cur, line)
		}
	}
	return out
}

// Rect is an axis-aligned world rectangle (a "region" in the World Editor).
type Rect struct {
	MinX float64 `json:"minX"`
	MinY float64 `json:"minY"`
	MaxX float64 `json:"maxX"`
	MaxY float64 `json:"maxY"`
}

// PlacedUnit is a unit created by the generated CreateUnitsForPlayerN functions.
type PlacedUnit struct {
	Type   string  `json:"type"`
	Owner  int     `json:"owner"` // 0..11 players, 15 = neutral passive
	X      float64 `json:"x"`
	Y      float64 `json:"y"`
	Facing float64 `json:"facing"`
}

var (
	reRect     = regexp.MustCompile(`set gg_rct_(\w+)=Rect\(([-\d.]+),([-\d.]+),([-\d.]+),([-\d.]+)\)`)
	rePlayer   = regexp.MustCompile(`local player p=Player\((\w+)\)`)
	reUnit     = regexp.MustCompile(`CreateUnit\(p,'(\w{4})',([-\d.]+),([-\d.]+),([-\d.]+)\)`)
	reCamBound = regexp.MustCompile(`call SetCameraBounds\(([-\d.]+)\+GetCameraMargin\(CAMERA_MARGIN_LEFT\),([-\d.]+)\+GetCameraMargin\(CAMERA_MARGIN_BOTTOM\),([-\d.]+)-GetCameraMargin\(CAMERA_MARGIN_RIGHT\),([-\d.]+)-`)
)

// Script holds the data extracted from war3map.j.
type Script struct {
	Regions map[string]Rect
	Units   []PlacedUnit
	Bounds  Rect // playable area (camera bounds)
}

func ParseJASS(src []byte) (*Script, error) {
	text := strings.ReplaceAll(string(src), "\r\n", "\n")
	text = strings.ReplaceAll(text, "\r", "\n")
	s := &Script{Regions: map[string]Rect{}}
	f := func(v string) float64 { x, _ := strconv.ParseFloat(v, 64); return x }
	for _, m := range reRect.FindAllStringSubmatch(text, -1) {
		s.Regions[m[1]] = Rect{f(m[2]), f(m[3]), f(m[4]), f(m[5])}
	}
	owner := -1
	for _, line := range strings.Split(text, "\n") {
		if m := rePlayer.FindStringSubmatch(line); m != nil {
			if m[1] == "PLAYER_NEUTRAL_PASSIVE" {
				owner = 15
			} else {
				owner, _ = strconv.Atoi(m[1])
			}
			continue
		}
		if strings.HasPrefix(line, "endfunction") {
			owner = -1
			continue
		}
		if m := reUnit.FindStringSubmatch(line); m != nil && owner >= 0 {
			s.Units = append(s.Units, PlacedUnit{Type: m[1], Owner: owner, X: f(m[2]), Y: f(m[3]), Facing: math.Mod(f(m[4]), 360)})
		}
	}
	if m := reCamBound.FindStringSubmatch(text); m != nil {
		s.Bounds = Rect{f(m[1]), f(m[2]), f(m[3]), f(m[4])}
	}
	if len(s.Regions) == 0 {
		return nil, errors.New("war3map.j: không tìm thấy region nào")
	}
	return s, nil
}

// Doodad là một vật trang trí (cây, đá, cột…) đặt sẵn trong war3map.doo.
type Doodad struct {
	Type  string  `json:"type"`
	X     float64 `json:"x"`
	Y     float64 `json:"y"`
	Angle float64 `json:"angle"` // độ
	Scale float64 `json:"scale"`
}

// ParseDOO đọc war3map.doo (định dạng v8 của bản Frozen Throne).
func ParseDOO(b []byte) ([]Doodad, error) {
	if len(b) < 16 || string(b[:4]) != "W3do" {
		return nil, errors.New("doo: sai magic")
	}
	ver := binary.LittleEndian.Uint32(b[4:])
	n := int(binary.LittleEndian.Uint32(b[12:]))
	p := 16
	f32 := func(o int) float64 { return float64(math.Float32frombits(binary.LittleEndian.Uint32(b[o:]))) }
	out := make([]Doodad, 0, n)
	for i := 0; i < n; i++ {
		if p+42 > len(b) {
			return out, errors.New("doo: thiếu dữ liệu")
		}
		d := Doodad{Type: string(b[p : p+4]), X: f32(p + 8), Y: f32(p + 12), Angle: f32(p+20) * 180 / math.Pi, Scale: f32(p + 24)}
		p += 38
		if ver >= 8 {
			sets := int(binary.LittleEndian.Uint32(b[p+4:]))
			p += 8
			for s := 0; s < sets && p+4 <= len(b); s++ {
				p += 4 + int(binary.LittleEndian.Uint32(b[p:]))*8
			}
		}
		p += 4 // editor id
		out = append(out, d)
	}
	return out, nil
}
