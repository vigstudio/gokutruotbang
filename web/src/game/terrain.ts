// Vẽ địa hình bằng texture procedural (không dùng ảnh ngoài):
//  - mỗi loại tile có texture riêng sinh từ noise fBm, lặp liền mạch,
//  - trộn tile theo các góc (như engine WC3) với biên nhiễu tự nhiên,
//  - tường/vách lấy từ pathing, bo tròn, có mặt đá, tuyết phủ và bóng đổ,
//  - doodad gốc của map + rừng thông trên các vách rộng.
import type { MapData } from '../types'

export function b64(s: string): Uint8Array {
  const bin = atob(s)
  const out = new Uint8Array(bin.length)
  for (let i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i)
  return out
}

export class MapInfo {
  ground: Uint8Array
  walk: Uint8Array
  constructor(public m: MapData) {
    this.ground = b64(m.terrain.ground)
    this.walk = b64(m.pathing.walkable)
  }
  cornerIndex(x: number, y: number) {
    const t = this.m.terrain
    const cx = Math.floor((x - t.originX) / t.cellSize + 0.5)
    const cy = Math.floor((y - t.originY) / t.cellSize + 0.5)
    if (cx < 0 || cy < 0 || cx >= t.cols || cy >= t.rows) return -1
    return cy * t.cols + cx
  }
  cornerPos(i: number): [number, number] {
    const t = this.m.terrain
    return [t.originX + (i % t.cols) * t.cellSize, t.originY + Math.floor(i / t.cols) * t.cellSize]
  }
  tileAt(x: number, y: number) {
    const i = this.cornerIndex(x, y)
    return i < 0 ? '' : this.m.terrain.tiles[this.ground[i]] ?? ''
  }
  walkable(x: number, y: number) {
    const p = this.m.pathing
    const cx = Math.floor((x - p.originX) / p.cellSize)
    const cy = Math.floor((y - p.originY) / p.cellSize)
    if (cx < 0 || cy < 0 || cx >= p.cols || cy >= p.rows) return false
    return this.walk[cy * p.cols + cx] === 1
  }
}

// ------------------------------------------------------------ noise
function rng(seed: number) {
  return () => {
    seed = (seed * 1664525 + 1013904223) >>> 0
    return seed / 4294967296
  }
}

/** Value noise lặp lại với chu kỳ `period` ô lưới. */
function makeNoise(seed: number, period: number) {
  const r = rng(seed)
  const g = new Float32Array(period * period)
  for (let i = 0; i < g.length; i++) g[i] = r()
  return (x: number, y: number) => {
    const xi = Math.floor(x)
    const yi = Math.floor(y)
    const xf = x - xi
    const yf = y - yi
    const u = xf * xf * (3 - 2 * xf)
    const v = yf * yf * (3 - 2 * yf)
    const x0 = ((xi % period) + period) % period
    const y0 = ((yi % period) + period) % period
    const x1 = (x0 + 1) % period
    const y1 = (y0 + 1) % period
    const a = g[y0 * period + x0]
    const b = g[y0 * period + x1]
    const c = g[y1 * period + x0]
    const d = g[y1 * period + x1]
    return a + (b - a) * u + (c - a) * v + (a - b - c + d) * u * v
  }
}

/** fBm lặp liền mạch trên ảnh size×size, trả mảng 0..1. */
function fbm(size: number, seed: number, baseCells: number, octaves = 5, gain = 0.5): Float32Array {
  const out = new Float32Array(size * size)
  const layers: ((x: number, y: number) => number)[] = []
  for (let o = 0; o < octaves; o++) layers.push(makeNoise(seed + o * 101, baseCells << o))
  let norm = 0
  for (let o = 0, a = 1; o < octaves; o++, a *= gain) norm += a
  for (let y = 0; y < size; y++) {
    for (let x = 0; x < size; x++) {
      let v = 0
      let amp = 1
      for (let o = 0; o < octaves; o++) {
        const f = (baseCells << o) / size
        v += layers[o](x * f, y * f) * amp
        amp *= gain
      }
      out[y * size + x] = v / norm
    }
  }
  return out
}

const smooth = (a: number, b: number, x: number) => {
  const t = Math.max(0, Math.min(1, (x - a) / (b - a)))
  return t * t * (3 - 2 * t)
}
type RGB = [number, number, number]
const hex = (h: string): RGB => {
  const n = parseInt(h.slice(1), 16)
  return [(n >> 16) & 255, (n >> 8) & 255, n & 255]
}
const mixc = (a: RGB, b: RGB, t: number): RGB => [a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t]

