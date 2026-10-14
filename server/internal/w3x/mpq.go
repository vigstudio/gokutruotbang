// Package w3x reads the parts of a Warcraft III map (.w3x) needed to port it:
// the MPQ container, terrain (w3e), pathing (wpm), strings (wts) and the
// JASS script (war3map.j).
package w3x

import (
	"bytes"
	"compress/bzip2"
	"compress/zlib"
	"encoding/binary"
	"errors"
	"fmt"
	"io"
	"os"
	"strings"
)

const (
	flagImplode    = 0x00000100
	flagCompress   = 0x00000200
	flagEncrypted  = 0x00010000
	flagFixKey     = 0x00020000
	flagSingleUnit = 0x01000000
	flagExists     = 0x80000000

	hashEmpty   = 0xFFFFFFFF
	hashDeleted = 0xFFFFFFFE
)

var cryptTable = func() [0x500]uint32 {
	var t [0x500]uint32
	seed := uint32(0x00100001)
	for i := 0; i < 0x100; i++ {
		idx := i
		for j := 0; j < 5; j++ {
			seed = (seed*125 + 3) % 0x2AAAAB
			t1 := (seed & 0xFFFF) << 16
			seed = (seed*125 + 3) % 0x2AAAAB
			t[idx] = t1 | (seed & 0xFFFF)
			idx += 0x100
		}
	}
	return t
}()

func hashString(s string, typ uint32) uint32 {
	s1, s2 := uint32(0x7FED7FED), uint32(0xEEEEEEEE)
	for _, ch := range []byte(strings.ToUpper(s)) {
		s1 = cryptTable[(typ<<8)+uint32(ch)] ^ (s1 + s2)
		s2 = uint32(ch) + s1 + s2 + (s2 << 5) + 3
	}
	return s1
}

func decrypt(data []byte, key uint32) []byte {
	out := make([]byte, len(data))
	copy(out, data)
	seed := uint32(0xEEEEEEEE)
	for i := 0; i+4 <= len(out); i += 4 {
		seed += cryptTable[0x400+(key&0xFF)]
		ch := binary.LittleEndian.Uint32(out[i:]) ^ (key + seed)
		key = ((^key << 0x15) + 0x11111111) | (key >> 0x0B)
		seed = ch + seed + (seed << 5) + 3
		binary.LittleEndian.PutUint32(out[i:], ch)
	}
	return out
}

type hashEntry struct {
	a, b  uint32
	block uint32
}

type blockEntry struct {
	pos, csize, fsize, flags uint32
}

// Archive is a read-only, in-memory MPQ archive. It tolerates the header
// tricks used by map "protectors" (garbage header size, odd sector shift).
type Archive struct {
	data       []byte
	base       int
	sectorSize int
	hash       []hashEntry
	block      []blockEntry
}

func Open(path string) (*Archive, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	return Parse(data)
}

func Parse(data []byte) (*Archive, error) {
	base := -1
	for off := 0; off+32 <= len(data); off += 512 {
		if bytes.Equal(data[off:off+4], []byte("MPQ\x1a")) {
			base = off
			break
		}
	}
	if base < 0 {
		return nil, errors.New("không tìm thấy header MPQ")
	}
	h := data[base:]
	shift := binary.LittleEndian.Uint16(h[14:])
	htPos := int(binary.LittleEndian.Uint32(h[16:]))
	btPos := int(binary.LittleEndian.Uint32(h[20:]))
	htCount := int(binary.LittleEndian.Uint32(h[24:]))
	btCount := int(binary.LittleEndian.Uint32(h[28:]))

	a := &Archive{data: data, base: base, sectorSize: 512 << shift}
	ht := a.table(htPos, htCount, "(hash table)")
	bt := a.table(btPos, btCount, "(block table)")
	for i := 0; i+16 <= len(ht); i += 16 {
		a.hash = append(a.hash, hashEntry{
			a:     binary.LittleEndian.Uint32(ht[i:]),
			b:     binary.LittleEndian.Uint32(ht[i+4:]),
			block: binary.LittleEndian.Uint32(ht[i+12:]),
		})
	}
	for i := 0; i+16 <= len(bt); i += 16 {
		a.block = append(a.block, blockEntry{
			pos:   binary.LittleEndian.Uint32(bt[i:]),
			csize: binary.LittleEndian.Uint32(bt[i+4:]),
			fsize: binary.LittleEndian.Uint32(bt[i+8:]),
			flags: binary.LittleEndian.Uint32(bt[i+12:]),
		})
	}
	if len(a.hash) == 0 {
		return nil, errors.New("hash table rỗng")
	}
	return a, nil
}

