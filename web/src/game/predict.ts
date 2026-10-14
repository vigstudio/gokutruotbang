// Dự đoán phía client cho Goku của chính mình: mô phỏng y hệt server
// (internal/game/game.go: tickHero, step, sideGuards) để click là thấy phản hồi
// ngay, rồi đối chiếu với trạng thái thật từ server và sửa sai êm dần.
import type { HeroState } from '../types'
import type { MapInfo } from './terrain'

const SLIDE_BASE = 400
const HERO_BASE_SPEED = 350
const HERO_RADIUS = 10
export const TICK = 1 / 50

// Bán kính chặn đường của vật trang trí - giống DoodadBlockRadius trên server
// (server/internal/game/rules.go). IWbg không chặn vì là vạch đích.
const DOODAD_BLOCK: Record<string, number> = { IOst: 34, NRic: 24, IOob: 20, YOfb: 24, D000: 18, ITig: 18 }

interface Guard {
  name: string
  minX: number
  minY: number
  maxX: number
  maxY: number
  horizontal: boolean
}

export class Predictor {
  x = 0
  y = 0
  f = 0
  onIce = false
  moving = false
  tx = 0
  ty = 0
  alive = false
  speed = HERO_BASE_SPEED
  realSpd = 1
  tick = 0 // tick server mà trạng thái hiện tại tương ứng
  /** vị trí ở tick trước, để nội suy khi vẽ (server 50 tick/s, màn hình 60+ Hz) */
  prevX = 0
  prevY = 0
  offX = 0 // độ lệch hiển thị, giảm dần về 0 sau mỗi lần sửa sai
  offY = 0
  ready = false
  lastSent = 0 // seq của lệnh cuối cùng đã gửi
  private inGuard = new Map<string, boolean>()
  private guards: Guard[] = []
  private blockers: { x: number; y: number; r: number }[] = []
  private history = new Map<number, [number, number]>()

  constructor(private info: MapInfo) {
    for (const d of info.m.doodads ?? []) {
      const r = DOODAD_BLOCK[d.type]
      if (r) this.blockers.push({ x: d.x, y: d.y, r: r * (d.scale || 1) })
    }
    for (const [name, r] of Object.entries(info.m.regions)) {
      if (!name.startsWith('SideGuard')) continue
      this.guards.push({ name, ...r, horizontal: name.startsWith('SideGuardTop') || name.startsWith('SideGuardBottom') })
    }
  }

  private walkable(x: number, y: number) {
    const b = this.info.m.bounds
    if (x < b.minX || x > b.maxX || y < b.minY || y > b.maxY) return false
    return this.info.walkable(x, y)
  }
  private canStand(x: number, y: number) {
    const r = HERO_RADIUS
    if (!(this.walkable(x, y) && this.walkable(x + r, y) && this.walkable(x - r, y) && this.walkable(x, y + r) && this.walkable(x, y - r))) return false
    for (const b of this.blockers) {
      const dx = x - b.x
      const dy = y - b.y
      if (dx * dx + dy * dy < (b.r + r) * (b.r + r)) return false
    }
    return true
  }
  /** Bị kẹt trong vòng chặn của vật trang trí thì đẩy ra mép (giống game.pushOut). */
  private pushOut() {
    for (const b of this.blockers) {
      let dx = this.x - b.x
      let dy = this.y - b.y
      let d = Math.hypot(dx, dy)
      const min = b.r + HERO_RADIUS
      if (d >= min) continue
      if (d < 1e-6) {
        dx = 1
        dy = 0
        d = 1
      }
      const nx = b.x + (dx / d) * (min + 0.5)
      const ny = b.y + (dy / d) * (min + 0.5)
      if (this.walkable(nx, ny)) {
        this.x = nx
        this.y = ny
      }
    }
  }
  private step(x: number, y: number, dx: number, dy: number): [number, number] {
    if (this.canStand(x + dx, y + dy)) return [x + dx, y + dy]
    const l = Math.hypot(dx, dy)
    if (l > 0) {
      const px = -dy / l
      const py = dx / l
      for (let off = 4; off <= 40; off += 4) {
        for (const s of [1, -1]) {
          const nx = x + dx + px * off * s
          const ny = y + dy + py * off * s
          if (this.canStand(nx, ny) && this.canStand(x + px * off * s, y + py * off * s)) return [nx, ny]
        }
      }
    }
    if (dx !== 0 && this.canStand(x + dx, y)) return [x + dx, y]
    if (dy !== 0 && this.canStand(x, y + dy)) return [x, y + dy]
    return [x, y]
  }

  /** Lệnh click của người chơi, áp dụng ngay (giống game.Order). */
  order(x: number, y: number) {
    if (!this.alive) return
    const dx = x - this.x
    const dy = y - this.y
    if (dx || dy) this.f = norm((Math.atan2(dy, dx) * 180) / Math.PI)
    if (this.onIce) {
      this.moving = false
      return
    }
    this.moving = true
    this.tx = x
    this.ty = y
  }
  stop() {
    this.moving = false
  }

