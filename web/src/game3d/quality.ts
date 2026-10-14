// Mức chất lượng đồ hoạ: người chơi chọn trong Menu, hoặc tự hạ khi FPS thấp.
export type Quality = 'high' | 'medium' | 'low'

export interface QualitySettings {
  pixelRatio: number
  shadows: boolean
  shadowMap: number
  softShadows: boolean
  terrainSeg: number // đơn vị thế giới giữa hai đỉnh lưới địa hình
  treeLimit: number
  snow: number
}

const KEY = 'goku.quality.v2' // đổi khoá: mọi người bắt đầu lại ở mức Vừa

export function getQuality(): Quality {
  try {
    const q = localStorage.getItem(KEY)
    if (q === 'high' || q === 'medium' || q === 'low') return q
  } catch {
    /* bỏ qua */
  }
  return 'medium'
}

export function setQuality(q: Quality) {
  try {
    localStorage.setItem(KEY, q)
  } catch {
    /* bỏ qua */
  }
}

export function settings(q: Quality = getQuality()): QualitySettings {
  const dpr = window.devicePixelRatio || 1
  // Mọi mức đều bật bóng đổ PCF thường: đổi mức chỉ đổi độ phân giải và cỡ
  // shadow map, không phải biên dịch lại shader (trước đây gây đứng hình ~2 giây).
  switch (q) {
    case 'low':
      return { pixelRatio: Math.min(dpr, 1) * 0.7, shadows: true, shadowMap: 512, softShadows: false, terrainSeg: 40, treeLimit: 70, snow: 500 }
    case 'medium':
      return { pixelRatio: Math.min(dpr, 1) * 0.9, shadows: true, shadowMap: 1024, softShadows: false, terrainSeg: 28, treeLimit: 130, snow: 1000 }
    default:
      return { pixelRatio: Math.min(dpr, 1.25), shadows: true, shadowMap: 2048, softShadows: false, terrainSeg: 20, treeLimit: 200, snow: 1600 }
  }
}

/**
 * Theo dõi độ mượt. FPS trung bình dễ đánh lừa (60 Hz mà cứ 6 khung trễ 1 vẫn
 * ra ~50 FPS nhưng mắt thấy giật), nên đếm tỉ lệ khung hình bị trễ (> 24 ms).
 */
export class FpsWatch {
  private frames = 0
  private slow = 0
  private last = 0
  private start = performance.now() + 6000
  fps = 60
  /** tỉ lệ khung hình bị khựng trong cửa sổ đo gần nhất (0..1) */
  jank = 0
  /** Bỏ qua vài giây đầu (nạp/biên dịch shader gây khựng, không phải máy yếu). */
  reset(now = performance.now(), grace = 5000) {
    this.frames = 0
    this.slow = 0
    this.last = 0
    this.start = now + grace
  }
  tick(now: number): boolean {
    if (now < this.start) {
      this.last = now
      return false
    }
    if (this.last && now - this.last > 24) this.slow++
    this.last = now
    this.frames++
    const dt = now - this.start
    if (dt < 4000) return false
    this.fps = (this.frames * 1000) / dt
    this.jank = this.slow / Math.max(1, this.frames)
    this.frames = 0
    this.slow = 0
    this.start = now
    return this.fps < 40 || this.jank > 0.12
  }
}
