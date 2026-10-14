// Renderer trong trận (three.js + model MDX gốc của map): camera nghiêng kiểu
// WC3, toạ độ thế giới giữ nguyên như map gốc (Z hướng lên).
import * as THREE from 'three'
import type { GameEvent, HeroState, Snapshot } from '../types'
import { clock, snaps } from '../net'
import type { Predictor } from '../game/predict'
import type { MapInfo, TerrainImage } from '../game/terrain'
import { makeLights, makeSky, radialTexture, Snowfall } from './env'
import { buildWorld, type World } from './world'
import { W3Model } from './w3model'
import { loadProAssets } from './proassets'
import { giftBox, shieldBubble, shopStall } from './shopfx'
import { FpsWatch, getQuality, setQuality, settings, type Quality } from './quality'

const DBG = new URLSearchParams(location.search)
const PITCH = (56 * Math.PI) / 180 // góc camera mặc định của WC3
const FOV = 50
const GOKU_SCALE = 1.05 // model WC3 gốc (có animation), to hơn bản gốc 0.6 cho dễ nhìn
const DRAGON_SCALE = 0.85
const BIG_DRAGON_SCALE = 2.0
const DRAGON_LIFT = 95 // rồng Trung Hoa bay là là trên mặt băng

interface Effect {
  kind: string
  x: number
  y: number
  tx?: number
  ty?: number
  color?: string
  text?: string
  start: number
  dur: number
  mesh?: THREE.Object3D
}

export interface View {
  heroes: HeroState[]
  dragons: Snapshot['dragons']
  markers: Snapshot['markers']
  boxes: Snapshot['boxes']
  thaws: Snapshot['thaws']
  phase: Snapshot['phase']
  moving: Set<string>
}

export class Renderer3D {
  renderer: THREE.WebGLRenderer
  scene = new THREE.Scene()
  fx = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(FOV, 1, 20, 20000)
  world!: World
  terrain!: TerrainImage
  goku: W3Model | null = null
  dragon: W3Model | null = null
  quality: Quality = getQuality()
  onQualityDrop: ((q: Quality) => void) | null = null
  private fpsWatch = new FpsWatch()
  /** FPS đo trong 0.5 giây gần nhất (hiển thị trên HUD). */
  fpsNow = 0
  frameMs = 0
  private fpsFrames = 0
  private fpsStart = 0
  private shadowKey = ''
  private interpDelay = 4
  ctx2d: CanvasRenderingContext2D

  camX = 0
  camY = 0
  zoom = 0.55
  follow = true
  viewOffsetY = 80
  colors: string[] = []
  mySlot = -1
  pred: Predictor | null = null
  effects: Effect[] = []
  targeting: { range: number; x: number; y: number; key: string } | null = null
  mouseWorld: [number, number] = [0, 0]
  lastView: View | null = null
  sprites: unknown = null

  // ------------------------------------------------ quán, hộp quà, khiên
  private stalls: { group: THREE.Group; update: (t: number) => void }[] = []
  private boxObjs = new Map<number, THREE.Group>()
  private bubbles = new Map<number, THREE.Mesh>()
  /** Vị trí 3 quán Krusty Krab (từ danh mục server). */
  set shops(list: [number, number][]) {
    for (const st of this.stalls) this.scene.remove(st.group)
    this.stalls = list.map(([x, y]) => {
      const st = shopStall()
      st.group.position.set(x, y, this.world?.heightAt(x, y) ?? 0)
      this.scene.add(st.group)
      return st
    })
    this.renderer.shadowMap.needsUpdate = true
  }

  private syncItems(v: View, now: number) {
    const t = now / 1000
    for (const st of this.stalls) st.update(t)
    // hộp quà
    const seen = new Set<number>()
    for (const [id, x, y] of v.boxes ?? []) {
      seen.add(id)
      let b = this.boxObjs.get(id)
      if (!b) {
        b = giftBox()
        b.scale.setScalar(1.6)
        b.position.set(x, y, 0)
        this.scene.add(b)
        this.boxObjs.set(id, b)
      }
      const inner = b.children[0]
      inner.rotation.z = t * 1.4 + id
      inner.position.z = 8 + Math.sin(t * 3 + id) * 6
    }
    for (const [id, b] of this.boxObjs) {
      if (!seen.has(id)) {
        this.scene.remove(b)
        this.boxObjs.delete(id)
      }
    }
    // Khiên Băng: quầng quanh Goku còn giữ khiên; nhấp nháy khi đang bất tử
    for (const h of v.heroes) {
      const shield = h.a && (!!h.sh || !!h.inv?.some((s) => s.i === 'shield'))
      const show = shield || (h.a && !!h.iv)
      let m = this.bubbles.get(h.s)
      if (!show) {
        if (m) m.visible = false
        continue
      }
      if (!m) {
        m = shieldBubble()
        this.fx.add(m)
        this.bubbles.set(h.s, m)
      }
      m.visible = true
      m.position.set(h.x, h.y, 70 + h.h * 0.8)
      const u = (m.material as THREE.ShaderMaterial).uniforms
      u.uTime.value = t
      u.uAlpha.value = h.iv ? 0.5 + 0.5 * Math.sin(t * 22) : h.ww ? 0.3 : 0.75
    }
  }

