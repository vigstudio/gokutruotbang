package game

import (
	"math"
	"testing"
)

// Độ phủ: tỉ lệ ô băng (sát tường / giữa đường) có rồng đi qua trong 4 phút.
func probeCoverage(t *testing.T, g *Game) (edge, mid float64) {
	b := g.m.Bounds
	const cell = 32.0
	nx := int((b.MaxX - b.MinX) / cell)
	ny := int((b.MaxY - b.MinY) / cell)
	seen := make([]bool, nx*ny)
	for i := 0; i < 50*240; i++ {
		g.Tick(0.02)
		if i%5 == 0 {
			for _, d := range g.dragons {
				for dx := -KillRange; dx <= KillRange; dx += cell {
					for dy := -KillRange; dy <= KillRange; dy += cell {
						if dx*dx+dy*dy > KillRange*KillRange {
							continue
						}
						cx := int((d.X + dx - b.MinX) / cell)
						cy := int((d.Y + dy - b.MinY) / cell)
						if cx >= 0 && cy >= 0 && cx < nx && cy < ny {
							seen[cy*nx+cx] = true
						}
					}
				}
			}
		}
	}
	var ne, ce, nm, cm int
	for cy := 0; cy < ny; cy++ {
		for cx := 0; cx < nx; cx++ {
			x := b.MinX + (float64(cx)+0.5)*cell
			y := b.MinY + (float64(cy)+0.5)*cell
			if g.tileAt(x, y) != IceTile || !g.canStand(x, y) {
				continue
			}
			nearWall := false
			for a := 0.0; a < 360 && !nearWall; a += 30 {
				nearWall = !g.m.Walkable(x+40*math.Cos(a*math.Pi/180), y+40*math.Sin(a*math.Pi/180))
			}
			if nearWall {
				ne++
				if seen[cy*nx+cx] {
					ce++
				}
			} else {
				nm++
				if seen[cy*nx+cx] {
					cm++
				}
			}
		}
	}
	return 100 * float64(ce) / float64(ne), 100 * float64(cm) / float64(nm)
}

// Dải băng sát tường không được thành chỗ trốn rồng an toàn.
func TestDragonsReachEdges(t *testing.T) {
	g := New(load(t), map[int]string{0: "A"}, 1)
	g.Phase = PhasePlaying
	delete(g.Heroes, 0)
	e, m := probeCoverage(t, g)
	t.Logf("độ phủ của rồng: sát tường %.1f%%, giữa đường %.1f%%", e, m)
	if e < 85 {
		t.Fatalf("rồng chỉ phủ %.1f%% dải sát tường", e)
	}
}

// Vật trang trí chặn đường nhưng không được chặn điểm xuất phát / vạch đích.
func TestBlockersKeepPathsOpen(t *testing.T) {
	g := New(load(t), map[int]string{0: "A"}, 1)
	for slot, st := range g.starts {
		if !g.canStand(st[0], st[1]) {
			t.Errorf("điểm xuất phát slot %d bị vật trang trí chặn", slot)
		}
	}
	r := g.m.Regions["Next_Round"]
	open := 0
	for y := r.MinY; y <= r.MaxY; y += 8 {
		if g.canStand((r.MinX+r.MaxX)/2, y) {
			open++
		}
	}
	if open == 0 {
		t.Fatal("vạch đích bị chặn hoàn toàn")
	}
	// đi xuyên pha lê lớn ở góc: phải bị chặn
	blocked := 0
	for _, b := range g.blockers {
		if !g.canStand(b.X, b.Y) {
			blocked++
		}
	}
	if blocked != len(g.blockers) {
		t.Fatalf("chỉ %d/%d vật trang trí chặn được", blocked, len(g.blockers))
	}
	h := g.Heroes[0]
	b := g.blockers[0]
	h.X, h.Y = b.X+1, b.Y
	g.pushOut(h)
	if math.Hypot(h.X-b.X, h.Y-b.Y) < b.R+HeroRadius && g.m.Walkable(b.X+b.R+HeroRadius+1, b.Y) {
		t.Fatal("không đẩy Goku ra khỏi vật trang trí")
	}
}