// ------------------------------------------------------------ texture
const TEX = 512 // texel; 1 texel = 2 đơn vị thế giới -> lặp mỗi 1024 đơn vị

interface Texture {
  data: Uint8ClampedArray // RGBA TEX×TEX
  canvas: HTMLCanvasElement
}

function newTex(): { cv: HTMLCanvasElement; ctx: CanvasRenderingContext2D; img: ImageData } {
  const cv = document.createElement('canvas')
  cv.width = cv.height = TEX
  const ctx = cv.getContext('2d', { willReadFrequently: true })!
  return { cv, ctx, img: ctx.createImageData(TEX, TEX) }
}

function fillFromFn(img: ImageData, fn: (x: number, y: number, i: number) => RGB) {
  const d = img.data
  for (let y = 0; y < TEX; y++) {
    for (let x = 0; x < TEX; x++) {
      const i = y * TEX + x
      const c = fn(x, y, i)
      d[i * 4] = c[0]
      d[i * 4 + 1] = c[1]
      d[i * 4 + 2] = c[2]
      d[i * 4 + 3] = 255
    }
  }
}

/** Vẽ nét lặp liền mạch (vẽ lại ở 8 ô lân cận). */
function wrapped(ctx: CanvasRenderingContext2D, draw: () => void) {
  for (const dx of [-TEX, 0, TEX]) {
    for (const dy of [-TEX, 0, TEX]) {
      ctx.save()
      ctx.translate(dx, dy)
      draw()
      ctx.restore()
    }
  }
}

function finish(t: ReturnType<typeof newTex>): Texture {
  return { canvas: t.cv, data: t.ctx.getImageData(0, 0, TEX, TEX).data }
}

function iceTexture(): Texture {
  const t = newTex()
  const n1 = fbm(TEX, 11, 4, 5, 0.55)
  const n2 = fbm(TEX, 23, 16, 3, 0.5)
  const deep = hex('#6fb6dc')
  const mid = hex('#a9dcf2')
  const hi = hex('#e4f7ff')
  fillFromFn(t.img, (_x, _y, i) => {
    const v = n1[i]
    let c = v < 0.5 ? mixc(deep, mid, smooth(0.2, 0.5, v)) : mixc(mid, hi, smooth(0.5, 0.8, v))
    c = mixc(c, hi, Math.pow(n2[i], 4) * 0.5) // bọt khí li ti
    return c
  })
  t.ctx.putImageData(t.img, 0, 0)
  const r = rng(77)
  const ctx = t.ctx
  // vết trượt (đường cong mảnh, sáng)
  for (let k = 0; k < 26; k++) {
    const x = r() * TEX
    const y = r() * TEX
    const a = r() * Math.PI
    const len = 60 + r() * 220
    const bend = (r() - 0.5) * 80
    wrapped(ctx, () => {
      ctx.strokeStyle = `rgba(255,255,255,${0.12 + r() * 0.2})`
      ctx.lineWidth = 0.6 + r() * 0.8
      ctx.beginPath()
      ctx.moveTo(x, y)
      ctx.quadraticCurveTo(x + Math.cos(a) * len * 0.5 - Math.sin(a) * bend, y + Math.sin(a) * len * 0.5 + Math.cos(a) * bend, x + Math.cos(a) * len, y + Math.sin(a) * len)
      ctx.stroke()
    })
  }
  // vết nứt: đường gấp khúc tối + viền sáng
  for (let k = 0; k < 9; k++) {
    const pts: [number, number][] = []
    let x = r() * TEX
    let y = r() * TEX
    let a = r() * Math.PI * 2
    for (let s = 0; s < 10; s++) {
      pts.push([x, y])
      a += (r() - 0.5) * 1.2
      const l = 6 + r() * 16
      x += Math.cos(a) * l
      y += Math.sin(a) * l
    }
    wrapped(ctx, () => {
      for (const [col, off, w] of [
        ['rgba(255,255,255,0.55)', 0.8, 1],
        ['rgba(40,95,140,0.55)', 0, 1],
      ] as const) {
        ctx.strokeStyle = col
        ctx.lineWidth = w
        ctx.beginPath()
        pts.forEach(([px, py], i) => (i ? ctx.lineTo(px + off, py + off) : ctx.moveTo(px + off, py + off)))
        ctx.stroke()
      }
    })
  }
  // lấp lánh
  for (let k = 0; k < 180; k++) {
    ctx.fillStyle = `rgba(255,255,255,${0.4 + r() * 0.6})`
    ctx.fillRect(r() * TEX, r() * TEX, 1, 1)
  }
  return finish(t)
}

