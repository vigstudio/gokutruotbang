package w3x

import (
	"bytes"
	"encoding/binary"
	"regexp"
	"strings"
)

var reAssetPath = regexp.MustCompile(`(?i)[A-Za-z0-9_\\/ .=\-]{3,259}\.(mdl|mdx|blp|tga|wav|mp3)`)

// AssetPaths tìm các đường dẫn file (model, texture, âm thanh) được nhắc tới
// trong dữ liệu (w3u, war3map.j…). Model ".mdl" trong object data thực ra
// được lưu là ".mdx" trong archive.
func AssetPaths(data ...[]byte) []string {
	seen := map[string]bool{}
	var out []string
	for _, b := range data {
		for _, m := range reAssetPath.FindAll(b, -1) {
			p := strings.ReplaceAll(strings.TrimSpace(string(m)), `\\`, `\`)
			if strings.HasSuffix(strings.ToLower(p), ".mdl") {
				p = p[:len(p)-4] + ".mdx"
			}
			if !seen[strings.ToLower(p)] {
				seen[strings.ToLower(p)] = true
				out = append(out, p)
			}
		}
	}
	return out
}

// MDXTextures trả về các texture mà một model MDX dùng (chunk TEXS).
func MDXTextures(b []byte) []string {
	if len(b) < 4 || string(b[:4]) != "MDLX" {
		return nil
	}
	var out []string
	for p := 4; p+8 <= len(b); {
		tag := string(b[p : p+4])
		size := int(binary.LittleEndian.Uint32(b[p+4:]))
		body := b[p+8:]
		if size > len(body) {
			break
		}
		if tag == "TEXS" {
			for i := 0; i+268 <= size; i += 268 {
				path := body[i+4 : i+264]
				if n := bytes.IndexByte(path, 0); n >= 0 {
					path = path[:n]
				}
				if len(path) > 0 {
					out = append(out, string(path))
				}
			}
		}
		p += 8 + size
	}
	return out
}