  private lights!: ReturnType<typeof makeLights>
  private snow: Snowfall
  private snowBase = 1
  onNotice: ((text: string) => void) | null = null
  private wasBlizzard = false
  private wasNight: boolean | null = null
  private shadowInst!: THREE.InstancedMesh
  private rings: THREE.Mesh[] = []
  private markerObjs: THREE.Object3D[] = []
  private thawObjs: THREE.Mesh[] = []
  private targetRing!: THREE.Mesh
  private targetCursor!: THREE.Mesh
  private lastFrame = 0
  private w = 0
  private h = 0
  private ray = new THREE.Raycaster()
  private ground = new THREE.Plane(new THREE.Vector3(0, 0, 1), 0)
  private thawTex: THREE.Texture | null = null
  private glowTex = radialTexture('rgba(255,255,255,1)', 'rgba(255,255,255,0)')

  constructor(
    public canvas: HTMLCanvasElement,
    public overlay: HTMLCanvasElement,
    public info: MapInfo,
  ) {
    const qs = settings(this.quality)
    this.renderer = new THREE.WebGLRenderer({ canvas, antialias: this.quality !== 'low', powerPreference: 'high-performance' })
    this.renderer.setPixelRatio(qs.pixelRatio)
    this.renderer.shadowMap.enabled = qs.shadows
    this.renderer.shadowMap.type = qs.softShadows ? THREE.PCFSoftShadowMap : THREE.PCFShadowMap
    // vật đổ bóng (cây, đá, pha lê) đứng yên -> chỉ vẽ lại shadow map khi
    // vùng bóng dời đi hoặc mặt trời đổi hướng
    this.renderer.shadowMap.autoUpdate = false
    this.snow = new Snowfall(qs.snow * 3, 2800, 1500)
    this.snowBase = 1 / 3
    this.renderer.toneMapping = THREE.ACESFilmicToneMapping
    this.renderer.toneMappingExposure = 0.82
    this.ctx2d = overlay.getContext('2d')!
    this.camera.up.set(0, 0, 1)

    const sky = makeSky(this.renderer)
    this.scene.background = new THREE.Color(0x0b1424)
    this.scene.environment = sky.env
    this.scene.fog = new THREE.FogExp2(0x0f1a2e, 0.00013)
    this.lights = makeLights(this.scene)
    // ánh trăng Northrend: lạnh, dịu
    this.lights.sun.color.set(0xbcd0ff)
    this.lights.sun.intensity = 1.6
    this.lights.hemi.color.set(0x7d9ad8)
    this.lights.hemi.groundColor.set(0x1c2638)
    this.lights.hemi.intensity = 0.6
    this.lights.sun.shadow.mapSize.set(qs.shadowMap, qs.shadowMap)

    const st = info.m.regions['Kitty_Start']
    if (st) {
      this.camX = (st.minX + st.maxX) / 2
      this.camY = (st.minY + st.maxY) / 2
    }

    // bóng mờ dưới chân unit (instanced)
    const shGeo = new THREE.PlaneGeometry(1, 1)
    const shMat = new THREE.MeshBasicMaterial({ map: radialTexture('rgba(0,10,25,0.55)', 'rgba(0,10,25,0)'), transparent: true, depthWrite: false })
    this.shadowInst = new THREE.InstancedMesh(shGeo, shMat, 400)
    this.shadowInst.count = 0
    this.shadowInst.frustumCulled = false
    this.scene.add(this.shadowInst)



    const tr = new THREE.Mesh(new THREE.RingGeometry(0.985, 1, 96), new THREE.MeshBasicMaterial({ color: 0xffffff, transparent: true, opacity: 0.45, depthWrite: false }))
    tr.visible = false
    this.targetRing = tr
    this.fx.add(tr)
    const tc = new THREE.Mesh(new THREE.RingGeometry(40, 48, 32), new THREE.MeshBasicMaterial({ color: 0x7dff8a, transparent: true, depthWrite: false }))
    tc.visible = false
    this.targetCursor = tc
    this.fx.add(tc)
    this.fx.add(this.snow.points)
  }

  /** Dựng thế giới + nạp model (gọi một lần, có thể mất vài giây). */
  async init() {
    const pro = await loadProAssets(this.renderer)
    this.scene.environment = pro.env
    this.scene.environmentIntensity = 0.45 // đêm: phản chiếu bầu trời dịu đi
    this.world = buildWorld(this.info, pro, settings(this.quality))
    this.terrain = this.world.terrain2d
    this.scene.add(this.world.group)
    const gl = this.renderer.getContext()
    const [g, d] = await Promise.all([
      W3Model.load(gl, 'war3mapImported/zMidouz.mdx'),
      W3Model.load(gl, 'war3mapImported/ChineseDragon.mdx'),
    ])
    this.goku = g
    this.dragon = d
    this.renderer.resetState()
    this.renderer.compile(this.scene, this.camera)
    this.fpsWatch.reset()
  }

  private makeThawTexture() {
    const cv = document.createElement('canvas')
    cv.width = cv.height = 256
    const ctx = cv.getContext('2d')!
    ctx.fillStyle = ctx.createPattern(this.dirtCanvas(), 'repeat')!
    ctx.beginPath()
    ctx.arc(128, 128, 120, 0, Math.PI * 2)
    ctx.fill()
    ctx.globalCompositeOperation = 'destination-in'
    const g = ctx.createRadialGradient(128, 128, 70, 128, 128, 126)
    g.addColorStop(0, 'rgba(0,0,0,1)')
    g.addColorStop(1, 'rgba(0,0,0,0)')
    ctx.fillStyle = g
    ctx.fillRect(0, 0, 256, 256)
    const t = new THREE.CanvasTexture(cv)
    t.colorSpace = THREE.SRGBColorSpace
    return t
  }
  private dirtCanvas() {
    // lấy texture đất đá đã sinh cho địa hình
    return (this.terrain?.dirt ?? document.createElement('canvas')) as HTMLCanvasElement
  }