function snowTexture(): Texture {
  const t = newTex()
  const n1 = fbm(TEX, 31, 6, 5, 0.5)
  const n2 = fbm(TEX, 37, 32, 2, 0.5)
  const sh = hex('#c9d8e8')
  const wh = hex('#f7fbff')
  fillFromFn(t.img, (_x, _y, i) => {
    const c = mixc(sh, wh, smooth(0.25, 0.75, n1[i]))
    const g = (n2[i] - 0.5) * 18
    return [c[0] + g, c[1] + g, c[2] + g * 0.6]
  })
  t.ctx.putImageData(t.img, 0, 0)
  const r = rng(5)
  for (let k = 0; k < 260; k++) {
    t.ctx.fillStyle = `rgba(255,255,255,${0.5 + r() * 0.5})`
    t.ctx.fillRect(r() * TEX, r() * TEX, 1, 1)
  }
  return finish(t)
}

/** Đá hoa lát gạch (Xblm): ô 128 đơn vị = 64 texel, vân đá, rãnh vữa, cạnh vát. */
function marbleTexture(): Texture {
  const t = newTex()
  const n1 = fbm(TEX, 41, 8, 5, 0.55)
  const n2 = fbm(TEX, 43, 4, 4, 0.5)
  const r = rng(9)
  const tone: number[] = []
  for (let i = 0; i < 64; i++) tone.push((r() - 0.5) * 22)
  const base = hex('#d9d2c6')
  const vein = hex('#8f877c')
  fillFromFn(t.img, (x, y, i) => {
    const gx = x % 64
    const gy = y % 64
    const cell = Math.floor(x / 64) + Math.floor(y / 64) * 8
    // vân đá: sin bị nhiễu loạn
    const v = Math.abs(Math.sin((x * 0.04 + y * 0.025 + n1[i] * 9) * 1.3))
    let c = mixc(base, vein, Math.pow(1 - v, 14) * 0.7)
    c = mixc(c, hex('#efe9de'), smooth(0.55, 0.9, n2[i]) * 0.5)
    const tn = tone[cell % 64]
    c = [c[0] + tn, c[1] + tn, c[2] + tn * 0.8]
    // rãnh vữa + cạnh vát
    const edge = Math.min(gx, gy, 63 - gx, 63 - gy)
    if (edge < 1) return [70, 64, 58]
    if (gx < 3 || gy < 3) c = mixc(c, [255, 255, 255], 0.22)
    if (gx > 60 || gy > 60) c = mixc(c, [40, 34, 30], 0.3)
    return c
  })
  t.ctx.putImageData(t.img, 0, 0)
  return finish(t)
}

function dirtTexture(): Texture {
  const t = newTex()
  const n1 = fbm(TEX, 51, 8, 5, 0.55)
  const n2 = fbm(TEX, 53, 48, 2, 0.6)
  const a = hex('#5a4330')
  const b = hex('#8a6a4a')
  fillFromFn(t.img, (_x, _y, i) => {
    const c = mixc(a, b, smooth(0.25, 0.75, n1[i]))
    const g = (n2[i] - 0.5) * 40
    return [c[0] + g, c[1] + g * 0.9, c[2] + g * 0.8]
  })
  t.ctx.putImageData(t.img, 0, 0)
  const r = rng(13)
  for (let k = 0; k < 220; k++) {
    const x = r() * TEX
    const y = r() * TEX
    const s = 1 + r() * 3.5
    t.ctx.fillStyle = `rgba(${150 + r() * 60},${130 + r() * 50},${110 + r() * 40},0.9)`
    t.ctx.beginPath()
    t.ctx.ellipse(x, y, s, s * 0.75, r() * 3, 0, Math.PI * 2)
    t.ctx.fill()
    t.ctx.fillStyle = 'rgba(0,0,0,0.25)'
    t.ctx.beginPath()
    t.ctx.ellipse(x + 1, y + 1, s, s * 0.6, 0, 0, Math.PI)
    t.ctx.fill()
  }
  return finish(t)
}

function grassTexture(): Texture {
  const t = newTex()
  const n1 = fbm(TEX, 61, 8, 5, 0.55)
  const snow = fbm(TEX, 63, 4, 4, 0.5)
  const a = hex('#3e6a2c')
  const b = hex('#7aa24a')
  fillFromFn(t.img, (_x, _y, i) => {
    let c = mixc(a, b, smooth(0.2, 0.8, n1[i]))
    c = mixc(c, hex('#eef4fa'), smooth(0.55, 0.75, snow[i]) * 0.85) // tuyết rải rác
    return c
  })
  t.ctx.putImageData(t.img, 0, 0)
  const r = rng(17)
  for (let k = 0; k < 1500; k++) {
    const x = r() * TEX
    const y = r() * TEX
    t.ctx.strokeStyle = `rgba(${40 + r() * 60},${90 + r() * 80},${30 + r() * 30},0.7)`
    t.ctx.beginPath()
    t.ctx.moveTo(x, y)
    t.ctx.lineTo(x + (r() - 0.5) * 3, y - 2 - r() * 4)
    t.ctx.stroke()
  }
  return finish(t)
}

