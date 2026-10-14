package game

import (
	"bytes"
	"compress/flate"
	"encoding/json"
	"testing"
)

func deflated(t *testing.T, v any) (int, int) {
	b, _ := json.Marshal(v)
	var z bytes.Buffer
	w, _ := flate.NewWriter(&z, 1)
	w.Write(b)
	w.Close()
	return len(b), z.Len()
}

// Đo dung lượng snapshot gửi cho một người chơi (11 người trong phòng).
func TestSnapshotSize(t *testing.T) {
	players := map[int]string{}
	for i := 0; i < 11; i++ {
		players[i] = "Player_" + string(rune('A'+i))
	}
	g := New(load(t), players, 1)
	g.Phase = PhasePlaying
	for round := 1; round <= 4; round++ {
		for i := 0; i < 50*5; i++ {
			g.Tick(0.02)
		}
		h := g.Heroes[3]
		_, normal := deflated(t, g.SnapshotFor(3, View{}, false))
		_, withMM := deflated(t, g.SnapshotFor(3, View{}, true))
		full, fullZ := deflated(t, g.Snapshot())
		// 25 snapshot/s, 2 lần/s có kèm bản đồ nhỏ
		rate := (float64(normal)*23 + float64(withMM)*2) / 1024
		t.Logf("vòng %d: %d rồng, Goku ở (%.0f,%.0f): %d B/snap (mm %d B) -> %.1f KB/s mỗi người; toàn cảnh %d B (deflate %d)",
			round, len(g.dragons), h.X, h.Y, normal, withMM, rate, full, fullZ)
		g.spawnRoundDragons()
		g.Round++
	}
}