  /** Một tick mô phỏng (giống phần di chuyển của game.tickHero). */
  stepTick() {
    this.tick++
    this.prevX = this.x
    this.prevY = this.y
    if (!this.alive) return
    this.onIce = this.info.tileAt(this.x, this.y) === 'Nice' && !this.thawed()
    if (this.onIce) {
      this.moving = false
      const d = SLIDE_BASE * (this.speed / HERO_BASE_SPEED) * this.realSpd * TICK
      const a = (this.f * Math.PI) / 180
      ;[this.x, this.y] = this.step(this.x, this.y, Math.cos(a) * d, Math.sin(a) * d)
    } else if (this.moving) {
      const dx = this.tx - this.x
      const dy = this.ty - this.y
      const d = Math.hypot(dx, dy)
      const v = this.speed * TICK
      if (d <= v) {
        ;[this.x, this.y] = this.step(this.x, this.y, dx, dy)
        this.moving = false
      } else {
        const [nx, ny] = this.step(this.x, this.y, (dx / d) * v, (dy / d) * v)
        if (nx === this.x && ny === this.y) this.moving = false
        this.x = nx
        this.y = ny
      }
    }
    this.pushOut()
    for (const g of this.guards) {
      const inside = this.x >= g.minX && this.x <= g.maxX && this.y >= g.minY && this.y <= g.maxY
      if (inside && !this.inGuard.get(g.name)) {
        if (g.horizontal) this.f = this.f > 90 && this.f < 270 ? 180 : 0
        else this.f = this.f > 0 && this.f < 180 ? 90 : 270
      }
      this.inGuard.set(g.name, inside)
    }
    this.history.set(this.tick, [this.x, this.y])
    this.history.delete(this.tick - 120)
  }

  thawedCorners = new Set<number>()
  private thawed() {
    return this.thawedCorners.has(this.info.cornerIndex(this.x, this.y))
  }

  /**
   * Đối chiếu với trạng thái server ở tick `serverTick`. Lệch ít thì sửa
   * vị trí ngay nhưng giữ độ lệch hiển thị để mắt thấy trượt êm; lệch nhiều
   * (chết, hồi sinh, qua vòng) thì nhảy thẳng tới vị trí server.
   */
  reconcile(h: HeroState, serverTick: number, playing: boolean) {
    this.speed = h.spd || HERO_BASE_SPEED
    this.realSpd = h.rs || 1
    const pending = h.q < this.lastSent
    if (!this.ready || !h.a || !this.alive || !playing) {
      this.snapTo(h, serverTick)
      this.alive = h.a
      this.ready = true
      return
    }
    const past = this.history.get(serverTick)
    if (!past) {
      this.snapTo(h, serverTick)
      return
    }
    const ex = h.x - past[0]
    const ey = h.y - past[1]
    if (Math.hypot(ex, ey) > 200) {
      this.snapTo(h, serverTick)
      return
    }
    if (Math.abs(ex) > 0.5 || Math.abs(ey) > 0.5) {
      this.x += ex
      this.y += ey
      this.prevX += ex
      this.prevY += ey
      this.offX -= ex
      this.offY -= ey
      for (const [t, p] of this.history) if (t >= serverTick) this.history.set(t, [p[0] + ex, p[1] + ey])
    }
    if (!pending) {
      // không còn lệnh chờ: hướng/đích đi bộ theo server là chuẩn
      if (Math.abs(angleDiff(h.f, this.f)) > 1 && Math.hypot(ex, ey) > 2) this.f = h.f
      this.moving = !!h.mv
      if (h.mv) {
        this.tx = h.tx ?? this.tx
        this.ty = h.ty ?? this.ty
      }
    }
  }

  private snapTo(h: HeroState, serverTick: number) {
    this.x = this.prevX = h.x
    this.y = this.prevY = h.y
    this.f = h.f
    this.moving = !!h.mv
    this.tx = h.tx ?? h.x
    this.ty = h.ty ?? h.y
    this.offX = this.offY = 0
    this.alive = h.a
    this.history.clear()
    if (this.tick < serverTick) this.tick = serverTick
    this.history.set(serverTick, [h.x, h.y])
    this.inGuard.clear()
    for (const g of this.guards) this.inGuard.set(g.name, h.x >= g.minX && h.x <= g.maxX && h.y >= g.minY && h.y <= g.maxY)
  }

  /** Vị trí để vẽ (đã cộng độ lệch giảm dần). */
  /** `alpha` (0..1): phần lẻ của tick hiện tại để vẽ giữa hai tick mô phỏng. */
  alpha = 1
  display(dtMs: number): [number, number] {
    const k = Math.pow(0.0001, dtMs / 1000) // ~90% độ lệch biến mất sau 0.25s
    this.offX *= k
    this.offY *= k
    const a = this.alpha
    return [this.prevX + (this.x - this.prevX) * a + this.offX, this.prevY + (this.y - this.prevY) * a + this.offY]
  }
}

function norm(a: number) {
  a %= 360
  return a < 0 ? a + 360 : a
}
function angleDiff(a: number, b: number) {
  return ((a - b + 540) % 360) - 180
}