/** Vách đá băng: đá xám xanh, có vân tầng. */
function cliffTexture(): Texture {
  const t = newTex()
  const n1 = fbm(TEX, 71, 8, 5, 0.6)
  const n2 = fbm(TEX, 73, 2, 3, 0.5)
  const a = hex('#2c3646')
  const b = hex('#6a7a90')
  fillFromFn(t.img, (_x, y, i) => {
    const strata = Math.sin(y * 0.12 + n2[i] * 10) * 0.5 + 0.5
    let c = mixc(a, b, smooth(0.2, 0.85, n1[i] * 0.75 + strata * 0.25))
    c = mixc(c, hex('#9fd8f0'), smooth(0.7, 0.95, n2[i]) * 0.25) // băng bám
    return c
  })
  t.ctx.putImageData(t.img, 0, 0)
  return finish(t)
}

export interface Textures {
  [tile: string]: Texture
}

let texCache: Textures | null = null
export function terrainTextures(): Textures {
  if (texCache) return texCache
  const ice = iceTexture()
  const snow = snowTexture()
  const marble = marbleTexture()
  const dirt = dirtTexture()
  const grass = grassTexture()
  texCache = { Nice: ice, Iice: ice, Nsnw: snow, Nsnr: snow, Xblm: marble, Ndrt: dirt, Nrck: dirt, Ngrs: grass, cliff: cliffTexture() }
  return texCache
}

// ------------------------------------------------------------ dựng ảnh địa hình
export interface TerrainImage {
  canvas: HTMLCanvasElement
  scale: number // pixel / đơn vị thế giới
  minX: number
  maxY: number
  dirt: HTMLCanvasElement
}

export const TERRAIN_MARGIN = 384

