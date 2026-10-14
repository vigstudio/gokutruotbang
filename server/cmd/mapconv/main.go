// mapconv đọc file map Warcraft III (.w3x) và xuất dữ liệu cần cho bản web
// (địa hình, pathing, region, vị trí unit) ra JSON.
//
//	go run ./cmd/mapconv -in "../Goku truot bang v2.2.w3x" -out internal/mapdata/map.json -dump ../docs/original
package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"

	"gokutruotbang/internal/mapdata"
	"gokutruotbang/internal/w3x"
)

func main() {
	in := flag.String("in", "../Goku truot bang v2.2.w3x", "file map .w3x")
	out := flag.String("out", "internal/mapdata/map.json", "file JSON đầu ra")
	dump := flag.String("dump", "", "thư mục để giải nén script/strings gốc (tùy chọn)")
	assets := flag.String("assets", "", "thư mục để trích model/texture/âm thanh import (vd ../web/public/assets)")
	flag.Parse()

	ar, err := w3x.Open(*in)
	if err != nil {
		log.Fatal(err)
	}
	read := func(names ...string) []byte {
		for _, n := range names {
			if b, err := ar.ReadFile(n); err == nil {
				return b
			}
		}
		log.Fatalf("không đọc được %v", names)
		return nil
	}

	script := read(`war3map.j`, `scripts\war3map.j`)
	w3e := read(`war3map.w3e`)
	wpm := read(`war3map.wpm`)
	wts := read(`war3map.wts`)

	terr, err := w3x.ParseW3E(w3e)
	if err != nil {
		log.Fatal(err)
	}
	path, err := w3x.ParseWPM(wpm)
	if err != nil {
		log.Fatal(err)
	}
	js, err := w3x.ParseJASS(script)
	if err != nil {
		log.Fatal(err)
	}
	strs := w3x.ParseWTS(wts)
	doodads, err := w3x.ParseDOO(read(`war3map.doo`))
	if err != nil {
		log.Fatal(err)
	}

	walk := make([]byte, len(path.Cells))
	for i, c := range path.Cells {
		if c&w3x.PathNoWalk == 0 {
			walk[i] = 1
		}
	}

	m := mapdata.Map{
		Name:        strs[1],
		Author:      strs[4],
		Description: strings.TrimSpace(strs[3]),
		Bounds:      js.Bounds,
		Terrain: mapdata.Terrain{
			OriginX: terr.OriginX, OriginY: terr.OriginY, CellSize: 128,
			Cols: terr.Cols, Rows: terr.Rows, Tiles: terr.Tiles,
			Ground: terr.Ground, Layer: terr.Layer,
		},
		Pathing: mapdata.Pathing{
			OriginX: terr.OriginX, OriginY: terr.OriginY, CellSize: 32,
			Cols: path.Cols, Rows: path.Rows, Walkable: walk,
		},
		Regions: js.Regions,
		Units:   js.Units,
		Doodads: doodads,
	}
	b, err := json.Marshal(m)
	if err != nil {
		log.Fatal(err)
	}
	if err := os.WriteFile(*out, b, 0o644); err != nil {
		log.Fatal(err)
	}
	fmt.Printf("Đã ghi %s: %d region, %d unit, %d doodad, terrain %dx%d, pathing %dx%d\n",
		*out, len(m.Regions), len(m.Units), len(m.Doodads), terr.Cols, terr.Rows, path.Cols, path.Rows)

	if *assets != "" {
		extractAssets(ar, *assets, script, read(`war3map.w3u`))
	}

	if *dump != "" {
		os.MkdirAll(*dump, 0o755)
		os.WriteFile(filepath.Join(*dump, "war3map.j"), []byte(strings.ReplaceAll(string(script), "\r", "\n")), 0o644)
		os.WriteFile(filepath.Join(*dump, "war3map.wts"), wts, 0o644)
		fmt.Println("Đã giải nén script gốc vào", *dump)
	}
}

// extractAssets trích các file import mà map tham chiếu (model, texture của
// model, âm thanh) và ghi danh sách vào index.json.
func extractAssets(ar *w3x.Archive, dir string, sources ...[]byte) {
	// ảnh minimap và ảnh preview của map, kèm các file mà map tham chiếu
	queue := append([]string{"war3mapMap.blp", "war3mapPreview.tga"}, w3x.AssetPaths(sources...)...)
	seen := map[string]bool{}
	var got []string
	for len(queue) > 0 {
		p := queue[0]
		queue = queue[1:]
		key := strings.ToLower(p)
		if seen[key] {
			continue
		}
		seen[key] = true
		b, err := ar.ReadFile(p)
		if err != nil {
			continue // file có sẵn trong game, không nằm trong map
		}
		queue = append(queue, w3x.MDXTextures(b)...)
		rel := filepath.ToSlash(strings.ReplaceAll(p, `\`, "/"))
		dst := filepath.Join(dir, filepath.FromSlash(rel))
		os.MkdirAll(filepath.Dir(dst), 0o755)
		if err := os.WriteFile(dst, b, 0o644); err != nil {
			log.Fatal(err)
		}
		got = append(got, rel)
		fmt.Printf("  asset %s (%d byte)\n", rel, len(b))
	}
	idx, _ := json.MarshalIndent(got, "", "  ")
	os.WriteFile(filepath.Join(dir, "index.json"), idx, 0o644)
	fmt.Printf("Đã trích %d file vào %s\n", len(got), dir)
}