  // ------------------------------------------------------------ toạ độ
  private resize() {
    const w = this.canvas.clientWidth
    const h = this.canvas.clientHeight
    if (w === this.w && h === this.h) return
    this.w = w
    this.h = h
    this.renderer.setSize(w, h, false)
    this.overlay.width = w
    this.overlay.height = h
    this.camera.aspect = w / h
    this.camera.updateProjectionMatrix()
  }
  private get dist() {
    return 900 / this.zoom
  }
  private placeCamera() {
    const d = this.dist
    this.camera.position.set(this.camX, this.camY - d * Math.cos(PITCH), d * Math.sin(PITCH))
    this.camera.lookAt(this.camX, this.camY, 0)
    this.camera.updateMatrixWorld()
  }
  toWorld(sx: number, sy: number): [number, number] {
    const ndc = new THREE.Vector2((sx / (this.w || 1)) * 2 - 1, -(sy / (this.h || 1)) * 2 + 1)
    this.ray.setFromCamera(ndc, this.camera)
    const p = new THREE.Vector3()
    if (!this.ray.ray.intersectPlane(this.ground, p)) return [this.camX, this.camY + 4000]
    return [p.x, p.y]
  }
  toScreen(x: number, y: number, z = 0): [number, number] {
    const v = new THREE.Vector3(x, y, z).project(this.camera)
    return [((v.x + 1) / 2) * this.w, ((1 - v.y) / 2) * this.h]
  }
  private worldPerPx() {
    return (2 * this.dist * Math.tan(((FOV / 2) * Math.PI) / 180)) / (this.h || 1) / Math.sin(PITCH)
  }

  // ------------------------------------------------------------ nội suy snapshot
  view(now: number): View | null {
    if (snaps.length === 0) return null
    const want = 3 + Math.min(6, (clock.jitter * 2) / 20)
    this.interpDelay += Math.max(-0.01, Math.min(0.01, want - this.interpDelay))
    const rt = clock.serverTick(now) - this.interpDelay
    let ai = snaps.length - 2
    for (let i = snaps.length - 2; i >= 0; i--) {
      ai = i
      if (snaps[i].snap.tick <= rt) break
    }
    const a = snaps[Math.max(0, ai)]
    const b = snaps[Math.min(snaps.length - 1, Math.max(0, ai) + 1)]
    const span = b.snap.tick - a.snap.tick || 1
    const k = Math.max(0, Math.min(1.25, (rt - a.snap.tick) / span))
    const sa = a.snap
    const sb = b.snap
    const moving = new Set<string>()
    const prevHero = new Map((sa.heroes ?? []).map((h) => [h.s, h]))
    const heroes = (sb.heroes ?? []).map((h) => {
      if (h.s === this.mySlot && this.pred?.ready && h.a) {
        const [x, y] = this.pred.display(now - this.lastFrame)
        if (this.pred.moving) moving.add('h' + h.s)
        return { ...h, x, y, f: this.pred.f, ice: this.pred.onIce }
      }
      const p = prevHero.get(h.s)
      if (!p || !p.a || !h.a || Math.hypot(p.x - h.x, p.y - h.y) > 400) return h
      if (Math.hypot(p.x - h.x, p.y - h.y) > 2 && !h.ice) moving.add('h' + h.s)
      return { ...h, x: lerp(p.x, h.x, k), y: lerp(p.y, h.y, k), f: lerpAngle(p.f, h.f, k), h: lerp(p.h, h.h, k) }
    })
    const prevDr = new Map((sa.dragons ?? []).map((d) => [d[0], d]))
    const dragons = (sb.dragons ?? []).map((d) => {
      const p = prevDr.get(d[0])
      if (!p) return d
      if (Math.hypot(p[1] - d[1], p[2] - d[2]) > 1) moving.add('d' + d[0])
      return [d[0], lerp(p[1], d[1], k), lerp(p[2], d[2], k), lerpAngle(p[3], d[3], k), d[4], d[5]] as typeof d
    })
    this.lastFrame = now
    return { heroes, dragons, markers: sb.markers, thaws: sb.thaws, boxes: sb.boxes, phase: sb.phase, moving }
  }