/** Vẽ sẵn toàn bộ khu vực chơi (+ viền) vào một canvas. */
export function renderTerrain(info: MapInfo, scale = 0.5, for3d = false): TerrainImage {
  const m = info.m
  const b = m.bounds
  const minX = b.minX - TERRAIN_MARGIN
  const maxX = b.maxX + TERRAIN_MARGIN
  const minY = b.minY - TERRAIN_MARGIN
  const maxY = b.maxY + TERRAIN_MARGIN
  const W = Math.ceil((maxX - minX) * scale)
  const H = Math.ceil((maxY - minY) * scale)
  const tex = terrainTextures()
  const t = m.terrain
  const p = m.pathing

  // tile của từng góc -> texture
  const tileTex: Texture[] = t.tiles.map((name) => tex[name] ?? tex.Nsnw)
  const cornerTex = (cx: number, cy: number) => {
    cx = Math.max(0, Math.min(t.cols - 1, cx))
    cy = Math.max(0, Math.min(t.rows - 1, cy))
    return info.ground[cy * t.cols + cx]
  }
  // mặt nạ tường: 1 = không đi được; ngoài bản đồ coi như tường
  const blocked = (cx: number, cy: number) => {
    if (cx < 0 || cy < 0 || cx >= p.cols || cy >= p.rows) return 1
    const x = p.originX + (cx + 0.5) * p.cellSize
    const y = p.originY + (cy + 0.5) * p.cellSize
    if (x < b.minX || x > b.maxX || y < b.minY || y > b.maxY) return 1
    return info.walk[cy * p.cols + cx] ? 0 : 1
  }
  const PC = p.cols + 2
  const mask = new Float32Array(PC * (p.rows + 2))
  for (let cy = -1; cy <= p.rows; cy++) for (let cx = -1; cx <= p.cols; cx++) mask[(cy + 1) * PC + cx + 1] = blocked(cx, cy)
  const wallM = (wx: number, wy: number) => {
    const fx = (wx - p.originX) / p.cellSize - 0.5
    const fy = (wy - p.originY) / p.cellSize - 0.5
    let ix = Math.floor(fx)
    let iy = Math.floor(fy)
    const tx = fx - ix
    const ty = fy - iy
    if (ix < -1 || iy < -1 || ix >= p.cols || iy >= p.rows) return 1
    ix += 1
    iy += 1
    const a = mask[iy * PC + ix]
    const bb = mask[iy * PC + ix + 1]
    const c = mask[(iy + 1) * PC + ix]
    const d = mask[(iy + 1) * PC + ix + 1]
    return a + (bb - a) * tx + (c - a) * ty + (a - bb - c + d) * tx * ty
  }

  const edgeNoise = makeNoise(991, 4096)
  const sheenNoise = makeNoise(992, 4096)
  const cliff = tex.cliff.data
  const snowD = tex.Nsnw.data
  const out = new ImageData(W, H)
  const o = out.data
  const weights = new Float32Array(t.tiles.length)

  for (let py = 0; py < H; py++) {
    const wy = maxY - (py + 0.5) / scale
    const fy = (wy - t.originY) / t.cellSize
    const iy = Math.floor(fy)
    const ty = fy - iy
    const vy = ((Math.floor(wy * 0.5) % TEX) + TEX) % TEX
    for (let px = 0; px < W; px++) {
      const wx = minX + (px + 0.5) / scale
      const fx = (wx - t.originX) / t.cellSize
      const ix = Math.floor(fx)
      const tx = fx - ix
      const vx = ((Math.floor(wx * 0.5) % TEX) + TEX) % TEX
      const ti = (vy * TEX + vx) * 4

      // ---- nền: trộn tile theo 4 góc
      const c00 = cornerTex(ix, iy)
      const c10 = cornerTex(ix + 1, iy)
      const c01 = cornerTex(ix, iy + 1)
      const c11 = cornerTex(ix + 1, iy + 1)
      let r = 0
      let g = 0
      let bl = 0
      if (c00 === c10 && c00 === c01 && c00 === c11) {
        const d = tileTex[c00].data
        r = d[ti]
        g = d[ti + 1]
        bl = d[ti + 2]
      } else {
        weights.fill(0)
        weights[c00] += (1 - tx) * (1 - ty)
        weights[c10] += tx * (1 - ty)
        weights[c01] += (1 - tx) * ty
        weights[c11] += tx * ty
        const n = (edgeNoise(wx / 70, wy / 70) - 0.5) * 0.36
        let sum = 0
        for (let k = 0; k < weights.length; k++) {
          if (weights[k] === 0) continue
          const s = smooth(0.4, 0.6, weights[k] + (k % 2 ? n : -n))
          weights[k] = s
          sum += s
        }
        if (sum === 0) sum = 1
        for (let k = 0; k < weights.length; k++) {
          const w = weights[k] / sum
          if (w <= 0) continue
          const d = tileTex[k].data
          r += d[ti] * w
          g += d[ti + 1] * w
          bl += d[ti + 2] * w
        }
      }
      // ánh bóng loáng trên băng (dải chéo mờ)
      if (c00 === c11 && t.tiles[c00] === 'Nice') {
        const s = Math.pow(sheenNoise((wx + wy) / 900, (wx - wy) / 3000), 3) * 40
        r += s
        g += s
        bl += s
      }

      // ---- tường / vách
      const mWall = wallM(wx, wy)
      const nn = (edgeNoise(wx / 45 + 50, wy / 45) - 0.5) * 0.22
      const e = smooth(0.44, 0.56, mWall + nn)
      if (e < 1 && !for3d) {
        // bóng đổ (ánh sáng từ tây-bắc) + AO sát chân vách
        const sh = wallM(wx - 26, wy + 34)
        const ao = (wallM(wx + 40, wy) + wallM(wx - 40, wy) + wallM(wx, wy + 40) + wallM(wx, wy - 40)) * 0.25
        const dark = 1 - Math.min(0.5, sh * 0.38 + ao * 0.22)
        r *= dark
        g *= dark
        bl *= dark * 1.02
      }
      if (e > 0) {
        // mặt đá lộ ra ở cạnh phía nam (camera nhìn từ nam), đỉnh phủ tuyết
        const south = wallM(wx, wy - 26)
        const face = smooth(0.15, 0.85, mWall - south + 0.25) * (1 - smooth(0.8, 1, wallM(wx, wy - 60)))
        const depth = smooth(0.5, 0.95, mWall)
        let wr = snowD[ti] * 0.93
        let wg = snowD[ti + 1] * 0.96
        let wb = snowD[ti + 2]
        // tuyết đỉnh hơi xanh ở giữa, sáng ở mép trên
        const rim = 1 - depth
        wr = wr * (0.86 + rim * 0.14)
        wg = wg * (0.9 + rim * 0.1)
        if (face > 0 && !for3d) {
          const lit = 0.75 + 0.35 * (wallM(wx + 30, wy) - wallM(wx - 30, wy) + 1) * 0.5
          wr = wr + (cliff[ti] * lit - wr) * face
          wg = wg + (cliff[ti + 1] * lit - wg) * face
          wb = wb + (cliff[ti + 2] * lit - wb) * face
        }
        r = r + (wr - r) * e
        g = g + (wg - g) * e
        bl = bl + (wb - bl) * e
        // viền tối ở chân vách
        const lip = for3d ? 0 : e * (1 - e) * 4
        r *= 1 - lip * 0.35
        g *= 1 - lip * 0.3
        bl *= 1 - lip * 0.2
      }
      const oi = (py * W + px) * 4
      o[oi] = r
      o[oi + 1] = g
      o[oi + 2] = bl
      o[oi + 3] = 255
    }
  }

  const cv = document.createElement('canvas')
  cv.width = W
  cv.height = H
  const ctx = cv.getContext('2d')!
  ctx.putImageData(out, 0, 0)
  const toX = (x: number) => (x - minX) * scale
  const toY = (y: number) => (maxY - y) * scale

  drawRegions(ctx, m, toX, toY, scale)
  if (!for3d) {
    drawForest(ctx, wallM, minX, maxX, minY, maxY, toX, toY, scale)
    drawDoodads(ctx, m, toX, toY, scale)
  }

  return { canvas: cv, scale, minX, maxY, dirt: tex.Nrck.canvas }
}

