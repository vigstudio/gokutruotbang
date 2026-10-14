// Công cụ giả lập nhiều người chơi để đo hiệu năng server và mạng.
//
// Mỗi bot: mở WebSocket (bật nén như trình duyệt), đăng ký/đăng nhập, vào
// phòng; bot đầu mỗi phòng tạo phòng rồi bấm bắt đầu. Trong trận bot liên tục
// click đổi hướng/đi bộ, báo vùng camera, thỉnh thoảng học và tung chiêu.
//
//	go run ./cmd/loadtest -url ws://localhost:8080/ws -bots 11 -rooms 1 -dur 60s
//
// Tài khoản bot: <prefix><số thứ tự>, mật khẩu chung -pass (tạo mới nếu chưa có).
// Chỉ chạy vào server production khi bạn chủ động muốn tạo các tài khoản bot đó.
package main

import (
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"log"
	"math"
	"math/rand"
	"net"
	"net/http"
	"sort"
	"sync"
	"sync/atomic"
	"time"

	"github.com/gorilla/websocket"
)

var (
	url     = flag.String("url", "ws://localhost:8080/ws", "địa chỉ WebSocket")
	origin  = flag.String("origin", "", "header Origin (nếu server kiểm tra origin)")
	nBots   = flag.Int("bots", 11, "tổng số bot")
	nRooms  = flag.Int("rooms", 1, "số phòng (bot chia đều)")
	dur     = flag.Duration("dur", 60*time.Second, "thời gian đo trong trận")
	prefix  = flag.String("prefix", "loadbot", "tiền tố tên tài khoản bot (5-16 ký tự tổng)")
	pass    = flag.String("pass", "loadtest-pass-123", "mật khẩu tài khoản bot")
	verbose = flag.Bool("v", false, "in log từng bot")
	forceIP = flag.String("ip", "", "kết nối thẳng tới IP này (bỏ qua DNS), vd 203.0.113.10")
	pingN   = flag.Int("ping", 0, "chỉ đo ping N lần (không đăng nhập, không tạo tài khoản)")
)

func dialer() websocket.Dialer {
	d := websocket.Dialer{EnableCompression: true, HandshakeTimeout: 10 * time.Second}
	if *forceIP != "" {
		nd := &net.Dialer{Timeout: 10 * time.Second}
		d.NetDialContext = func(ctx context.Context, network, addr string) (net.Conn, error) {
			_, port, _ := net.SplitHostPort(addr)
			return nd.DialContext(ctx, network, net.JoinHostPort(*forceIP, port))
		}
	}
	return d
}

// pingOnly đo độ trễ WebSocket tới server (lệnh ping không cần đăng nhập).
func pingOnly(n int) {
	d := dialer()
	h := http.Header{}
	if *origin != "" {
		h.Set("Origin", *origin)
	}
	conn, _, err := d.Dial(*url, h)
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()
	var rtts []float64
	for i := 0; i < n; i++ {
		t0 := time.Now()
		conn.WriteJSON(map[string]any{"t": "ping", "c": 1})
		for {
			var m map[string]any
			if err := conn.ReadJSON(&m); err != nil {
				log.Fatal(err)
			}
			if m["t"] == "pong" {
				break
			}
		}
		rtts = append(rtts, float64(time.Since(t0).Microseconds())/1000)
		time.Sleep(100 * time.Millisecond)
	}
	sort.Float64s(rtts)
	fmt.Printf("ping %d lần (ms): min %.1f  p50 %.1f  p95 %.1f  max %.1f\n", n, rtts[0], rtts[len(rtts)/2], rtts[int(float64(len(rtts))*0.95)], rtts[len(rtts)-1])
}

type stats struct {
	bytes     atomic.Int64
	snaps     atomic.Int64
	gaps      []float64 // khoảng cách giữa 2 snapshot (ms)
	rtts      []float64
	corrected atomic.Int64
	mu        sync.Mutex
}

var st stats

type bot struct {
	i      int
	conn   *websocket.Conn
	mu     sync.Mutex
	slot   int
	room   string
	x, y   float64
	alive  bool
	phase  string
	sp     int
	seq    int
	inGame bool
}

