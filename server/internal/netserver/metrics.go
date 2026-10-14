package netserver

import (
	"runtime"
	"sync"
	"time"
)

// Số liệu vận hành nhẹ cho /metrics: thời gian xử lý mỗi tick của phòng và
// lưu lượng gửi đi (JSON trước khi nén), tính trong cửa sổ 10 giây.
type metricsT struct {
	mu        sync.Mutex
	start     time.Time
	ticks     int64
	tickSum   time.Duration
	tickMax   time.Duration
	bytes     int64
	msgs      int64
	last      map[string]any
	lastAt    time.Time
	startedAt time.Time
}

var metrics = &metricsT{start: time.Now(), startedAt: time.Now()}

func (m *metricsT) tick(d time.Duration) {
	m.mu.Lock()
	m.ticks++
	m.tickSum += d
	if d > m.tickMax {
		m.tickMax = d
	}
	m.mu.Unlock()
}

func (m *metricsT) sent(n int) {
	m.mu.Lock()
	m.bytes += int64(n)
	m.msgs++
	m.mu.Unlock()
}

func (m *metricsT) report(rooms, clients, games int) map[string]any {
	m.mu.Lock()
	defer m.mu.Unlock()
	now := time.Now()
	if el := now.Sub(m.start); el >= 10*time.Second || m.last == nil {
		sec := el.Seconds()
		avg := 0.0
		if m.ticks > 0 {
			avg = float64(m.tickSum.Microseconds()) / float64(m.ticks)
		}
		m.last = map[string]any{
			"window_s":          round1(sec),
			"tick_avg_us":       round1(avg),
			"tick_max_us":       m.tickMax.Microseconds(),
			"out_kb_per_s":      round1(float64(m.bytes) / 1024 / sec),
			"out_msgs_per_s":    round1(float64(m.msgs) / sec),
			"out_kb_per_client": 0.0,
		}
		if clients > 0 {
			m.last["out_kb_per_client"] = round1(float64(m.bytes) / 1024 / sec / float64(clients))
		}
		m.start, m.ticks, m.tickSum, m.tickMax, m.bytes, m.msgs = now, 0, 0, 0, 0, 0
		m.lastAt = now
	}
	var ms runtime.MemStats
	runtime.ReadMemStats(&ms)
	out := map[string]any{
		"rooms": rooms, "clients": clients, "games": games,
		"goroutines": runtime.NumGoroutine(), "heap_mb": round1(float64(ms.HeapAlloc) / 1e6),
		"uptime_s": int(now.Sub(m.startedAt).Seconds()),
	}
	for k, v := range m.last {
		out[k] = v
	}
	return out
}

func round1(v float64) float64 { return float64(int64(v*10+0.5)) / 10 }