func (a *Archive) table(pos, count int, keyName string) []byte {
	start := a.base + pos
	end := start + count*16
	if start > len(a.data) {
		return nil
	}
	if end > len(a.data) {
		end = len(a.data)
	}
	raw := a.data[start:end]
	raw = raw[:len(raw)/16*16]
	return decrypt(raw, hashString(keyName, 3))
}

func (a *Archive) find(name string) (blockEntry, bool) {
	n := uint32(len(a.hash))
	start := hashString(name, 0) % n
	ha, hb := hashString(name, 1), hashString(name, 2)
	for k := uint32(0); k < n; k++ {
		e := a.hash[(start+k)%n]
		if e.block == hashEmpty {
			break
		}
		if e.a == ha && e.b == hb && e.block != hashDeleted && int(e.block) < len(a.block) {
			return a.block[e.block], true
		}
	}
	return blockEntry{}, false
}

// Has reports whether the archive contains name.
func (a *Archive) Has(name string) bool {
	_, ok := a.find(name)
	return ok
}

// ReadFile extracts a file by its full archive path (backslash separated).
func (a *Archive) ReadFile(name string) ([]byte, error) {
	b, ok := a.find(name)
	if !ok || b.flags&flagExists == 0 {
		return nil, fmt.Errorf("%s: không có trong archive", name)
	}
	start := a.base + int(b.pos)
	end := start + int(b.csize)
	if start < 0 || end > len(a.data) || start > end {
		return nil, fmt.Errorf("%s: block nằm ngoài file", name)
	}
	raw := a.data[start:end]
	fsize := int(b.fsize)

	var key uint32
	encrypted := b.flags&flagEncrypted != 0
	if encrypted {
		base := name[strings.LastIndexAny(name, `\/`)+1:]
		key = hashString(base, 3)
		if b.flags&flagFixKey != 0 {
			key = (key + b.pos) ^ b.fsize
		}
	}

	compressed := b.flags&(flagCompress|flagImplode) != 0
	if b.flags&flagSingleUnit != 0 || !compressed {
		if encrypted {
			raw = decrypt(raw, key)
		}
		if compressed && len(raw) < fsize {
			return decompress(raw, fsize, b.flags)
		}
		if len(raw) < fsize {
			return nil, fmt.Errorf("%s: dữ liệu ngắn hơn kích thước", name)
		}
		return raw[:fsize], nil
	}

	sectors := (fsize + a.sectorSize - 1) / a.sectorSize
	tblLen := (sectors + 1) * 4
	if len(raw) < tblLen {
		return nil, fmt.Errorf("%s: sector table hỏng", name)
	}
	tbl := raw[:tblLen]
	if encrypted {
		tbl = decrypt(tbl, key-1)
	}
	out := make([]byte, 0, fsize)
	for i := 0; i < sectors; i++ {
		s := int(binary.LittleEndian.Uint32(tbl[i*4:]))
		e := int(binary.LittleEndian.Uint32(tbl[i*4+4:]))
		if s > e || e > len(raw) {
			return nil, fmt.Errorf("%s: sector %d hỏng", name, i)
		}
		sd := raw[s:e]
		if encrypted {
			sd = decrypt(sd, key+uint32(i))
		}
		want := a.sectorSize
		if rest := fsize - i*a.sectorSize; rest < want {
			want = rest
		}
		if len(sd) < want {
			d, err := decompress(sd, want, b.flags)
			if err != nil {
				return nil, fmt.Errorf("%s: %w", name, err)
			}
			sd = d
		}
		out = append(out, sd[:want]...)
	}
	return out, nil
}

func decompress(data []byte, size int, flags uint32) ([]byte, error) {
	if flags&flagImplode != 0 && flags&flagCompress == 0 {
		return nil, errors.New("PKWARE implode chưa được hỗ trợ")
	}
	method := data[0]
	d := data[1:]
	var r io.Reader = bytes.NewReader(d)
	switch method {
	case 0x02:
		zr, err := zlib.NewReader(r)
		if err != nil {
			return nil, err
		}
		defer zr.Close()
		r = zr
	case 0x10:
		r = bzip2.NewReader(r)
	default:
		return nil, fmt.Errorf("kiểu nén 0x%02x chưa được hỗ trợ", method)
	}
	out, err := io.ReadAll(io.LimitReader(r, int64(size)))
	if err != nil {
		return nil, err
	}
	return out, nil
}
