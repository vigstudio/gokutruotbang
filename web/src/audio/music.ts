// Nhạc nền: Web Audio (lặp liền mạch, chuyển bài mờ dần), tự bật sau thao tác
// đầu tiên của người chơi (trình duyệt chặn tự phát âm thanh trước đó), tạm
// dừng khi ẩn tab, nhớ âm lượng / tắt tiếng.
import { reactive } from 'vue'
import { fetchRetry } from '../fetchRetry'

export type TrackId = 'menu' | 'game'

interface Track {
  url: string
  /** độ dài bản gốc (giây): bỏ phần đệm của bộ mã hoá mp3 để lặp không bị hở */
  length: number
  gain: number
}

// Nhạc CC0 của Emma_MA trên OpenGameArt (xem README).
const TRACKS: Record<TrackId, Track> = {
  menu: { url: '/assets/music/wintery-loop.mp3', length: 44.3066, gain: 0.8 },
  game: { url: '/assets/music/determined-pursuit.mp3', length: 108, gain: 0.55 },
}
// độ trễ đầu bản của LAME (~1105 mẫu ở 44.1 kHz)
const ENCODER_DELAY = 1105 / 44100
const FADE = 1.2
const KEY = 'goku.music'

function loadSettings(): { volume: number; muted: boolean } {
  try {
    const v = JSON.parse(localStorage.getItem(KEY) ?? '')
    if (typeof v.volume === 'number' && typeof v.muted === 'boolean') return v
  } catch {
    /* chưa lưu */
  }
  return { volume: 0.6, muted: false }
}

export const music = reactive({ ...loadSettings(), track: null as TrackId | null, unlocked: false })

let ctx: AudioContext | null = null
let master: GainNode | null = null
const buffers = new Map<TrackId, Promise<AudioBuffer>>()
let current: { id: TrackId; src: AudioBufferSourceNode; gain: GainNode } | null = null
let wanted: TrackId | null = null

function save() {
  try {
    localStorage.setItem(KEY, JSON.stringify({ volume: music.volume, muted: music.muted }))
  } catch {
    /* bỏ qua */
  }
}

function applyVolume() {
  if (!ctx || !master) return
  master.gain.setTargetAtTime(music.muted ? 0 : music.volume, ctx.currentTime, 0.08)
}

function buffer(id: TrackId) {
  let p = buffers.get(id)
  if (!p) {
    p = fetchRetry(TRACKS[id].url)
      .then((r) => r.arrayBuffer())
      .then((b) => ctx!.decodeAudioData(b))
    p.catch(() => buffers.delete(id))
    buffers.set(id, p)
  }
  return p
}

async function start(id: TrackId) {
  if (!ctx || !master) return
  const buf = await buffer(id).catch(() => null)
  if (!buf || wanted !== id || current?.id === id) return
  const t = TRACKS[id]
  const now = ctx.currentTime
  // bài đang phát: mờ dần rồi dừng
  if (current) {
    const old = current
    old.gain.gain.cancelScheduledValues(now)
    old.gain.gain.setValueAtTime(old.gain.gain.value, now)
    old.gain.gain.linearRampToValueAtTime(0, now + FADE)
    old.src.stop(now + FADE + 0.05)
  }
  const src = ctx.createBufferSource()
  src.buffer = buf
  src.loop = true
  src.loopStart = ENCODER_DELAY
  src.loopEnd = Math.min(buf.duration, ENCODER_DELAY + t.length)
  const gain = ctx.createGain()
  gain.gain.setValueAtTime(0, now)
  gain.gain.linearRampToValueAtTime(t.gain, now + FADE)
  src.connect(gain).connect(master)
  src.start(now, ENCODER_DELAY)
  current = { id, src, gain }
}

/** Khởi tạo âm thanh ở lần thao tác đầu tiên (chạm, click, phím). */
function unlock() {
  if (music.unlocked) return
  const AC = window.AudioContext ?? (window as unknown as { webkitAudioContext: typeof AudioContext }).webkitAudioContext
  if (!AC) return
  ctx = new AC()
  master = ctx.createGain()
  master.connect(ctx.destination)
  music.unlocked = true
  applyVolume()
  ctx.resume().catch(() => {})
  if (wanted) start(wanted)
  for (const ev of ['pointerdown', 'keydown', 'touchend'] as const) window.removeEventListener(ev, unlock)
}
for (const ev of ['pointerdown', 'keydown', 'touchend'] as const) window.addEventListener(ev, unlock, { passive: true })

document.addEventListener('visibilitychange', () => {
  if (!ctx) return
  if (document.hidden) ctx.suspend().catch(() => {})
  else ctx.resume().catch(() => {})
})

/** Chọn bài nhạc nền (gọi khi đổi màn hình). */
export function playMusic(id: TrackId) {
  wanted = id
  music.track = id
  if (ctx) start(id)
}

export function setVolume(v: number) {
  music.volume = Math.max(0, Math.min(1, v))
  if (music.volume > 0) music.muted = false
  applyVolume()
  save()
}

export function toggleMute() {
  music.muted = !music.muted
  applyVolume()
  save()
}