  // ------------------------------------------------------------ sự kiện
  onEvent(e: GameEvent, now: number) {
    const color = this.colors[e.slot] ?? '#ffffff'
    switch (e.kind) {
      case 'cast':
        if (e.ab === 'Q') this.addRing(e.x!, e.y!, '#ffb347', now, 500)
        if (e.ab === 'E') this.effects.push({ kind: 'swarm', x: e.x!, y: e.y!, tx: e.tx, ty: e.ty, start: now, dur: 800 })
        if (e.ab === 'A') this.addRing(e.tx!, e.ty!, '#c8a070', now, 1000, true)
        if (e.ab === 'R') this.addRing(e.x!, e.y!, '#9be7ff', now, 400)
        if (e.ab === 'W') this.addRing(e.x!, e.y!, '#c9b8ff', now, 600)
        break
      case 'death':
        this.effects.push({ kind: 'burst', x: e.x!, y: e.y!, color: '#ff4040', start: now, dur: 900 })
        this.effects.push({ kind: 'float', x: e.x!, y: e.y!, text: '☠', color, start: now, dur: 1500 })
        break
      case 'revive':
        this.addRing(e.x!, e.y!, '#7dff8a', now, 900)
        this.effects.push({ kind: 'float', x: e.x!, y: e.y!, text: 'Hồi sinh!', color: '#7dff8a', start: now, dur: 1500 })
        break
      case 'levelup':
        this.addRing(e.x!, e.y!, '#ffd700', now, 900)
        this.effects.push({ kind: 'float', x: e.x!, y: e.y!, text: 'LEVEL UP', color: '#ffd700', start: now, dur: 1500 })
        break
      case 'pickup':
        this.addRing(e.x!, e.y!, '#ffd76a', now, 600)
        this.effects.push({ kind: 'float', x: e.x!, y: e.y!, text: e.text ?? '', color: '#ffe48a', start: now, dur: 1400 })
        break
      case 'item':
        this.addRing(e.x!, e.y!, '#f0c860', now, 500)
        break
      case 'use':
        this.addRing(e.x!, e.y!, e.ab === 'manapot' ? '#6a9aff' : e.ab === 'speedpot' ? '#6af0c8' : e.ab === 'senzu' ? '#b8ff60' : '#ffb347', now, 700)
        break
      case 'shield':
        this.addRing(e.x!, e.y!, '#9fe2ff', now, 700)
        this.effects.push({ kind: 'burst', x: e.x!, y: e.y!, color: '#bfeaff', start: now, dur: 700 })
        this.effects.push({ kind: 'float', x: e.x!, y: e.y!, text: 'Khiên vỡ!', color: '#bfeaff', start: now, dur: 1300 })
        break
      case 'ball':
        this.addRing(e.x!, e.y!, '#ffb42a', now, 900)
        this.effects.push({ kind: 'float', x: e.x!, y: e.y!, text: `Ngọc Rồng ${e.dur ?? ''}★`, color: '#ffb42a', start: now, dur: 1800 })
        break
      case 'wish':
        this.addRing(e.x!, e.y!, '#7ae88a', now, 1500)
        this.addRing(e.x!, e.y!, '#ffd76a', now, 2200)
        break
      case 'dragonDie':
        this.effects.push({ kind: 'burst', x: e.x!, y: e.y!, color: '#ff9b3d', start: now, dur: 700 })
        break
    }
  }

  private addRing(x: number, y: number, color: string, now: number, dur: number, shrink = false) {
    const m = new THREE.Mesh(
      new THREE.RingGeometry(0.85, 1, 48),
      new THREE.MeshBasicMaterial({ color: new THREE.Color(color), transparent: true, blending: THREE.AdditiveBlending, depthWrite: false }),
    )
    m.position.set(x, y, 4)
    this.fx.add(m)
    this.effects.push({ kind: shrink ? 'ringIn' : 'ring', x, y, start: now, dur, mesh: m })
  }

  // ------------------------------------------------------------ vẽ
  render(now: number) {
    this.fpsFrames++
    if (now - this.fpsStart >= 500) {
      this.fpsNow = Math.round((this.fpsFrames * 1000) / (now - this.fpsStart))
      this.fpsFrames = 0
      this.fpsStart = now
    }
    const t0 = performance.now()
    if (this.fpsWatch.tick(now) && this.quality !== 'low') {
      const next: Quality = this.quality === 'high' ? 'medium' : 'low'
      this.applyQuality(next)
      this.onQualityDrop?.(next)
    }
    this.resize()
    const v = this.view(now)
    this.lastView = v
    const me = v?.heroes.find((h) => h.s === this.mySlot)
    if (me && me.a && this.follow) {
      const ty = me.y - this.viewOffsetY * this.worldPerPx()
      this.camX += (me.x - this.camX) * 0.15
      this.camY += (ty - this.camY) * 0.15
    }
    const b = this.info.m.bounds
    this.camX = Math.max(b.minX, Math.min(b.maxX, this.camX))
    this.camY = Math.max(b.minY - 600, Math.min(b.maxY - 300, this.camY))
    this.placeCamera()

    const t = now / 1000
    const dt = Math.min(0.1, (now - (this as any)._prev || 16) / 1000)
    ;(this as any)._prev = now
    this.updateEnvironment()
    const sun = this.lights.sun
    // vùng bóng bám camera theo bước 256 đơn vị
    const scx = Math.round(this.camX / 256) * 256
    const scy = Math.round(this.camY / 256) * 256
    sun.position.set(scx + this.sunOffset.x, scy + this.sunOffset.y, this.sunOffset.z)
    sun.target.position.set(scx, scy, 0)
    const key = `${scx},${scy},${this.sunOffset.x},${this.sunOffset.y}`
    if (key !== this.shadowKey) {
      this.shadowKey = key
      this.renderer.shadowMap.needsUpdate = true
    }
    this.world.update(t, this.camX, this.camY)
    this.snow.update(dt, this.camX, this.camY, t)

    if (v) {
      this.syncTrails(v, now)
      this.syncShadows(v)
      this.syncRings(v, now)
      this.syncMarkers(v, now)
      this.syncThaws(v)
      this.syncItems(v, now)
    }
    this.syncTargeting()
    this.syncEffects(now)

    const r = this.renderer
    r.autoClear = true
    r.render(this.scene, this.camera)
    if (v) this.drawUnits(v, now)
    r.resetState()
    r.autoClear = false
    if (!DBG.has('nofx')) r.render(this.fx, this.camera)
    this.drawOverlay(v, now)
    this.frameMs = this.frameMs * 0.9 + (performance.now() - t0) * 0.1
  }

