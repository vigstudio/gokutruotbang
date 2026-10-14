// Hiệu ứng âm thanh trong trận: rồng gầm, bị cắn, nhặt quà (file CC0, xem
// README) và tiếng trượt băng tổng hợp bằng tiếng ồn lọc dải (không cần file).
// Âm có vị trí: lệch trái/phải theo chỗ phát trên màn hình, nhỏ dần theo khoảng
// cách tới tâm camera.
import { fetchRetry } from '../fetchRetry'
import { audioOut } from './music'

export type SfxId = 'roar1' | 'roar2' | 'roar3' | 'bite' | 'pickup'

const FILES: Record<SfxId, string> = {
  roar1: '/assets/sfx/dragon-roar-1.mp3',
  roar2: '/assets/sfx/dragon-roar-2.mp3',
  roar3: '/assets/sfx/dragon-roar-3.mp3',
  bite: '/assets/sfx/bite.mp3',
  pickup: '/assets/sfx/pickup.mp3',
}

const buffers = new Map<SfxId, AudioBuffer | 'loading'>()

function load(id: SfxId, ctx: AudioContext) {
  if (buffers.has(id)) return
  buffers.set(id, 'loading')
  fetchRetry(FILES[id])
    .then((r) => r.arrayBuffer())
    .then((b) => ctx.decodeAudioData(b))
    .then((buf) => buffers.set(id, buf))
    .catch(() => buffers.delete(id))
}

/** Nạp sẵn mọi hiệu ứng (gọi khi vào trận). */
export function preloadSfx() {
  const out = audioOut()
  if (!out) return
  for (const id of Object.keys(FILES) as SfxId[]) load(id, out.ctx)
}

export interface SfxOpts {
  volume?: number // 0..1
  pan?: number // -1 trái .. 1 phải
  rate?: number // tốc độ phát (đổi cao độ)
}

export function playSfx(id: SfxId, o: SfxOpts = {}) {
  const out = audioOut()
  if (!out) return
  const buf = buffers.get(id)
  if (!buf || buf === 'loading') return load(id, out.ctx)
  const { ctx, bus } = out
  const src = ctx.createBufferSource()
  src.buffer = buf
  src.playbackRate.value = o.rate ?? 1
  const gain = ctx.createGain()
  gain.gain.value = o.volume ?? 1
  const pan = ctx.createStereoPanner()
  pan.pan.value = Math.max(-1, Math.min(1, o.pan ?? 0))
  src.connect(gain).connect(pan).connect(bus)
  src.start()
}

/** Âm lượng/pan cho nguồn âm ở toạ độ thế giới (x, y) so với tâm camera. */
export function spatial(x: number, y: number, camX: number, camY: number, range = 2200): { volume: number; pan: number } {
  const d = Math.hypot(x - camX, y - camY)
  return { volume: Math.max(0, 1 - d / range) ** 1.5, pan: Math.max(-1, Math.min(1, (x - camX) / 1200)) }
}

// ---------------------------------------------------------------- tiếng trượt băng
let slide: { gain: GainNode; filter: BiquadFilterNode; ctx: AudioContext } | null = null

function slideNode() {
  const out = audioOut()
  if (!out) return null
  if (slide) return slide
  const { ctx, bus } = out
  // tiếng ồn hồng (pink noise) 2 giây, lặp
  const len = ctx.sampleRate * 2
  const buf = ctx.createBuffer(1, len, ctx.sampleRate)
  const d = buf.getChannelData(0)
  let b0 = 0
  let b1 = 0
  let b2 = 0
  for (let i = 0; i < len; i++) {
    const w = Math.random() * 2 - 1
    b0 = 0.997 * b0 + w * 0.029591
    b1 = 0.985 * b1 + w * 0.032534
    b2 = 0.95 * b2 + w * 0.048056
    d[i] = (b0 + b1 + b2 + w * 0.05) * 0.9
  }
  const src = ctx.createBufferSource()
  src.buffer = buf
  src.loop = true
  // dải tần cao, mềm: tiếng lưỡi trượt trên mặt băng
  const filter = ctx.createBiquadFilter()
  filter.type = 'bandpass'
  filter.frequency.value = 2400
  filter.Q.value = 0.7
  const hp = ctx.createBiquadFilter()
  hp.type = 'highpass'
  hp.frequency.value = 700
  const gain = ctx.createGain()
  gain.gain.value = 0
  src.connect(hp).connect(filter).connect(gain).connect(bus)
  src.start()
  slide = { gain, filter, ctx }
  return slide
}

/**
 * Cường độ tiếng trượt (0 = im lặng, 1 = trượt nhanh). Gọi mỗi khung hình;
 * âm lượng đổi mượt và giữ ở mức nhẹ.
 */
export function setSlide(level: number, t: number) {
  const s = slideNode()
  if (!s) return
  const now = s.ctx.currentTime
  const target = Math.max(0, Math.min(1, level)) * (0.075 + Math.sin(t * 7.3) * 0.012)
  s.gain.gain.setTargetAtTime(target, now, 0.12)
  s.filter.frequency.setTargetAtTime(2100 + level * 900 + Math.sin(t * 3.1) * 250, now, 0.2)
}