func (b *bot) send(v map[string]any) {
	b.mu.Lock()
	defer b.mu.Unlock()
	if _, ok := v["s"]; !ok && (v["t"] == "order" || v["t"] == "cast" || v["t"] == "learn" || v["t"] == "stop") {
		b.seq++
		v["s"] = b.seq
	}
	b.conn.WriteJSON(v)
}

func (b *bot) logf(f string, a ...any) {
	if *verbose {
		log.Printf("[bot %d] "+f, append([]any{b.i}, a...)...)
	}
}

func main() {
	flag.Parse()
	if *pingN > 0 {
		pingOnly(*pingN)
		return
	}
	perRoom := int(math.Ceil(float64(*nBots) / float64(*nRooms)))
	log.Printf("%d bot, %d phòng (~%d người/phòng), đo %v sau khi vào trận", *nBots, *nRooms, perRoom, *dur)

	rooms := make([]chan string, *nRooms)
	for i := range rooms {
		rooms[i] = make(chan string, perRoom)
	}
	ready := make(chan struct{})
	var wg sync.WaitGroup // bot chạy nền, kết thúc khi hết giờ
	var measuring atomic.Bool
	for i := 0; i < *nBots; i++ {
		wg.Add(1)
		go func(i int) {
			defer wg.Done()
			ri := i / perRoom
			host := i%perRoom == 0
			if err := runBot(i, ri, host, perRoom, rooms[ri], ready, &measuring); err != nil {
				log.Printf("bot %d: %v", i, err)
			}
		}(i)
		time.Sleep(40 * time.Millisecond)
	}
	// chờ các trận bắt đầu rồi đo
	time.Sleep(12 * time.Second)
	close(ready)
	log.Printf("bắt đầu đo %v...", *dur)
	st.bytes.Store(0)
	st.snaps.Store(0)
	st.mu.Lock()
	st.gaps, st.rtts = nil, nil
	st.mu.Unlock()
	measuring.Store(true)
	t0 := time.Now()
	time.Sleep(*dur)
	measuring.Store(false)
	el := time.Since(t0).Seconds()

	st.mu.Lock()
	sort.Float64s(st.gaps)
	sort.Float64s(st.rtts)
	pct := func(a []float64, p float64) float64 {
		if len(a) == 0 {
			return 0
		}
		return a[int(math.Min(float64(len(a)-1), p*float64(len(a))))]
	}
	fmt.Println("===== KẾT QUẢ =====")
	fmt.Printf("bot: %d, phòng: %d, thời gian: %.0fs\n", *nBots, *nRooms, el)
	fmt.Printf("nhận (JSON sau giải nén): %.1f KB/s mỗi bot\n", float64(st.bytes.Load())/1024/el/float64(*nBots))
	fmt.Printf("snapshot: %.1f/s mỗi bot\n", float64(st.snaps.Load())/el/float64(*nBots))
	fmt.Printf("khoảng cách giữa 2 snapshot (ms): p50 %.0f  p95 %.0f  p99 %.0f  max %.0f\n", pct(st.gaps, .5), pct(st.gaps, .95), pct(st.gaps, .99), pct(st.gaps, 1))
	fmt.Printf("ping (ms): p50 %.0f  p95 %.0f  max %.0f\n", pct(st.rtts, .5), pct(st.rtts, .95), pct(st.rtts, 1))
	st.mu.Unlock()

}