  // ------------------------------------------------------------ ngày đêm + bão tuyết
  /** Thời gian theo server (giây) để mọi người chơi thấy cùng thời tiết. */
  private serverSeconds() {
    const last = snaps[snaps.length - 1]
    return last ? last.snap.time + (performance.now() - last.at) / 1000 : performance.now() / 1000
  }

  private updateEnvironment() {
    const T = this.serverSeconds()
    // ngày - đêm: chu kỳ 6 phút, vào trận lúc buổi sáng
    const cyc = ((T + 110) % 360) / 360
    const sunUp = 0.5 - 0.5 * Math.cos(cyc * Math.PI * 2) // 0 nửa đêm .. 1 giữa trưa
    const day = smooth01((sunUp - 0.3) / 0.4)
    // bão tuyết: mỗi khung 80 giây có ~35% khả năng, vào/ra dần 10 giây
    const win = Math.floor(T / 80)
    const local = T - win * 80
    const storm = hash1(win) < 0.35 ? smooth01(local / 10) * smooth01((80 - local) / 10) : 0

    const L = this.lights
    const mix = (a: number, b: number, k: number) => a + (b - a) * k
    L.sun.intensity = mix(1.5, 2.9, day) * (1 - storm * 0.55)
    L.sun.color.setRGB(mix(0.74, 1.0, day), mix(0.82, 0.95, day), mix(1.0, 0.88, day))
    L.hemi.intensity = mix(0.55, 1.05, day) * (1 - storm * 0.2)
    L.hemi.color.setRGB(mix(0.49, 0.8, day), mix(0.6, 0.88, day), mix(0.85, 1.0, day))
    L.hemi.groundColor.setRGB(mix(0.11, 0.42, day), mix(0.15, 0.47, day), mix(0.22, 0.56, day))
    this.renderer.toneMappingExposure = mix(0.8, 1.0, day)
    this.scene.environmentIntensity = mix(0.4, 0.95, day)
    // góc mặt trời/mặt trăng đổi theo giờ -> bóng đổ xoay dần
    const az = (Math.round(cyc * 240) / 240) * Math.PI * 2
    this.sunOffset.set(Math.cos(az) * 1000, Math.sin(az) * 700 + 600, mix(1500, 2000, day))

    const fogDay = new THREE.Color(0xa9bfd8)
    const fogNight = new THREE.Color(0x0f1a2e)
    const fogStorm = new THREE.Color(day > 0.5 ? 0xc9d6e6 : 0x46546c)
    const fc = fogNight.clone().lerp(fogDay, day).lerp(fogStorm, storm * 0.85)
    const fog = this.scene.fog as THREE.FogExp2
    fog.color.copy(fc)
    fog.density = 0.00013 + storm * 0.00055
    ;(this.scene.background as THREE.Color).copy(fc)

    this.snow.density = this.snowBase * (1 + storm * 2)
    this.snow.wind = storm * 520

    const isNight = day < 0.5
    if (this.wasNight !== null && isNight !== this.wasNight) this.onNotice?.(isNight ? 'Màn đêm buông xuống…' : 'Trời đã sáng!')
    this.wasNight = isNight
    const isStorm = storm > 0.05
    if (isStorm && !this.wasBlizzard) this.onNotice?.('Bão tuyết đang kéo đến! Tầm nhìn giảm.')
    this.wasBlizzard = isStorm
  }

  private sunOffset = new THREE.Vector3(-900, 1100, 1800)

  // ------------------------------------------------------------ vệt trượt
  private trails = new Map<number, { pts: { x: number; y: number; t: number }[]; mesh: THREE.Mesh; color: THREE.Color }>()