// ------------------------------------------------------------ vùng đặc biệt
function drawRegions(ctx: CanvasRenderingContext2D, m: MapData, toX: (x: number) => number, toY: (y: number) => number, scale: number) {
  const fin = m.regions['Next_Round']
  if (fin) {
    const cx = (fin.minX + fin.maxX) / 2
    const cy = (fin.minY + fin.maxY) / 2
    const g = ctx.createRadialGradient(toX(cx), toY(cy), 0, toX(cx), toY(cy), 260 * scale)
    g.addColorStop(0, 'rgba(255,220,90,0.55)')
    g.addColorStop(1, 'rgba(255,200,60,0)')
    ctx.fillStyle = g
    ctx.fillRect(toX(cx - 260), toY(cy + 260), 520 * scale, 520 * scale)
    // vòng rune vàng
    ctx.strokeStyle = 'rgba(255,215,90,0.85)'
    ctx.lineWidth = 2
    ctx.beginPath()
    ctx.ellipse(toX(cx), toY(cy), 120 * scale, 200 * scale, 0, 0, Math.PI * 2)
    ctx.stroke()
    ctx.setLineDash([4, 6])
    ctx.beginPath()
    ctx.ellipse(toX(cx), toY(cy), 95 * scale, 170 * scale, 0, 0, Math.PI * 2)
    ctx.stroke()
    ctx.setLineDash([])
  }
  const st = m.regions['Kitty_Start']
  if (st) {
    const cx = (st.minX + st.maxX) / 2
    const cy = (st.minY + st.maxY) / 2
    const g = ctx.createRadialGradient(toX(cx), toY(cy), 0, toX(cx), toY(cy), 260 * scale)
    g.addColorStop(0, 'rgba(120,200,255,0.25)')
    g.addColorStop(1, 'rgba(120,200,255,0)')
    ctx.fillStyle = g
    ctx.fillRect(toX(cx - 260), toY(cy + 260), 520 * scale, 520 * scale)
  }
}

// ------------------------------------------------------------ cây thông
function pine(ctx: CanvasRenderingContext2D, x: number, y: number, s: number, seed: number) {
  const r = rng(seed)
  // bóng đổ về đông-nam
  ctx.fillStyle = 'rgba(10,20,40,0.28)'
  ctx.beginPath()
  ctx.ellipse(x + s * 0.5, y + s * 0.15, s * 0.75, s * 0.3, 0.35, 0, Math.PI * 2)
  ctx.fill()
  // thân
  ctx.fillStyle = '#4a3020'
  ctx.fillRect(x - s * 0.06, y - s * 0.2, s * 0.12, s * 0.25)
  const tiers = 4
  for (let i = 0; i < tiers; i++) {
    const w = s * (0.62 - i * 0.12)
    const top = y - s * (0.35 + i * 0.32)
    const bot = y - s * (i * 0.3) - s * 0.08
    const g = ctx.createLinearGradient(x - w, 0, x + w, 0)
    g.addColorStop(0, '#0f2a22')
    g.addColorStop(0.45, '#24503e')
    g.addColorStop(1, '#0a1c17')
    ctx.fillStyle = g
    ctx.beginPath()
    ctx.moveTo(x, top - s * 0.15)
    ctx.lineTo(x + w, bot)
    ctx.quadraticCurveTo(x, bot + s * 0.06, x - w, bot)
    ctx.closePath()
    ctx.fill()
    // tuyết phủ trên tầng lá
    ctx.fillStyle = `rgba(240,248,255,${0.85 + r() * 0.15})`
    ctx.beginPath()
    ctx.moveTo(x, top - s * 0.15)
    ctx.lineTo(x + w * 0.55, top + (bot - top) * 0.55)
    ctx.quadraticCurveTo(x + w * 0.1, top + (bot - top) * 0.4, x - w * 0.7, top + (bot - top) * 0.62)
    ctx.closePath()
    ctx.fill()
  }
}