func runBot(i, ri int, host bool, perRoom int, roomCh chan string, ready <-chan struct{}, measuring *atomic.Bool) error {
	d := dialer()
	h := http.Header{}
	if *origin != "" {
		h.Set("Origin", *origin)
	}
	conn, _, err := d.Dial(*url, h)
	if err != nil {
		return err
	}
	defer conn.Close()
	b := &bot{i: i, conn: conn, slot: -1}
	name := fmt.Sprintf("%s%d", *prefix, i)

	authed := make(chan bool, 1)
	joined := make(chan struct{}, 1)
	var lastSnap time.Time
	go func() { // đọc
		for {
			_, data, err := conn.ReadMessage()
			if err != nil {
				return
			}
			if measuring.Load() {
				st.bytes.Add(int64(len(data)))
			}
			var m map[string]any
			if json.Unmarshal(data, &m) != nil {
				continue
			}
			switch m["t"] {
			case "session":
				authed <- true
			case "auth":
				authed <- false
			case "room":
				b.mu.Lock()
				b.room, _ = m["id"].(string)
				if s, ok := m["slot"].(float64); ok {
					b.slot = int(s)
				}
				state, _ := m["state"].(string)
				b.inGame = state == "game"
				b.mu.Unlock()
				select {
				case joined <- struct{}{}:
				default:
				}
				if state == "game" {
					b.send(map[string]any{"t": "ready"})
				}
			case "pong":
				if c, ok := m["c"].(float64); ok && measuring.Load() {
					st.mu.Lock()
					st.rtts = append(st.rtts, float64(time.Now().UnixMicro())/1000-c)
					st.mu.Unlock()
				}
			case "snap":
				now := time.Now()
				if measuring.Load() {
					st.snaps.Add(1)
					if !lastSnap.IsZero() {
						st.mu.Lock()
						st.gaps = append(st.gaps, float64(now.Sub(lastSnap).Microseconds())/1000)
						st.mu.Unlock()
					}
				}
				lastSnap = now
				b.mu.Lock()
				b.phase, _ = m["phase"].(string)
				if hs, ok := m["heroes"].([]any); ok {
					for _, hh := range hs {
						hm := hh.(map[string]any)
						if s, _ := hm["s"].(float64); int(s) == b.slot {
							b.x, _ = hm["x"].(float64)
							b.y, _ = hm["y"].(float64)
							b.alive, _ = hm["a"].(bool)
							sp, _ := hm["sp"].(float64)
							b.sp = int(sp)
						}
					}
				}
				b.mu.Unlock()
			}
		}
	}()

	b.send(map[string]any{"t": "login", "username": name, "password": *pass})
	if ok := <-authed; !ok {
		b.send(map[string]any{"t": "register", "username": name, "password": *pass})
		if ok := <-authed; !ok {
			return fmt.Errorf("không đăng nhập/đăng ký được %s", name)
		}
	}
	b.logf("đã đăng nhập %s", name)

	if host {
		b.send(map[string]any{"t": "create", "name": fmt.Sprintf("Load test %d", ri)})
		<-joined
		b.mu.Lock()
		code := b.room
		b.mu.Unlock()
		for k := 1; k < perRoom; k++ {
			roomCh <- code
		}
		time.Sleep(time.Duration(perRoom)*60*time.Millisecond + 1500*time.Millisecond)
		b.send(map[string]any{"t": "start"})
	} else {
		code := <-roomCh
		b.send(map[string]any{"t": "join", "room": code})
		<-joined
	}

	rng := rand.New(rand.NewSource(int64(i) * 7919))
	tick := time.NewTicker(time.Duration(250+rng.Intn(400)) * time.Millisecond)
	ping := time.NewTicker(time.Second)
	end := time.After(*dur + 20*time.Second)
	for {
		select {
		case <-end:
			return nil
		case <-ping.C:
			b.send(map[string]any{"t": "ping", "c": float64(time.Now().UnixMicro()) / 1000})
		case <-tick.C:
			b.mu.Lock()
			x, y, alive, phase, sp := b.x, b.y, b.alive, b.phase, b.sp
			b.mu.Unlock()
			if phase != "playing" || !alive {
				continue
			}
			ang := rng.Float64() * 2 * math.Pi
			tx, ty := x+math.Cos(ang)*400, y+math.Sin(ang)*400
			b.send(map[string]any{"t": "order", "x": tx, "y": ty})
			b.send(map[string]any{"t": "cam", "x": math.Round(x), "y": math.Round(y), "c": 1800})
			if sp > 0 {
				b.send(map[string]any{"t": "learn", "ab": []string{"Q", "W", "E", "R", "A"}[rng.Intn(5)]})
			}
			if rng.Float64() < 0.08 {
				k := []string{"Q", "W", "E", "R"}[rng.Intn(4)]
				b.send(map[string]any{"t": "cast", "ab": k, "x": tx, "y": ty})
			}
		}
	}
}