  /** Vệt sáng kéo sau Goku khi trượt băng (như hiệu ứng trong map gốc). */
  private syncTrails(v: View, now: number) {
    const MAX = 48
    const LIFE = 420 // ms
    for (const h of v.heroes) {
      let tr = this.trails.get(h.s)
      if (!tr) {
        const geo = new THREE.BufferGeometry()
        geo.setAttribute('position', new THREE.BufferAttribute(new Float32Array(MAX * 2 * 3), 3))
        geo.setAttribute('color', new THREE.BufferAttribute(new Float32Array(MAX * 2 * 4), 4))
        const idx: number[] = []
        for (let i = 0; i < MAX - 1; i++) idx.push(i * 2, i * 2 + 1, i * 2 + 2, i * 2 + 1, i * 2 + 3, i * 2 + 2)
        geo.setIndex(idx)
        const mesh = new THREE.Mesh(
          geo,
          new THREE.MeshBasicMaterial({ vertexColors: true, transparent: true, depthWrite: false, side: THREE.DoubleSide }),
        )
        mesh.frustumCulled = false
        this.fx.add(mesh)
        const c = new THREE.Color(this.colors[h.s] ?? '#ffffff').lerp(new THREE.Color(0xffffff), 0.55)
        tr = { pts: [], mesh, color: c }
        this.trails.set(h.s, tr)
      }
      const last = tr.pts[tr.pts.length - 1]
      const sliding = h.a && h.ice && h.h < 1
      if (sliding && (!last || Math.hypot(last.x - h.x, last.y - h.y) > 6)) tr.pts.push({ x: h.x, y: h.y, t: now })
      if (!h.a || (last && Math.hypot(last.x - h.x, last.y - h.y) > 300)) tr.pts.length = 0
      while (tr.pts.length && (now - tr.pts[0].t > LIFE || tr.pts.length > MAX)) tr.pts.shift()
      const pos = tr.mesh.geometry.getAttribute('position') as THREE.BufferAttribute
      const col = tr.mesh.geometry.getAttribute('color') as THREE.BufferAttribute
      const n = tr.pts.length
      for (let i = 0; i < MAX; i++) {
        const p = tr.pts[Math.min(i, n - 1)]
        if (!p || n < 2) {
          pos.setXYZ(i * 2, 0, 0, -999)
          pos.setXYZ(i * 2 + 1, 0, 0, -999)
          continue
        }
        const q = tr.pts[Math.min(i + 1, n - 1)]
        const r = tr.pts[Math.min(Math.max(i - 1, 0), n - 1)]
        let dx = q.x - r.x
        let dy = q.y - r.y
        const l = Math.hypot(dx, dy) || 1
        dx /= l
        dy /= l
        const age = 1 - (now - p.t) / LIFE
        const w = 11 * Math.max(0, age)
        const z = 14
        pos.setXYZ(i * 2, p.x - dy * w, p.y + dx * w, z)
        pos.setXYZ(i * 2 + 1, p.x + dy * w, p.y - dx * w, z)
        const a = Math.max(0, age) * (i < n ? 0.9 : 0)
        col.setXYZW(i * 2, tr.color.r, tr.color.g, tr.color.b, a)
        col.setXYZW(i * 2 + 1, tr.color.r, tr.color.g, tr.color.b, a)
      }
      pos.needsUpdate = true
      col.needsUpdate = true
    }
  }

  /** Đổi chất lượng khi đang chơi (độ phân giải + bóng đổ áp dụng ngay). */
  applyQuality(q: Quality) {
    this.quality = q
    setQuality(q)
    const qs = settings(q)
    // chỉ đổi độ phân giải + cỡ shadow map: không đụng tới define của shader
    // nên không phải biên dịch lại (tránh đứng hình giữa trận)
    this.renderer.setPixelRatio(qs.pixelRatio)
    this.lights.sun.shadow.map?.dispose()
    this.lights.sun.shadow.map = null as unknown as THREE.WebGLRenderTarget
    this.lights.sun.shadow.mapSize.set(qs.shadowMap, qs.shadowMap)
    this.renderer.shadowMap.needsUpdate = true
    this.fpsWatch.reset(performance.now(), 3000)
    this.w = 0 // ép resize lại
  }

  private syncShadows(v: View) {
    const m = new THREE.Matrix4()
    let n = 0
    const put = (x: number, y: number, s: number) => {
      if (n >= 400) return
      m.makeScale(s, s * 0.8, 1).setPosition(x + 10, y - 8, 1.5)
      this.shadowInst.setMatrixAt(n++, m)
    }
    for (const h of v.heroes) if (h.a) put(h.x, h.y, 70 * (1 - Math.min(0.6, h.h / 900)))
    for (const d of v.dragons ?? []) put(d[1], d[2], d[4] ? 260 : 120)
    this.shadowInst.count = n
    this.shadowInst.instanceMatrix.needsUpdate = true
  }

  private syncRings(v: View, now: number) {
    const alive = v.heroes.filter((h) => h.a)
    while (this.rings.length < alive.length) {
      const ring = new THREE.Mesh(new THREE.RingGeometry(34, 40, 48), new THREE.MeshBasicMaterial({ color: 0xffffff, transparent: true, opacity: 0.9, depthWrite: false }))
      this.scene.add(ring)
      this.rings.push(ring)
    }
    this.rings.forEach((ring, i) => {
      const h = alive[i]
      ring.visible = !!h
      if (!h) return
      ring.position.set(h.x, h.y, 2)
      const mat = ring.material as THREE.MeshBasicMaterial
      mat.color.set(h.s === this.mySlot ? '#3cff3c' : this.colors[h.s] ?? '#fff')
      mat.opacity = h.ww ? 0.35 : 0.85 + Math.sin(now / 300) * 0.1
    })
  }

  private syncMarkers(v: View, now: number) {
    const list = v.markers ?? []
    while (this.markerObjs.length < list.length) {
      const g = new THREE.Group()
      const ring = new THREE.Mesh(new THREE.RingGeometry(62, 70, 64), new THREE.MeshBasicMaterial({ color: 0xffffff, transparent: true, blending: THREE.AdditiveBlending, depthWrite: false }))
      const glow = new THREE.Mesh(new THREE.CircleGeometry(70, 48), new THREE.MeshBasicMaterial({ map: this.glowTex, color: 0xffffff, transparent: true, opacity: 0.4, blending: THREE.AdditiveBlending, depthWrite: false }))
      const pillar = new THREE.Mesh(
        new THREE.CylinderGeometry(40, 60, 260, 24, 1, true).rotateX(Math.PI / 2).translate(0, 0, 130),
        new THREE.MeshBasicMaterial({ color: 0xffffff, transparent: true, opacity: 0.18, blending: THREE.AdditiveBlending, depthWrite: false, side: THREE.DoubleSide }),
      )
      g.add(ring, glow, pillar)
      this.fx.add(g)
      this.markerObjs.push(g)
    }
    this.markerObjs.forEach((g, i) => {
      const mk = list[i]
      g.visible = !!mk
      if (!mk) return
      g.position.set(mk[1], mk[2], 3)
      const col = new THREE.Color(this.colors[mk[0]] ?? '#fff')
      g.children.forEach((c) => ((c as THREE.Mesh).material as THREE.MeshBasicMaterial).color.copy(col))
      g.scale.setScalar(1 + Math.sin(now / 250) * 0.05)
    })
  }