function drawForest(
  ctx: CanvasRenderingContext2D,
  wallM: (x: number, y: number) => number,
  minX: number,
  maxX: number,
  minY: number,
  maxY: number,
  toX: (x: number) => number,
  toY: (y: number) => number,
  scale: number,
) {
  const r = rng(4242)
  const trees: [number, number, number][] = []
  for (let k = 0; k < 2600; k++) {
    const x = minX + r() * (maxX - minX)
    const y = minY + r() * (maxY - minY)
    const s = 70 + r() * 70
    // chỉ trồng trên vách rộng: cả vùng quanh gốc cây đều là tường
    if (wallM(x, y) < 1 || wallM(x - s * 0.7, y) < 1 || wallM(x + s * 0.7, y) < 1 || wallM(x, y + s * 1.3) < 1 || wallM(x, y - s * 0.5) < 1) continue
    if (trees.some(([tx, ty]) => Math.abs(tx - x) < s * 0.7 && Math.abs(ty - y) < s * 0.6)) continue
    trees.push([x, y, s])
  }
  trees.sort((a, b) => b[1] - a[1])
  trees.forEach(([x, y, s], i) => pine(ctx, toX(x), toY(y), s * scale, i + 1))
}

// ------------------------------------------------------------ doodad gốc
function glowAt(ctx: CanvasRenderingContext2D, x: number, y: number, rad: number, color: string) {
  const g = ctx.createRadialGradient(x, y, 0, x, y, rad)
  g.addColorStop(0, color)
  g.addColorStop(1, 'rgba(0,0,0,0)')
  ctx.fillStyle = g
  ctx.fillRect(x - rad, y - rad, rad * 2, rad * 2)
}

function crystal(ctx: CanvasRenderingContext2D, x: number, y: number, h: number, w: number, tint = '#bfeaff') {
  ctx.fillStyle = 'rgba(10,30,60,0.3)'
  ctx.beginPath()
  ctx.ellipse(x + w * 0.6, y + w * 0.15, w * 1.1, w * 0.4, 0.3, 0, Math.PI * 2)
  ctx.fill()
  const g = ctx.createLinearGradient(x - w, 0, x + w, 0)
  g.addColorStop(0, '#ffffff')
  g.addColorStop(0.4, tint)
  g.addColorStop(1, '#3a7ab0')
  ctx.fillStyle = g
  ctx.strokeStyle = 'rgba(20,60,100,0.8)'
  ctx.lineWidth = 1
  ctx.beginPath()
  ctx.moveTo(x - w, y)
  ctx.lineTo(x - w * 0.8, y - h * 0.75)
  ctx.lineTo(x, y - h)
  ctx.lineTo(x + w * 0.8, y - h * 0.75)
  ctx.lineTo(x + w, y)
  ctx.quadraticCurveTo(x, y + w * 0.3, x - w, y)
  ctx.fill()
  ctx.stroke()
  ctx.strokeStyle = 'rgba(255,255,255,0.8)'
  ctx.beginPath()
  ctx.moveTo(x - w * 0.3, y - h * 0.1)
  ctx.lineTo(x - w * 0.2, y - h * 0.8)
  ctx.stroke()
}

