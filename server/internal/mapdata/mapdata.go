// Package mapdata holds the map converted from "Goku truot bang v2.2.w3x"
// (see cmd/mapconv) and fast lookups used by the simulation.
package mapdata

import (
	_ "embed"
	"encoding/json"
	"math"

	"gokutruotbang/internal/w3x"
)

type Rect = w3x.Rect
type PlacedUnit = w3x.PlacedUnit
type Doodad = w3x.Doodad

// Terrain: ground texture per corner. []byte fields are base64 in JSON.
type Terrain struct {
	OriginX  float64  `json:"originX"`
	OriginY  float64  `json:"originY"`
	CellSize float64  `json:"cellSize"`
	Cols     int      `json:"cols"`
	Rows     int      `json:"rows"`
	Tiles    []string `json:"tiles"`
	Ground   []byte   `json:"ground"`
	Layer    []byte   `json:"layer"`
}

// Pathing: 1 = walkable, 0 = blocked, one byte per 32x32 cell.
type Pathing struct {
	OriginX  float64 `json:"originX"`
	OriginY  float64 `json:"originY"`
	CellSize float64 `json:"cellSize"`
	Cols     int     `json:"cols"`
	Rows     int     `json:"rows"`
	Walkable []byte  `json:"walkable"`
}

type Map struct {
	Name        string          `json:"name"`
	Author      string          `json:"author"`
	Description string          `json:"description"`
	Bounds      Rect            `json:"bounds"`
	Terrain     Terrain         `json:"terrain"`
	Pathing     Pathing         `json:"pathing"`
	Regions     map[string]Rect `json:"regions"`
	Units       []PlacedUnit    `json:"units"`
	Doodads     []Doodad        `json:"doodads"`
}

//go:embed map.json
var raw []byte

// Raw returns the JSON as served to the web client.
func Raw() []byte { return raw }

// Load parses the embedded map.
func Load() (*Map, error) {
	var m Map
	if err := json.Unmarshal(raw, &m); err != nil {
		return nil, err
	}
	return &m, nil
}

// CornerIndex returns the terrain corner nearest to (x, y), like
// GetTerrainType in JASS, or -1 outside the map.
func (m *Map) CornerIndex(x, y float64) int {
	t := &m.Terrain
	cx := int(math.Floor((x-t.OriginX)/t.CellSize + 0.5))
	cy := int(math.Floor((y-t.OriginY)/t.CellSize + 0.5))
	if cx < 0 || cy < 0 || cx >= t.Cols || cy >= t.Rows {
		return -1
	}
	return cy*t.Cols + cx
}

// CornerPos returns the world position of corner i.
func (m *Map) CornerPos(i int) (float64, float64) {
	t := &m.Terrain
	return t.OriginX + float64(i%t.Cols)*t.CellSize, t.OriginY + float64(i/t.Cols)*t.CellSize
}

// TileName returns the ground tile id of corner i ("" if out of range).
func (m *Map) TileName(i int) string {
	if i < 0 || i >= len(m.Terrain.Ground) {
		return ""
	}
	g := int(m.Terrain.Ground[i])
	if g >= len(m.Terrain.Tiles) {
		return ""
	}
	return m.Terrain.Tiles[g]
}

// Walkable reports whether a ground unit may stand at (x, y).
func (m *Map) Walkable(x, y float64) bool {
	b := m.Bounds
	if x < b.MinX || x > b.MaxX || y < b.MinY || y > b.MaxY {
		return false
	}
	p := &m.Pathing
	cx := int(math.Floor((x - p.OriginX) / p.CellSize))
	cy := int(math.Floor((y - p.OriginY) / p.CellSize))
	if cx < 0 || cy < 0 || cx >= p.Cols || cy >= p.Rows {
		return false
	}
	return p.Walkable[cy*p.Cols+cx] == 1
}

func Contains(r Rect, x, y float64) bool {
	return x >= r.MinX && x <= r.MaxX && y >= r.MinY && y <= r.MaxY
}