  private syncThaws(v: View) {
    const list = v.thaws ?? []
    while (this.thawObjs.length < list.length) {
      this.thawTex = this.thawTex ?? this.makeThawTexture()
      const m = new THREE.Mesh(new THREE.PlaneGeometry(190, 190), new THREE.MeshStandardMaterial({ map: this.makeThawTexture(), transparent: true, depthWrite: false, roughness: 0.95 }))
      m.receiveShadow = true
      this.scene.add(m)
      this.thawObjs.push(m)
    }
    this.thawObjs.forEach((m, i) => {
      const th = list[i]
      m.visible = !!th
      if (!th) return
      const [cx, cy] = this.info.cornerPos(th[0])
      m.position.set(cx, cy, 1)
    })
  }

  private syncTargeting() {
    const t = this.targeting
    const me = this.lastView?.heroes.find((h) => h.s === this.mySlot)
    this.targetRing.visible = this.targetCursor.visible = !!(t && me)
    if (!t || !me) return
    this.targetRing.position.set(me.x, me.y, 3)
    this.targetRing.scale.setScalar(t.range)
    const [mx, my] = this.mouseWorld
    const ok = Math.hypot(mx - me.x, my - me.y) <= t.range + 50
    ;(this.targetCursor.material as THREE.MeshBasicMaterial).color.set(ok ? '#7dff8a' : '#ff5a5a')
    if (t.key === 'A') {
      const c = this.info.cornerIndex(mx, my)
      const [cx, cy] = c >= 0 ? this.info.cornerPos(c) : [mx, my]
      this.targetCursor.position.set(cx, cy, 4)
      this.targetCursor.scale.setScalar(1.6)
    } else {
      this.targetCursor.position.set(mx, my, 4)
      this.targetCursor.scale.setScalar(1)
    }
  }

  private syncEffects(now: number) {
    this.effects = this.effects.filter((e) => {
      const p = (now - e.start) / e.dur
      if (p >= 1) {
        if (e.mesh) {
          this.fx.remove(e.mesh)
          ;(e.mesh as THREE.Mesh).geometry?.dispose()
        }
        return false
      }
      if (e.mesh) {
        const s = e.kind === 'ringIn' ? 100 - p * 60 : 20 + p * 120
        e.mesh.scale.setScalar(s)
        ;((e.mesh as THREE.Mesh).material as THREE.MeshBasicMaterial).opacity = 1 - p
      }
      if (e.kind === 'click' && !e.mesh) {
        const m = new THREE.Mesh(new THREE.RingGeometry(0.8, 1, 32), new THREE.MeshBasicMaterial({ color: 0x50ff64, transparent: true, depthWrite: false }))
        m.position.set(e.x, e.y, 4)
        this.fx.add(m)
        e.mesh = m
        e.kind = 'ringIn'
      }
      return true
    })
  }

  private drawUnits(v: View, now: number) {
    const gl = this.renderer.getContext()
    // đưa WebGL về trạng thái mặc định trước khi thư viện model WC3 vẽ
    // (three.js để lại VAO/blend/texture unit... làm lệnh vẽ không ra pixel)
    this.renderer.resetState()
    gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight)
    if (DBG.has('nodepth')) gl.disable(gl.DEPTH_TEST)
    else gl.enable(gl.DEPTH_TEST)
    gl.depthFunc(gl.LEQUAL)
    gl.depthMask(true)
    const view = this.camera.matrixWorldInverse.elements
    const proj = this.camera.projectionMatrix.elements