function drawDoodads(ctx: CanvasRenderingContext2D, m: MapData, toX: (x: number) => number, toY: (y: number) => number, scale: number) {
  const list = [...(m.doodads ?? [])].sort((a, b) => b.y - a.y)
  for (const d of list) {
    const x = toX(d.x)
    const y = toY(d.y)
    const s = (d.scale || 1) * scale
    switch (d.type) {
      case 'IWbg': // hàng tinh thể ở cổng đích
        glowAt(ctx, x, y, 22 * s, 'rgba(255,220,120,0.6)')
        crystal(ctx, x, y, 34 * s, 7 * s, '#ffe9a8')
        break
      case 'IOst': // cột băng ở các góc
        glowAt(ctx, x, y - 50 * s, 60 * s, 'rgba(140,210,255,0.35)')
        crystal(ctx, x, y, 110 * s, 18 * s)
        break
      case 'IOob': // trụ đá rune
        ctx.fillStyle = 'rgba(10,20,40,0.3)'
        ctx.beginPath()
        ctx.ellipse(x + 14 * s, y + 4 * s, 30 * s, 10 * s, 0.3, 0, Math.PI * 2)
        ctx.fill()
        ctx.fillStyle = '#3d4658'
        ctx.fillRect(x - 13 * s, y - 90 * s, 26 * s, 90 * s)
        ctx.fillStyle = '#596479'
        ctx.fillRect(x - 13 * s, y - 90 * s, 9 * s, 90 * s)
        ctx.fillStyle = '#eef6ff'
        ctx.fillRect(x - 15 * s, y - 96 * s, 30 * s, 8 * s)
        glowAt(ctx, x, y - 50 * s, 26 * s, 'rgba(90,200,255,0.8)')
        ctx.fillStyle = '#bff0ff'
        ctx.font = `${Math.max(8, 20 * s)}px serif`
        ctx.textAlign = 'center'
        ctx.fillText('ᚱ', x, y - 42 * s)
        break
      case 'YOr2': // vòng rune trên mặt đất
        ctx.strokeStyle = 'rgba(140,220,255,0.7)'
        ctx.lineWidth = 2
        ctx.beginPath()
        ctx.ellipse(x, y, 50 * s, 30 * s, 0, 0, Math.PI * 2)
        ctx.stroke()
        glowAt(ctx, x, y, 50 * s, 'rgba(120,200,255,0.25)')
        break
      case 'NRic': // tảng băng
        crystal(ctx, x - 14 * s, y, 50 * s, 16 * s)
        crystal(ctx, x + 12 * s, y + 6 * s, 36 * s, 13 * s)
        break
      case 'YOfb': // lò lửa
        ctx.fillStyle = '#2a2420'
        ctx.beginPath()
        ctx.ellipse(x, y, 22 * s, 9 * s, 0, 0, Math.PI * 2)
        ctx.fill()
        glowAt(ctx, x, y - 20 * s, 70 * s, 'rgba(255,140,40,0.55)')
        ctx.fillStyle = '#ffb030'
        ctx.beginPath()
        ctx.moveTo(x - 14 * s, y - 4 * s)
        ctx.quadraticCurveTo(x - 10 * s, y - 40 * s, x, y - 52 * s)
        ctx.quadraticCurveTo(x + 10 * s, y - 40 * s, x + 14 * s, y - 4 * s)
        ctx.fill()
        ctx.fillStyle = '#fff1a0'
        ctx.beginPath()
        ctx.ellipse(x, y - 14 * s, 6 * s, 14 * s, 0, 0, Math.PI * 2)
        ctx.fill()
        break
      default: // tượng / vật trang trí khác
        ctx.fillStyle = 'rgba(10,20,40,0.3)'
        ctx.beginPath()
        ctx.ellipse(x + 12 * s, y + 4 * s, 34 * s, 12 * s, 0.3, 0, Math.PI * 2)
        ctx.fill()
        ctx.fillStyle = '#4a5468'
        ctx.fillRect(x - 24 * s, y - 16 * s, 48 * s, 16 * s)
        crystal(ctx, x, y - 14 * s, 60 * s, 16 * s, '#d8f0ff')
    }
  }
}

/** Minimap: thu nhỏ đúng ảnh địa hình đã vẽ. */
export function renderMinimap(info: MapInfo, size: number, terrain?: TerrainImage): HTMLCanvasElement {
  const b = info.m.bounds
  const cv = document.createElement('canvas')
  cv.width = size
  cv.height = size
  const ctx = cv.getContext('2d')!
  if (terrain) {
    const s = terrain.scale
    ctx.imageSmoothingQuality = 'high'
    ctx.drawImage(terrain.canvas, (b.minX - terrain.minX) * s, (terrain.maxY - b.maxY) * s, (b.maxX - b.minX) * s, (b.maxY - b.minY) * s, 0, 0, size, size)
  }
  const fin = info.m.regions['Next_Round']
  if (fin) {
    const sx = size / (b.maxX - b.minX)
    const sy = size / (b.maxY - b.minY)
    ctx.fillStyle = '#ffcc00'
    ctx.fillRect((fin.minX - b.minX) * sx - 2, (b.maxY - fin.maxY) * sy, 6, (fin.maxY - fin.minY) * sy)
  }
  return cv
}