    // rồng: chỉ vẽ con nằm trong tầm nhìn, gom theo pha animation
    const dragon = this.dragon
    if (dragon) {
      const list: { d: NonNullable<Snapshot['dragons']>[number]; anim: string; time: number }[] = []
      for (const d of v.dragons ?? []) {
        const [sx, sy] = this.toScreen(d[1], d[2])
        if (sx < -300 || sy < -300 || sx > this.w + 300 || sy > this.h + 300) continue
        const anim = v.moving.has('d' + d[0]) ? 'Walk' : 'Stand'
        list.push({ d, anim, time: now + d[0] * 137 })
      }
      const key = (o: (typeof list)[number]) => o.anim + Math.floor((((o.time % 1000) + 1000) % 1000) / 100)
      list.sort((a, b) => (key(a) < key(b) ? -1 : 1))
      for (const o of list) {
        const sc = o.d[4] ? BIG_DRAGON_SCALE : DRAGON_SCALE
        dragon.pose(o.anim, o.time, 10)
        dragon.draw(view, proj, o.d[1], o.d[2], DRAGON_LIFT * sc + Math.sin(now / 400 + o.d[0]) * 10, o.d[3], sc)
      }
    }
    const goku = this.goku
    if (goku) {
      for (const h of v.heroes) {
        if (!h.a) continue
        const anim = h.h > 1 ? 'Spell' : v.moving.has('h' + h.s) ? 'Walk' : 'Stand - 1'
        goku.pose(anim, now + h.s * 311, 24)
        goku.draw(view, proj, h.x, h.y, h.h * 0.8, h.f, GOKU_SCALE)
      }
    }
  }

  private drawOverlay(v: View | null, now: number) {
    const ctx = this.ctx2d
    ctx.clearRect(0, 0, this.w, this.h)
    if (!v) return
    for (const h of v.heroes) {
      if (!h.a) continue
      const [sx, sy] = this.toScreen(h.x, h.y, 215 + h.h * 0.8)
      this.text(h.n, sx, sy - 12, this.colors[h.s] ?? '#fff', 13)
      // thanh máu (xanh lá) + mana (xanh dương) như unit WC3
      const bw = 46
      ctx.fillStyle = '#000'
      ctx.fillRect(sx - bw / 2 - 1, sy - 2, bw + 2, 8)
      ctx.fillStyle = '#18d018'
      ctx.fillRect(sx - bw / 2, sy - 1, bw, 3)
      ctx.fillStyle = '#2a5cff'
      ctx.fillRect(sx - bw / 2, sy + 3, (bw * h.mp) / Math.max(1, h.mmp), 2)
    }
    for (const d of v.dragons ?? []) {
      if (d[5] >= 100 && !d[4]) continue
      const sc = d[4] ? BIG_DRAGON_SCALE : DRAGON_SCALE
      const [sx, sy] = this.toScreen(d[1], d[2], 210 * sc)
      if (sx < -50 || sy < -50 || sx > this.w + 50 || sy > this.h + 50) continue
      if (d[4]) this.text('Rồng Đại Ca', sx, sy - 12, '#ffd34d', 14)
      if (d[5] < 100) {
        ctx.fillStyle = 'rgba(0,0,0,0.75)'
        ctx.fillRect(sx - 26, sy, 52, 6)
        ctx.fillStyle = '#e8261c'
        ctx.fillRect(sx - 25, sy + 1, (50 * d[5]) / 100, 4)
      }
    }
    for (const [slot, x, y] of v.markers ?? []) {
      const [sx, sy] = this.toScreen(x, y, 120)
      this.text('Cứu!', sx, sy, this.colors[slot] ?? '#fff', 15)
    }
    for (const [corner, left] of v.thaws ?? []) {
      const [cx, cy] = this.info.cornerPos(corner)
      const [sx, sy] = this.toScreen(cx, cy, 10)
      this.text(Math.ceil(left).toString(), sx, sy, '#ffe9c2', 16)
    }
    for (const e of this.effects) {
      const p = (now - e.start) / e.dur
      if (e.kind === 'float') {
        const [sx, sy] = this.toScreen(e.x, e.y, 120 + p * 120)
        ctx.globalAlpha = 1 - p
        this.text(e.text!, sx, sy, e.color!, 18)
        ctx.globalAlpha = 1
      } else if (e.kind === 'burst') {
        for (let i = 0; i < 14; i++) {
          const a = (i / 14) * Math.PI * 2
          const [sx, sy] = this.toScreen(e.x + Math.cos(a) * p * 120, e.y + Math.sin(a) * p * 120, 40 + p * 60)
          ctx.fillStyle = hexA(e.color!, 1 - p)
          ctx.beginPath()
          ctx.arc(sx, sy, 5 * (1 - p) + 1.5, 0, Math.PI * 2)
          ctx.fill()
        }
      } else if (e.kind === 'swarm') {
        const ang = Math.atan2(e.ty! - e.y, e.tx! - e.x)
        ctx.font = '22px system-ui'
        ctx.textAlign = 'center'
        ctx.textBaseline = 'middle'
        for (let i = 0; i < 16; i++) {
          const along = p * 800 + (i % 4) * 25
          if (along > 800) continue
          const half = 50 + (100 * along) / 800
          const off = ((i * 37) % 21) / 10 - 1
          const wx = e.x + Math.cos(ang) * along - Math.sin(ang) * half * off
          const wy = e.y + Math.sin(ang) * along + Math.cos(ang) * half * off
          const [bx, by] = this.toScreen(wx, wy, 80)
          ctx.fillText('🦇', bx, by)
        }
      }
    }
  }

  private text(t: string, x: number, y: number, color: string, size: number) {
    const ctx = this.ctx2d
    ctx.font = `bold ${size}px 'Philosopher', system-ui, sans-serif`
    ctx.textAlign = 'center'
    ctx.textBaseline = 'middle'
    ctx.lineWidth = 3
    ctx.strokeStyle = 'rgba(0,0,0,0.85)'
    ctx.strokeText(t, x, y)
    ctx.fillStyle = color
    ctx.fillText(t, x, y)
  }
}

function lerp(a: number, b: number, k: number) {
  return a + (b - a) * k
}
function lerpAngle(a: number, b: number, k: number) {
  const d = ((b - a + 540) % 360) - 180
  return a + d * k
}
function hexA(hex: string, a: number) {
  const n = parseInt(hex.slice(1), 16)
  return `rgba(${(n >> 16) & 255},${(n >> 8) & 255},${n & 255},${Math.max(0, a)})`
}

function smooth01(x: number) {
  const t = Math.max(0, Math.min(1, x))
  return t * t * (3 - 2 * t)
}
function hash1(n: number) {
  const x = Math.sin(n * 127.1 + 311.7) * 43758.5453
  return x - Math.floor(x)
}
