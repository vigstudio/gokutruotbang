<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { clock, isHost, loadMap, minimapDragons, mySlot, onGameEvent, onSnapshot, send, sendInput, setMapBounds, store } from '../net'
import { Predictor } from '../game/predict'
import { Renderer3D } from '../game3d/renderer3d'
import { MapInfo, renderMinimap } from '../game/terrain'
import { bakePortrait, loadBlpCanvas, type Portrait } from '../game/models'
import { glyphUrl, iconUrl } from '../game/icons'
import type { AbilityDef, GameEvent } from '../types'
import { getQuality, type Quality } from '../game3d/quality'
import InventoryBar from './InventoryBar.vue'
import MobileControls from './MobileControls.vue'
import SoundButton from './SoundButton.vue'
import { music, setVolume } from '../audio/music'
import ShopPanel from './ShopPanel.vue'
import { catalog, itemDef, loadCatalog, shopNear } from '../game/items'
import { itemIconUrl } from '../game/icons'

const canvas = ref<HTMLCanvasElement>()
const overlay = ref<HTMLCanvasElement>()
const mini = ref<HTMLCanvasElement>()
const portraitCv = ref<HTMLCanvasElement>()
const loadBg = ref<HTMLCanvasElement>()
const chatInput = ref<HTMLInputElement>()
const chatOpen = ref(false)
const chatText = ref('')
const loading = ref(true)
const loadStep = ref('Đang đọc bản đồ…')
const loadPct = ref(5)
const banners = ref<{ id: number; text: string; until: number }[]>([])
const toast = ref('')
const targetKey = ref('')
const learnMode = ref(false)
const hover = ref<string>('')
const menuOpen = ref(false)
const logOpen = ref(false)
const helpOpen = ref(false)
const goFlash = ref(false)
const fps = ref(0)
// ---------------------------------------------------------------- điện thoại
const isMobile = ref(
  new URLSearchParams(location.search).has('mobile') || (matchMedia('(pointer: coarse)').matches && Math.min(innerWidth, innerHeight) < 900),
)
const portraitMode = ref(false)
const boardOpen = ref(!isMobile.value)
function checkOrientation() {
  portraitMode.value = isMobile.value && innerHeight > innerWidth
}
async function goFullscreen() {
  try {
    await document.documentElement.requestFullscreen?.({ navigationUI: 'hide' })
    await (screen.orientation as any)?.lock?.('landscape')
  } catch {
    /* trình duyệt không cho: bỏ qua */
  }
}
let lastMoveAt = 0
let lastMoveAng = 999
/** Cần gạt: gửi lệnh đi/đổi hướng tới điểm cách Goku 300 theo hướng gạt (giới hạn tần suất). */
function mobMove(nx: number, ny: number) {
  if (!pred?.alive) return
  const ang = (Math.atan2(-ny, nx) * 180) / Math.PI
  const now = performance.now()
  const dAng = Math.abs(((ang - lastMoveAng + 540) % 360) - 180)
  if (now - lastMoveAt < 90 || (dAng < 6 && now - lastMoveAt < 350)) return
  lastMoveAt = now
  lastMoveAng = ang
  const l = Math.hypot(nx, ny) || 1
  const x = pred.x + (nx / l) * 300
  const y = pred.y - (ny / l) * 300
  pred.order(x, y)
  pred.lastSent = sendInput({ t: 'order', x, y })
}
function mobMoveEnd() {
  lastMoveAng = 999
  if (pred && !pred.onIce) stopHero()
}
function heroXY(): [number, number] {
  return pred?.alive ? [pred.x, pred.y] : [me.value?.x ?? 0, me.value?.y ?? 0]
}
function mobCast(key: string) {
  const a = store.abilities.find((q) => q.key === key)
  if (!a) return
  const h = me.value
  const ok = !!h && h.a && (h.ab[key] ?? 0) > 0 && !h.cd[key] && h.mp >= manaCost(a)
  if (a.target !== 'point' || !ok) return useAbility(a)
  // chạm nhanh kỹ năng chọn điểm: tung về phía trước
  const [hx, hy] = heroXY()
  const f = ((pred?.f ?? h!.f) * Math.PI) / 180
  const d = a.range * 0.75
  castAt(key, hx + Math.cos(f) * d, hy + Math.sin(f) * d)
}
function mobAim(key: string, nx: number, ny: number) {
  const a = store.abilities.find((q) => q.key === key)
  if (!a || !r) return
  const [hx, hy] = heroXY()
  r.targeting = { key, range: a.range, x: 0, y: 0 }
  if (Math.hypot(nx, ny) < 0.15) {
    const f = ((pred?.f ?? 0) * Math.PI) / 180
    r.mouseWorld = [hx + Math.cos(f) * a.range * 0.75, hy + Math.sin(f) * a.range * 0.75]
  } else {
    r.mouseWorld = [hx + nx * a.range, hy - ny * a.range]
  }
}
function mobAimEnd(key: string, fire: boolean) {
  if (r && fire) castAt(key, r.mouseWorld[0], r.mouseWorld[1])
  if (r) r.targeting = null
}
function mobLearn(key: string) {
  const a = store.abilities.find((q) => q.key === key)
  if (a) learn(a)
}
const frameMs = ref(0)
const quality = ref<Quality>(getQuality())
const QUALITY_NAME: Record<Quality, string> = { high: 'Cao', medium: 'Vừa', low: 'Thấp' }
function setGfx(q: Quality) {
  quality.value = q
  r?.applyQuality(q)
}
function cycleQuality() {
  setGfx(quality.value === 'high' ? 'medium' : quality.value === 'medium' ? 'low' : 'high')
  banners.value.push({ id: ++bannerId, text: 'Đồ hoạ: ' + QUALITY_NAME[quality.value], until: Date.now() + 2500 })
}
const faceUrl = ref('')
const followCam = ref(true)

let r: Renderer3D | null = null
let miniImg: HTMLCanvasElement | null = null
let portrait: Portrait | null = null
let info: MapInfo | null = null
let raf = 0
let offEvent: (() => void) | null = null
let offSnap: (() => void) | null = null
let pred: Predictor | null = null
const keysDown = new Set<string>()
let bannerId = 0
const MINI = 176

const snap = computed(() => store.hud)
const me = computed(() => snap.value?.heroes?.find((h) => h.s === mySlot()) ?? null)
const ranking = computed(() => [...(snap.value?.heroes ?? [])].sort((a, b) => b.sc - a.sc || b.lv - a.lv))
const phase = computed(() => snap.value?.phase ?? 'playing')
// ---------------------------------------------------------------- cửa hàng / vật phẩm
const shopOpen = ref(false)
const wishOpen = ref(false)
const nearShop = computed(() => {
  const h = me.value
  return !!h && h.a && !!catalog.value && !!shopNear(h.x, h.y)
})
watch(nearShop, (v) => {
  if (!v) shopOpen.value = false
})
function toggleShop() {
  if (shopOpen.value) shopOpen.value = false
  else if (nearShop.value) shopOpen.value = true
  else showToast('Hãy tới gần quán Krusty Krab (biểu tượng túi tiền trên bản đồ nhỏ)')
}
function useItem(idx: number) {
  const s = me.value?.inv?.[idx]
  if (!s?.i) return
  if (!itemDef(s.i)?.use) return showToast('Vật phẩm này có tác dụng khi để trong túi')
  sendInput({ t: 'use', x: idx })
}
function sellItem(idx: number) {
  sendInput({ t: 'sell', x: idx })
}
function makeWish(id: string) {
  sendInput({ t: 'wish', ab: id })
  wishOpen.value = false
}
const mapName = ref('Goku Trượt Băng')
const mapDesc = ref('')

function resize() {
  /* Renderer3D tự theo dõi kích thước canvas */
}

// Lỗi khi tải trận hoặc mất context WebGL: tự tải lại trang (máy chủ giữ chỗ
// 60 giây nên sẽ vào lại đúng trận), tối đa 3 lần trong 2 phút để tránh lặp.
const loadFailed = ref(false)
function recover(reason: unknown) {
  console.error('[goku] lỗi, tải lại trang:', reason)
  let tries: number[] = []
  try {
    tries = JSON.parse(sessionStorage.getItem('goku.reloads') ?? '[]').filter((t: number) => Date.now() - t < 120000)
  } catch {
    /* bỏ qua */
  }
  if (tries.length >= 3) {
    loadFailed.value = true
    loadStep.value = 'Không tải được trò chơi. Hãy kiểm tra mạng rồi bấm Tải lại.'
    return
  }
  tries.push(Date.now())
  try {
    sessionStorage.setItem('goku.reloads', JSON.stringify(tries))
  } catch {
    /* bỏ qua */
  }
  loadStep.value = 'Gặp lỗi khi tải, đang thử lại…'
  setTimeout(() => location.reload(), 1200)
}
function reloadPage() {
  try {
    sessionStorage.removeItem('goku.reloads')
  } catch {
    /* bỏ qua */
  }
  location.reload()
}

onMounted(() => {
  boot().catch(recover)
})

async function boot() {
  loadBlpCanvas('war3mapMap.blp')
    .then((img) => loadBg.value?.getContext('2d')!.drawImage(img, 0, 0, 256, 256))
    .catch(() => {})
  const m = await loadMap()
  mapName.value = m.name.replace(/\s*v?\d+(\.\d+)+\s*$/i, '').replace(/^Goku truot bang$/i, 'Goku Trượt Băng')
  mapDesc.value = m.description
  loadStep.value = 'Đang dựng địa hình 3D…'
  loadPct.value = 25
  await new Promise((res) => setTimeout(res, 30))
  info = new MapInfo(m)
  setMapBounds(m.bounds)
  await nextTick()
  r = new Renderer3D(canvas.value!, overlay.value!, info)
  r.colors = store.colors
  r.mySlot = mySlot()
  pred = new Predictor(info)
  r.pred = pred
  r.onQualityDrop = (q) => {
    quality.value = q
    banners.value.push({ id: ++bannerId, text: 'FPS thấp — tự giảm đồ hoạ xuống mức ' + QUALITY_NAME[q], until: Date.now() + 4000 })
  }
  r.onNotice = (text) => {
    banners.value.push({ id: ++bannerId, text, until: Date.now() + 5000 })
    if (banners.value.length > 3) banners.value.shift()
  }
  ;(window as any).__goku = { pred, clock, renderer: r } // hỗ trợ gỡ lỗi từ console
  loadStep.value = 'Đang dựng model Goku và rồng…'
  loadPct.value = 60
  await new Promise((res) => setTimeout(res, 30))
  canvas.value!.addEventListener('webglcontextlost', (e) => {
    e.preventDefault()
    recover('WebGL context lost')
  })
  await r.init()
  await loadCatalog().catch((e) => console.warn('không tải được danh mục vật phẩm', e))
  r.shops = catalog.value?.shops ?? []
  miniImg = renderMinimap(info, MINI, r.terrain)
  portrait = await bakePortrait('war3mapImported/zMidouz.mdx', 'Stand - 1').catch(() => null)
  if (portrait) {
    const c = document.createElement('canvas')
    c.width = 48
    c.height = 48
    c.getContext('2d')!.drawImage(portrait.canvas, 0, 10, portrait.w, portrait.w, 0, 0, 48, 48)
    faceUrl.value = c.toDataURL()
  }
  loadPct.value = 100
  loadStep.value = 'Sẵn sàng!'
  await new Promise((res) => setTimeout(res, 250))
  loading.value = false
  send({ t: 'ready' })
  offSnap = onSnapshot((sn) => {
    const h = sn.heroes?.find((x) => x.s === mySlot())
    if (!pred || !h) return
    pred.thawedCorners = new Set((sn.thaws ?? []).map((t) => t[0]))
    pred.reconcile(h, sn.tick, sn.phase === 'playing')
  })
  offEvent = onGameEvent(handleEvent)
  window.addEventListener('resize', resize)
  window.addEventListener('resize', checkOrientation)
  checkOrientation()
  if (isMobile.value) setFollow(true)
  window.addEventListener('keydown', onKey)
  window.addEventListener('keyup', onKeyUp)
  let renderErr = false
  let lastMini = 0
  let lastPortrait = 0
  let lastFps = 0
  let lastCam = 0
  const loop = (t: number) => {
    raf = requestAnimationFrame(loop)
    if (!r) return
    panCamera()
    r.mySlot = mySlot()
    stepPrediction(t)
    // lỗi ở một khung hình không được làm đứng cả màn hình
    try {
      r.render(t)
    } catch (e) {
      if (!renderErr) console.error(e)
      renderErr = true
    }
    // minimap + chân dung không cần vẽ mỗi khung hình
    if (t - lastMini > 100) {
      lastMini = t
      drawMini()
    }
    if (t - lastPortrait > 50) {
      lastPortrait = t
      drawPortrait(t)
    }
    if (t - lastCam > 200) {
      lastCam = t
      reportCamera()
    }
    if (t - lastFps > 500) {
      lastFps = t
      if (fps.value !== r.fpsNow) fps.value = r.fpsNow
      frameMs.value = Math.round(r.frameMs * 10) / 10
    }
    const now = Date.now()
    if (banners.value.length && banners.value[0].until < now) banners.value = banners.value.filter((b) => b.until > now)
  }
  raf = requestAnimationFrame(loop)
}

onBeforeUnmount(() => {
  cancelAnimationFrame(raf)
  offEvent?.()
  offSnap?.()
  window.removeEventListener('resize', resize)
  window.removeEventListener('keydown', onKey)
  window.removeEventListener('keyup', onKeyUp)
})

function handleEvent(e: GameEvent) {
  r?.onEvent(e, performance.now())
  if (e.kind === 'go') {
    goFlash.value = true
    setTimeout(() => (goFlash.value = false), 1200)
  }
  if (e.kind === 'msg' || e.kind === 'round') {
    banners.value.push({ id: ++bannerId, text: e.text ?? '', until: Date.now() + Math.min(e.dur ?? 6, 8) * 1000 })
    if (banners.value.length > 3) banners.value.shift()
  }
  if (e.kind === 'error' && e.slot === mySlot()) showToast(e.text ?? '')
  if ((e.kind === 'item' || e.kind === 'pickup') && e.slot === mySlot()) showToast(e.text ?? '')
  if (e.kind === 'ball' || e.kind === 'wish') {
    banners.value.push({ id: ++bannerId, text: e.text ?? '', until: Date.now() + 5000 })
    if (banners.value.length > 3) banners.value.shift()
  }
}

// Mô phỏng Goku của mình tới tick mà server sẽ nhận được lệnh gửi lúc này.
// Báo server vùng camera đang nhìn để server chỉ gửi rồng trong vùng đó.
let camSent = { x: 1e9, y: 1e9, r: 0 }
function reportCamera() {
  if (!r || store.hud?.phase === 'loading') return
  const w = innerWidth
  const h = innerHeight
  const cx = r.camX
  const cy = r.camY
  let rad = 0
  for (const [sx, sy] of [[0, 0], [w, 0], [0, h], [w, h]]) {
    const [x, y] = r.toWorld(sx, sy)
    rad = Math.max(rad, Math.abs(x - cx), Math.abs(y - cy))
  }
  rad = Math.round(rad + 450) // dư ra để rồng không "hiện ra" ở mép màn hình
  if (Math.abs(cx - camSent.x) < 120 && Math.abs(cy - camSent.y) < 120 && Math.abs(rad - camSent.r) < camSent.r * 0.15) return
  camSent = { x: cx, y: cy, r: rad }
  send({ t: 'cam', x: Math.round(cx), y: Math.round(cy), c: rad })
}

let lead = 1
function stepPrediction(t: number) {
  if (!pred?.ready || store.hud?.phase !== 'playing') return
  // độ "đi trước" so với server đổi theo ping; làm mượt để không nhảy cóc
  const want = clock.rtt / 2 / 20 + 1
  lead = Math.abs(want - lead) > 5 ? want : lead + Math.max(-0.01, Math.min(0.01, want - lead))
  const tf = clock.serverTick(t) + lead
  const target = Math.floor(tf)
  if (Math.abs(target - pred.tick) > 30) pred.tick = target
  let n = 0
  while (pred.tick < target && n++ < 10) pred.stepTick()
  // vẽ nội suy giữa tick trước và tick hiện tại theo phần lẻ thời gian
  pred.alpha = pred.tick === target ? tf - target : 1
}

function showToast(t: string) {
  toast.value = t
  setTimeout(() => (toast.value = toast.value === t ? '' : toast.value), 1600)
}

// ------------------------------------------------------------ input
function worldFromEvent(ev: MouseEvent): [number, number] {
  const rect = overlay.value!.getBoundingClientRect()
  return r!.toWorld(ev.clientX - rect.left, ev.clientY - rect.top)
}
function onMouseMove(ev: MouseEvent) {
  if (r) r.mouseWorld = worldFromEvent(ev)
}
function onMouseDown(ev: MouseEvent) {
  if (!r) return
  menuOpen.value = false
  const [x, y] = worldFromEvent(ev)
  if (targetKey.value) {
    if (ev.button === 0) castAt(targetKey.value, x, y)
    cancelTarget()
    return
  }
  pred?.order(x, y)
  if (pred) pred.lastSent = sendInput({ t: 'order', x, y })
  else sendInput({ t: 'order', x, y })
  r.effects.push({ kind: 'click', x, y, start: performance.now(), dur: 400 })
}
function onWheel(ev: WheelEvent) {
  if (!r) return
  r.zoom = Math.max(0.25, Math.min(1.4, r.zoom * (ev.deltaY > 0 ? 0.9 : 1.1)))
}
function cancelTarget() {
  targetKey.value = ''
  if (r) r.targeting = null
}

function useAbility(a: AbilityDef) {
  if (learnMode.value) return learn(a)
  const h = me.value
  if (!h || !h.a) return
  if (!(h.ab[a.key] > 0)) return showToast('Chưa học kỹ năng này')
  if (h.cd[a.key]) return showToast('Kỹ năng chưa hồi xong')
  if (h.mp < manaCost(a)) return showToast('Không đủ mana')
  if (a.target === 'point') {
    targetKey.value = a.key
    r!.targeting = { key: a.key, range: a.range, x: 0, y: 0 }
  } else {
    castAt(a.key, 0, 0)
  }
}
function castAt(key: string, x: number, y: number) {
  const a = store.abilities.find((q) => q.key === key)
  if (pred && a?.target === 'point') pred.f = ((Math.atan2(y - pred.y, x - pred.x) * 180) / Math.PI + 360) % 360
  const s = sendInput({ t: 'cast', ab: key, x, y })
  if (pred) pred.lastSent = s
}
function stopHero() {
  pred?.stop()
  const s = sendInput({ t: 'stop' })
  if (pred) pred.lastSent = s
}
function learn(a: AbilityDef) {
  if (!canLearn(a)) return showToast('Chưa thể học thêm')
  sendInput({ t: 'learn', ab: a.key })
  if ((me.value?.sp ?? 0) <= 1) learnMode.value = false
}

function onKey(ev: KeyboardEvent) {
  if (chatOpen.value) {
    if (ev.key === 'Escape') closeChat()
    return
  }
  if (ev.key === 'Enter') {
    chatOpen.value = true
    nextTick(() => chatInput.value?.focus())
    ev.preventDefault()
    return
  }
  if (ev.key === 'F1') {
    helpOpen.value = !helpOpen.value
    ev.preventDefault()
    return
  }
  if (ev.key === 'F10') {
    menuOpen.value = !menuOpen.value
    ev.preventDefault()
    return
  }
  const k = ev.key.toUpperCase()
  if (k.startsWith('ARROW')) {
    keysDown.add(k)
    setFollow(false)
    ev.preventDefault()
    return
  }
  if (ev.key === 'Escape') {
    learnMode.value = false
    menuOpen.value = false
    if (shopOpen.value || wishOpen.value) {
      shopOpen.value = wishOpen.value = false
      return
    }
    return cancelTarget()
  }
  if (ev.key === ' ') {
    setFollow(true)
    ev.preventDefault()
    return
  }
  if (ev.ctrlKey || ev.altKey || ev.metaKey) return
  if (k === 'O' && (me.value?.sp ?? 0) > 0) {
    learnMode.value = !learnMode.value
    return
  }
  if (k === 'S' && !learnMode.value) return stopHero()
  if (k === 'B') return toggleShop()
  if (/^[1-6]$/.test(ev.key)) return useItem(Number(ev.key) - 1)
  const a = store.abilities.find((x) => x.key === k)
  if (!a) return
  ev.preventDefault()
  if (ev.shiftKey || learnMode.value) learn(a)
  else useAbility(a)
}
function setFollow(v: boolean) {
  followCam.value = v
  if (r) r.follow = v
}
function zoomBy(f: number) {
  if (r) r.zoom = Math.max(0.25, Math.min(1.4, r.zoom * f))
}
/** Quạt hồi chiêu kiểu WC3 (conic-gradient). */
function cdSweep(a: AbilityDef) {
  const pct = cdPct(a)
  if (pct <= 0) return {}
  const deg = (pct / 100) * 360
  return { background: `conic-gradient(from 0deg, transparent ${360 - deg}deg, rgba(0,0,0,0.72) ${360 - deg}deg)` }
}
const statusChips = computed(() => {
  const h = me.value
  if (!h) return []
  if (!h.a) return [{ t: 'Đã ngã', c: 'dead' }]
  const out: { t: string; c: string }[] = []
  out.push(h.h > 1 ? { t: 'Đang bay', c: 'fly' } : h.ice ? { t: 'Đang trượt', c: 'ice' } : { t: 'Đi bộ', c: 'walk' })
  if (h.ww) out.push({ t: 'Tàng hình', c: 'ww' })
  if (h.dr) out.push({ t: 'Tăng tốc', c: 'dr' })
  return out
})

function onKeyUp(ev: KeyboardEvent) {
  keysDown.delete(ev.key.toUpperCase())
}
function panCamera() {
  if (!r || keysDown.size === 0) return
  const s = 18 / r.zoom
  if (keysDown.has('ARROWLEFT')) r.camX -= s
  if (keysDown.has('ARROWRIGHT')) r.camX += s
  if (keysDown.has('ARROWUP')) r.camY += s
  if (keysDown.has('ARROWDOWN')) r.camY -= s
}
function sendChat() {
  if (chatText.value.trim()) send({ t: 'chat', text: chatText.value })
  closeChat()
}
function closeChat() {
  chatText.value = ''
  chatOpen.value = false
  chatInput.value?.blur()
}

// ------------------------------------------------------------ minimap & chân dung
function drawMini() {
  const cv = mini.value
  if (!cv || !miniImg || !info || !r) return
  const ctx = cv.getContext('2d')!
  const b = info.m.bounds
  const sx = MINI / (b.maxX - b.minX)
  const sy = MINI / (b.maxY - b.minY)
  const px = (x: number) => (x - b.minX) * sx
  const py = (y: number) => (b.maxY - y) * sy
  ctx.drawImage(miniImg, 0, 0)
  const v = r.lastView
  if (v) {
    // hộp quà (xanh băng) + quán Krusty Krab (túi vàng)
    ctx.fillStyle = '#7fd8ff'
    for (const [, x, y] of v.boxes ?? []) ctx.fillRect(px(x) - 2, py(y) - 2, 4, 4)
    for (const [x, y] of catalog.value?.shops ?? []) {
      ctx.beginPath()
      ctx.arc(px(x), py(y), 5, 0, Math.PI * 2)
      ctx.fillStyle = '#f0c040'
      ctx.fill()
      ctx.lineWidth = 1.5
      ctx.strokeStyle = '#000'
      ctx.stroke()
      ctx.fillStyle = '#5a3a08'
      ctx.font = 'bold 8px sans-serif'
      ctx.textAlign = 'center'
      ctx.textBaseline = 'middle'
      ctx.fillText('$', px(x), py(y) + 0.5)
    }
    ctx.fillStyle = '#ff2020'
    // toàn bộ rồng (gói thưa từ server); chưa có thì dùng rồng trong tầm nhìn
    const all = minimapDragons.list.length ? minimapDragons.list : (v.dragons ?? []).map((d) => [d[1], d[2], d[4]] as [number, number, number])
    for (const [x, y, big] of all) ctx.fillRect(px(x) - 1.5, py(y) - 1.5, big ? 5 : 3, big ? 5 : 3)
    for (const [slot, x, y] of v.markers ?? []) {
      ctx.strokeStyle = store.colors[slot]
      ctx.lineWidth = 2
      ctx.strokeRect(px(x) - 3, py(y) - 3, 6, 6)
    }
    for (const h of v.heroes) {
      if (!h.a) continue
      ctx.fillStyle = store.colors[h.s]
      ctx.fillRect(px(h.x) - 3, py(h.y) - 3, 6, 6)
      ctx.strokeStyle = h.s === mySlot() ? '#fff' : '#000'
      ctx.lineWidth = 1
      ctx.strokeRect(px(h.x) - 3.5, py(h.y) - 3.5, 7, 7)
    }
  }
  const [x0, y0] = r.toWorld(0, 0)
  const [x1, y1] = r.toWorld(window.innerWidth, window.innerHeight)
  ctx.strokeStyle = 'rgba(255,255,255,0.9)'
  ctx.lineWidth = 1
  ctx.strokeRect(px(x0), py(y0), px(x1) - px(x0), py(y1) - py(y0))
}
function onMiniClick(ev: MouseEvent) {
  if (!info || !r) return
  const rect = mini.value!.getBoundingClientRect()
  const b = info.m.bounds
  const wx = b.minX + ((ev.clientX - rect.left) / rect.width) * (b.maxX - b.minX)
  const wy = b.maxY - ((ev.clientY - rect.top) / rect.height) * (b.maxY - b.minY)
  if (ev.button === 2) {
    pred?.order(wx, wy)
    const s = sendInput({ t: 'order', x: wx, y: wy })
    if (pred) pred.lastSent = s
    return
  }
  r.camX = wx
  r.camY = wy
  setFollow(false)
}
function drawPortrait(t: number) {
  const cv = portraitCv.value
  if (!cv) return
  const ctx = cv.getContext('2d')!
  ctx.clearRect(0, 0, cv.width, cv.height)
  if (!portrait) return
  const f = Math.floor(((t % portrait.ms) / portrait.ms) * portrait.frames)
  ctx.filter = me.value && !me.value.a ? 'grayscale(1) brightness(0.5)' : 'none'
  ctx.drawImage(portrait.canvas, f * portrait.w, 0, portrait.w, portrait.h, 0, 0, cv.width, cv.height)
  ctx.filter = 'none'
}

// ------------------------------------------------------------ HUD
function abilityLevel(a: AbilityDef) {
  return me.value?.ab[a.key] ?? 0
}
function canLearn(a: AbilityDef) {
  const h = me.value
  if (!h || h.sp <= 0) return false
  const next = abilityLevel(a) + 1
  return next <= a.maxLevel && h.lv >= 2 * next - 1
}
function manaCost(a: AbilityDef) {
  return a.mana[Math.max(0, abilityLevel(a) - 1)]
}
function cdPct(a: AbilityDef) {
  const h = me.value
  const lv = abilityLevel(a)
  if (!h || !h.cd[a.key] || lv === 0) return 0
  return (h.cd[a.key] / a.cooldown[lv - 1]) * 100
}
const xpPct = computed(() => {
  const h = me.value
  if (!h || h.xp1 <= h.xp0) return 100
  return ((h.xp - h.xp0) / (h.xp1 - h.xp0)) * 100
})

const tip = computed(() => {
  const k = hover.value
  if (!k) return null
  if (k === 'S') return { title: 'Dừng lại', hot: 'S', body: 'Dừng đi bộ. Trên băng Goku vẫn tiếp tục trượt.' }
  if (k === 'O') return { title: 'Học kỹ năng anh hùng', hot: 'O', body: `Còn ${me.value?.sp ?? 0} điểm kỹ năng chưa dùng.` }
  if (k === 'X') return { title: 'Hủy', hot: 'Esc', body: '' }
  const a = store.abilities.find((x) => x.key === k)
  if (!a) return null
  const lv = abilityLevel(a)
  const show = learnMode.value ? Math.min(lv + 1, a.maxLevel) : Math.max(lv, 1)
  return {
    title: learnMode.value ? `Học ${a.name} - [Cấp ${show}]` : `${a.name}${lv ? ` - [Cấp ${lv}]` : ''}`,
    hot: a.key,
    body: a.desc.replace(/\s*\(.*?\)\s*$/, ''),
    mana: a.mana[show - 1],
    cd: a.cooldown[show - 1],
    req: learnMode.value ? `Yêu cầu anh hùng cấp ${2 * show - 1}` : '',
  }
})
const chatLines = computed(() => store.chat.slice(logOpen.value ? -24 : -7))
const dragonCount = computed(() => (snap.value, minimapDragons.list.length || (snap.value?.dragons?.length ?? 0)))
</script>

<template>
  <div class="game" :class="{ mobile: isMobile }" @contextmenu.prevent>
    <canvas ref="canvas" class="gl" />
    <canvas
      ref="overlay"
      class="ov"
      :class="{ targeting: !!targetKey }"
      @mousedown="onMouseDown"
      @mousemove="onMouseMove"
      @wheel.passive="onWheel"
    />

    <!-- màn hình tải kiểu WC3 -->
    <div v-if="loading" class="loading">
      <canvas ref="loadBg" class="load-bg" width="256" height="256"></canvas>
      <div class="load-box wc-frame">
        <div class="load-title gold title-font">{{ mapName }}</div>
        <div class="load-desc">{{ mapDesc || 'Goku trượt băng – giải trí' }}</div>
        <div class="load-tip"><span class="gold">Mẹo:</span> trên băng, nhấp chuột chỉ đổi hướng. Đứng trên đá hoa ở các góc để nghỉ an toàn.</div>
      </div>
      <div class="load-bar-wrap">
        <div class="load-step gold title-font">{{ loadStep }}</div>
        <button v-if="loadFailed" class="tft-btn small" style="width: auto; margin: 10px auto 0" @click="reloadPage">Tải lại</button>
        <div class="load-bar wc-inset"><div :style="{ width: loadPct + '%' }"></div></div>
      </div>
    </div>

    <div v-if="!loading && phase === 'loading'" class="waiting wc-frame">
      <div class="gold title-font">Đang chờ những người chơi khác tải xong…</div>
    </div>

    <div v-if="phase === 'countdown' && snap?.count" :key="Math.ceil(snap.count)" class="countdown">{{ Math.ceil(snap.count) }}</div>
    <div v-if="goFlash" class="countdown go">BẮT ĐẦU!</div>

    <!-- thanh trên cùng -->
    <div class="topbar">
      <div class="top-left">
        <button class="top-btn" @click="menuOpen = !menuOpen">Menu <kbd>F10</kbd></button>
        <button class="top-btn" :class="{ on: logOpen }" @click="logOpen = !logOpen">Nhật ký</button>
        <button class="top-btn" :class="{ on: helpOpen }" @click="helpOpen = !helpOpen">Trợ giúp <kbd>F1</kbd></button>
        <button v-if="isMobile" class="top-btn mob-only" :class="{ on: boardOpen }" @click="boardOpen = !boardOpen">Bảng điểm</button>
        <button v-if="isMobile" class="top-btn mob-only" title="Toàn màn hình" @click="goFullscreen">⛶</button>
        <SoundButton class="top-sound" />
      </div>
      <div v-if="snap" class="round-plate">
        <span class="gold">Vòng {{ Math.min(snap.round, snap.final) }}</span><span class="muted">/{{ snap.final }}</span>
      </div>
      <div v-if="snap" class="top-right">
        <span class="res" title="Vàng"><img class="ri" :src="glyphUrl('GOLD')" alt="" />{{ me?.g ?? 0 }}</span>
        <span class="res" title="Điểm"><img class="ri" :src="glyphUrl('SCORE')" alt="" />{{ me?.sc ?? 0 }}</span>
        <span class="res" title="Số rồng trên bản đồ"><img class="ri" :src="glyphUrl('DRAGON')" alt="" />{{ dragonCount }}</span>
        <span class="res ping" :class="{ bad: store.ping > 150 }" title="Độ trễ tới máy chủ"><img class="ri" :src="glyphUrl('PING')" alt="" />{{ store.ping }} ms</span>
        <button class="fps" :class="fps >= 50 ? 'ok' : fps >= 30 ? 'mid' : 'bad'" :title="'Khung hình/giây · vẽ ' + frameMs + ' ms/khung · đồ hoạ ' + QUALITY_NAME[quality] + ' (bấm để đổi)'" @click="cycleQuality">
          <b>{{ fps }}</b> FPS<span class="qtag">{{ QUALITY_NAME[quality] }}</span>
        </button>
      </div>
    </div>

    <div v-if="menuOpen" class="modal-back" @mousedown.self="menuOpen = false">
      <div class="iron snowy menu-dlg">
        <h2>Menu</h2>
        <button class="tft-btn" @click="menuOpen = false">Trở lại trò chơi</button>
        <button class="tft-btn" @click="((helpOpen = true), (menuOpen = false))">Hướng dẫn</button>
        <div class="gfx">
          <span class="wc-label">Nhạc nền <span class="muted">· {{ music.muted ? 'tắt' : Math.round(music.volume * 100) + '%' }}</span></span>
          <input class="vol" type="range" min="0" max="1" step="0.05" :value="music.muted ? 0 : music.volume" @input="setVolume(Number(($event.target as HTMLInputElement).value))" />
        </div>
        <div class="gfx">
          <span class="wc-label">Đồ hoạ <span class="muted">· {{ fps }} FPS</span></span>
          <div class="gfx-row">
            <button v-for="q in (['high', 'medium', 'low'] as const)" :key="q" class="tft-btn small" :class="{ on: quality === q }" @click="setGfx(q)">{{ QUALITY_NAME[q] }}</button>
          </div>
        </div>
        <button class="tft-btn" @click="send({ t: 'leave' })">Rời trò chơi</button>
      </div>
    </div>

    <div v-if="helpOpen" class="modal-back" @mousedown.self="helpOpen = false">
      <div class="iron snowy help-dlg">
        <h2>Hướng dẫn</h2>
        <div class="help-grid">
          <kbd>Chuột phải / trái</kbd><span>Trên băng: đổi hướng trượt · Trên đá: đi tới</span>
          <kbd>Q W E R A</kbd><span>Dùng kỹ năng (E, A cần chọn điểm)</span>
          <kbd>Bấm +</kbd><span>Học kỹ năng khi có điểm (hoặc Shift + phím)</span>
          <kbd>S</kbd><span>Dừng đi bộ</span>
          <kbd>B</kbd><span>Mở cửa hàng Krusty Krab (đứng gần quán)</span>
          <kbd>1 – 6</kbd><span>Dùng vật phẩm trong túi</span>
          <kbd>Space</kbd><span>Camera bám theo Goku</span>
          <kbd>Mũi tên</kbd><span>Di chuyển camera tự do</span>
          <kbd>Lăn chuột</kbd><span>Phóng to / thu nhỏ</span>
          <kbd>Enter</kbd><span>Chat · chủ phòng gõ <code>-kick p2</code></span>
        </div>
        <p class="help-note">Chạm rồng là ngã. Đồng đội chạm vào vòng sáng nơi bạn ngã để hồi sinh. Về đích ở tâm bản đồ để qua vòng, vượt 4 vòng là thắng.</p>
        <button class="tft-btn" @click="helpOpen = false">Đã hiểu</button>
      </div>
    </div>

    <!-- bảng điểm -->
    <div v-if="snap && boardOpen" class="board">
      <div class="board-title">Map by vietnghiavnn</div>
      <div class="board-row board-head"><span></span><span>Người chơi</span><span>Cấp</span><span>Điểm</span></div>
      <div v-for="h in ranking" :key="h.s" class="board-row" :class="{ dead: !h.a, mine: h.s === mySlot() }">
        <span class="bface" :style="{ borderColor: store.colors[h.s] }"><img v-if="faceUrl" :src="faceUrl" alt="" /></span>
        <span class="bname">{{ h.n }}<span v-if="!h.a" class="bdead"> · ngã</span></span>
        <span class="blv">{{ h.lv }}</span>
        <span class="bsc">{{ h.sc }}</span>
      </div>
    </div>

    <div class="banners">
      <div v-for="b in banners" :key="b.id" class="banner">{{ b.text }}</div>
    </div>
    <div v-if="me && !me.a && phase === 'playing'" class="dead-note">Bạn đã ngã! Chờ đồng đội chạm vào vòng sáng để hồi sinh…</div>
    <div v-if="toast" class="toast">{{ toast }}</div>
    <div v-if="targetKey" class="hint">Chọn mục tiêu — <b>chuột trái</b> để dùng, <b>chuột phải</b> hoặc Esc để hủy</div>

    <div class="chat" :class="{ log: logOpen }">
      <div v-for="(l, i) in chatLines" :key="i" class="line">
        <template v-if="l.slot >= 0">
          <b :style="{ color: store.colors[l.slot] }">{{ l.name }}:</b> {{ l.text }}
        </template>
        <span v-else class="sys">{{ l.text }}</span>
      </div>
      <div v-if="chatOpen" class="chat-input-wrap">
        <span class="gold">Gửi tất cả:</span>
        <input ref="chatInput" v-model="chatText" class="tft-input chat-input" maxlength="200" @keydown.enter.prevent="sendChat" />
      </div>
    </div>

    <!-- tooltip -->
    <div v-if="tip" class="tooltip">
      <div class="tip-title">{{ tip.title }} <span class="tip-hot">({{ tip.hot }})</span></div>
      <div v-if="tip.mana" class="tip-cost"><i class="manaorb"></i>{{ tip.mana }} mana <span class="muted">· hồi {{ tip.cd }} giây</span></div>
      <div v-if="tip.req" class="tip-req">{{ tip.req }}</div>
      <div v-if="tip.body" class="tip-body">{{ tip.body }}</div>
    </div>

    <!-- HUD phía dưới -->
    <div class="hud">
      <div class="mini-frame">
        <canvas ref="mini" :width="MINI" :height="MINI" @mousedown="onMiniClick" />
      </div>

      <div class="console">
      <div class="hero-plate">
        <div class="portrait"><canvas ref="portraitCv" width="120" height="140"></canvas></div>
        <div v-if="me" class="hero-info">
          <div class="hero-top">
            <span class="hero-name gold">{{ me.n }}</span>
            <span class="hero-lv">Cấp {{ me.lv }}</span>
          </div>
          <div class="bar xp" :title="`${me.xp} / ${me.xp1} kinh nghiệm`">
            <div :style="{ width: xpPct + '%' }"></div>
            <span>{{ me.xp }} / {{ me.xp1 }} KN</span>
          </div>
          <div class="bar mp">
            <div :style="{ width: (me.mp / me.mmp) * 100 + '%' }"></div>
            <span>{{ me.mp }} / {{ me.mmp }} mana</span>
          </div>
          <div class="state-line">
            <span v-for="c in statusChips" :key="c.t" class="st" :class="c.c">{{ c.t }}</span>
          </div>
          <div v-if="me.sp > 0" class="sp-line">+{{ me.sp }} điểm kỹ năng — bấm vòng <b>+</b> phía trên kỹ năng</div>
        </div>
      </div>

      <div class="divider"></div>
      <div class="skill-plate">
        <div class="skills">
          <div
            v-for="a in store.abilities"
            :key="a.key"
            class="skill"
            :class="{
              learnable: canLearn(a),
              off: abilityLevel(a) === 0,
              nomana: abilityLevel(a) > 0 && !!me && me.mp < manaCost(a),
              active: targetKey === a.key,
              ready: abilityLevel(a) > 0 && !me?.cd[a.key] && !!me && me.mp >= manaCost(a),
            }"
            @click="abilityLevel(a) === 0 && canLearn(a) ? learn(a) : useAbility(a)"
            @mouseenter="hover = a.key"
            @mouseleave="hover = ''"
          >
            <img :src="iconUrl(a.key)" alt="" draggable="false" />
            <div class="sweep" :style="cdSweep(a)"></div>
            <span class="hk">{{ a.key }}</span>
            <span v-if="me?.cd[a.key]" class="cdt">{{ Math.ceil(me.cd[a.key]) }}</span>
            <span v-if="abilityLevel(a) > 0" class="cost">{{ manaCost(a) }}</span>
            <span v-if="abilityLevel(a) > 0" class="lvtag">{{ abilityLevel(a) }}/{{ a.maxLevel }}</span>
            <button v-if="canLearn(a)" class="learn" :title="abilityLevel(a) ? 'Nâng cấp kỹ năng' : 'Học kỹ năng'" @click.stop="learn(a)" @mouseenter="((learnMode = true), (hover = a.key))" @mouseleave="learnMode = false">+</button>
          </div>
        </div>
        <div class="utils">
          <button class="cmdbtn" title="Dừng đi bộ (S)" @click="stopHero()"><img :src="iconUrl('S')" alt="" /><span class="ck">S</span></button>
          <button class="cmdbtn" :class="{ on: followCam }" title="Camera bám theo Goku (Space)" @click="setFollow(!followCam)"><img :src="iconUrl('CAM')" alt="" /><span class="ck">␣</span></button>
          <button class="cmdbtn" title="Phóng to" @click="zoomBy(1.15)"><img :src="iconUrl('ZOOM')" alt="" /><span class="pm">+</span></button>
          <button class="cmdbtn" title="Thu nhỏ" @click="zoomBy(0.87)"><img :src="iconUrl('ZOOM')" alt="" /><span class="pm">−</span></button>
          <button class="cmdbtn" :class="{ on: shopOpen, near: nearShop && !shopOpen }" title="Cửa hàng Krusty Krab (B) - đứng gần quán" @click="toggleShop()"><img :src="itemIconUrl('SHOP', 'legend')" alt="" /><span class="ck">B</span></button>
        </div>
      </div>
      <div class="divider"></div>
      <InventoryBar :hero="me" :shop-open="shopOpen" @use="useItem" @sell="sellItem" @wish="wishOpen = true" />
      </div>
      <button v-if="nearShop && !shopOpen" class="shop-hint" @click="shopOpen = true"><img :src="itemIconUrl('SHOP', 'legend')" alt="" />Krusty Krab — bấm <kbd>B</kbd> để mua đồ</button>
    </div>

    <MobileControls
      v-if="isMobile && me"
      :hero="me"
      :abilities="store.abilities"
      :near-shop="nearShop"
      @move="mobMove"
      @move-end="mobMoveEnd"
      @cast="mobCast"
      @aim="mobAim"
      @aim-end="mobAimEnd"
      @learn="mobLearn"
      @use="useItem"
      @shop="toggleShop"
      @stop="stopHero"
    />
    <div v-if="isMobile && me" class="mob-hero">
      <img v-if="faceUrl" :src="faceUrl" alt="" />
      <div class="mh-info">
        <div class="mh-top"><b>{{ me.n }}</b><span>Cấp {{ me.lv }}</span></div>
        <div class="mh-bar xp"><i :style="{ width: Math.min(100, ((me.xp - me.xp0) / Math.max(1, me.xp1 - me.xp0)) * 100) + '%' }"></i></div>
        <div class="mh-bar mp"><i :style="{ width: (me.mp / Math.max(1, me.mmp)) * 100 + '%' }"></i><span>{{ me.mp }}/{{ me.mmp }}</span></div>
      </div>
    </div>
    <div v-if="portraitMode" class="rotate-hint">
      <div class="rot-ico">📱</div>
      <p>Xoay ngang điện thoại để chơi</p>
      <button class="tft-btn small" @click="goFullscreen">Toàn màn hình</button>
    </div>
    <ShopPanel v-if="shopOpen" :hero="me" @close="shopOpen = false" />
    <div v-if="wishOpen" class="modal-back" @mousedown.self="wishOpen = false">
      <div class="iron snowy wish-dlg">
        <h2>Rồng Thần xuất hiện!</h2>
        <p class="muted">Hãy nói điều ước của ngươi. 7 viên Ngọc Rồng sẽ bay đi sau khi ước.</p>
        <button v-for="w in catalog?.wishes ?? []" :key="w.id" class="tft-btn wish-btn" @click="makeWish(w.id)">
          {{ w.name }}<small>{{ w.desc }}</small>
        </button>
      </div>
    </div>

    <!-- kết thúc -->
    <div v-if="phase === 'victory' || phase === 'defeat'" class="end">
      <div class="end-box wc-frame">
        <h1 class="title-font" :class="phase">{{ phase === 'victory' ? 'Chiến thắng!' : 'Thất bại!' }}</h1>
        <p>{{ phase === 'victory' ? 'WIN!!! Bạn giỏi thật!!!' : 'Tất cả Goku đã bị rồng hạ gục.' }}</p>
        <div class="wc-inset end-rank">
          <div v-for="(h, i) in ranking" :key="h.s" class="wc-row">
            <span>{{ i + 1 }}.</span>
            <span :style="{ color: store.colors[h.s] }">{{ h.n }}</span>
            <span>Cấp {{ h.lv }}</span>
            <span class="gold">{{ h.sc }} điểm</span>
          </div>
        </div>
        <div class="end-actions">
          <button v-if="isHost()" class="wc-btn" @click="send({ t: 'lobby' })">Về phòng chờ</button>
          <span v-else class="muted">Đợi chủ phòng…</span>
          <button class="wc-btn" @click="send({ t: 'leave' })">Thoát</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.game { position: fixed; inset: 0; user-select: none; background: #000; }
canvas { display: block; }
.gl, .ov { position: absolute; inset: 0; width: 100%; height: 100%; }
.ov.targeting { cursor: crosshair; }
.muted { color: var(--muted); }

/* ---------------- màn hình tải */
.loading { position: absolute; inset: 0; z-index: 50; background: #000; display: flex; flex-direction: column; justify-content: space-between; padding: 6vh 6vw 7vh; overflow: hidden; }
.load-bg { position: absolute; inset: -40px; width: calc(100% + 80px); height: calc(100% + 80px); filter: blur(10px) brightness(0.45) saturate(1.2); }
.load-box { position: relative; max-width: 560px; }
.load-title { font-size: 34px; font-weight: 700; }
.load-desc { margin-top: 6px; font-size: 16px; }
.load-tip { margin-top: 14px; font-size: 14px; color: #cfc6b0; }
.load-bar-wrap { position: relative; width: min(640px, 90%); margin: 0 auto; text-align: center; }
.load-step { font-size: 18px; margin-bottom: 8px; }
.load-bar { height: 22px; padding: 3px; }
.load-bar > div { height: 100%; background: linear-gradient(180deg, #7dd8ff, #1f7ad0 55%, #0d3c78); box-shadow: 0 0 10px rgba(80, 180, 255, 0.6); transition: width 0.4s; }
.waiting { position: absolute; z-index: 20; top: 40%; left: 50%; transform: translate(-50%, -50%); font-size: 20px; }

/* ---------------- thanh trên */
.topbar {
  position: absolute; top: 0; left: 0; right: 0; height: 38px;
  display: flex; justify-content: space-between; align-items: center; padding: 0 10px;
  background: var(--metal-noise), var(--metal-grain), linear-gradient(180deg, #3a3e46, #1b1d22 70%, #101114);
  box-shadow: inset 0 -1px 0 #5d636d, inset 0 -3px 0 #0a0b0d, 0 4px 10px rgba(0, 0, 0, 0.75);
  z-index: 5;
}
.top-left { display: flex; gap: 6px; }
.top-btn {
  font-family: var(--title); font-size: 14px; color: var(--btn-text); padding: 4px 12px; border: none;
  background: var(--metal-noise), radial-gradient(ellipse at 50% 30%, #2a2e97, #0c0d44);
  box-shadow: inset 0 0 0 1px #000, inset 0 0 0 2px #8f9bb0, 0 0 0 1px #000;
  text-shadow: 0 1px 1px #000;
}
.top-btn kbd { font-size: 11px; padding: 0 4px; margin-left: 4px; }
.top-btn:hover, .top-btn.on { filter: brightness(1.35); }
.round-plate {
  position: absolute; left: 50%; top: 0; transform: translateX(-50%);
  padding: 6px 26px 8px; font-family: var(--title); font-size: 18px; font-weight: 700;
  background: var(--metal-noise), linear-gradient(180deg, #3a3e46, #1a1c21);
  box-shadow: inset 0 0 0 1px #000, inset 0 0 0 2px #6b717c, 0 4px 8px rgba(0, 0, 0, 0.8);
  clip-path: polygon(0 0, 100% 0, 92% 100%, 8% 100%);
}
.top-right { display: flex; gap: 18px; align-items: center; font-size: 15px; color: #fff; text-shadow: 0 1px 0 #000; }
.res { display: flex; align-items: center; gap: 5px; }
.coin { width: 14px; height: 14px; border-radius: 50%; background: radial-gradient(circle at 35% 35%, #fff5b0, #f2c540 45%, #8a5a10); box-shadow: 0 0 0 1px #000; }
.star { color: var(--gold); font-style: normal; }
.drg { width: 14px; height: 14px; border-radius: 50%; background: radial-gradient(circle at 35% 35%, #ffb8a0, #c0301a 50%, #4a0a05); box-shadow: 0 0 0 1px #000; }
.ping { font-size: 13px; color: #8fe08f; }
.ping.bad { color: #ff8a5a; }

.top-sound { margin-left: 2px; }
.vol { width: 100%; accent-color: #c9a24d; }
.fps {
  display: flex; align-items: baseline; gap: 4px; padding: 2px 8px; font: 600 12px var(--body); color: var(--muted);
  background: rgba(0, 0, 0, 0.35); border: 1px solid rgba(255, 255, 255, 0.08); cursor: pointer;
}
.fps:hover { border-color: var(--line-dim); }
.fps b { font-size: 14px; min-width: 20px; text-align: right; }
.fps.ok b { color: #8fe08f; }
.fps.mid b { color: #f0c860; }
.fps.bad b { color: #ff6a50; }
.qtag { margin-left: 4px; padding-left: 6px; border-left: 1px solid rgba(255, 255, 255, 0.12); font-weight: 500; }
.gfx-row { display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px; }
.gfx-row .on { border-color: #f0d080; color: #fff7d6; background: linear-gradient(180deg, #3a4f80, #1f2d52); }

.shop-hint {
  position: absolute; left: 50%; bottom: 236px; transform: translateX(-50%); display: flex; align-items: center; gap: 8px; z-index: 6;
  padding: 5px 14px 5px 6px; font: 600 14px var(--body); color: var(--btn-text); cursor: pointer;
  background: rgba(10, 12, 17, 0.88); border: 1px solid var(--line); box-shadow: 0 0 0 1px #000, 0 0 16px rgba(240, 200, 96, 0.35);
  animation: hintpulse 1.4s ease-in-out infinite alternate;
}
.shop-hint img { width: 26px; height: 26px; box-shadow: 0 0 0 1px #000; }
@keyframes hintpulse { to { box-shadow: 0 0 0 1px #000, 0 0 22px rgba(240, 200, 96, 0.6); } }
.cmdbtn.near { box-shadow: 0 0 0 1px #000, 0 0 0 2px #f0c860, 0 0 10px rgba(240, 200, 96, 0.6) !important; }
.wish-dlg { width: 380px; display: grid; gap: 10px; }
.wish-dlg p { margin: 0 0 4px; }
.wish-btn { text-align: left; display: flex; flex-direction: column; }
.wish-btn small { font: 400 12px var(--body); color: var(--muted); }

/* ---------------- điện thoại (kiểu Liên Quân) */
.mob-only { font-size: 12px !important; }
.mobile .console, .mobile .shop-hint, .mobile .tooltip { display: none !important; }
.mobile .hud { padding: 0 !important; }
.mobile .mini-frame { position: fixed !important; left: calc(6px + env(safe-area-inset-left)); top: 42px; bottom: auto !important; padding: 3px !important; }
.mobile .mini-frame canvas { width: 104px !important; height: 104px !important; }
.mobile .topbar { height: 34px !important; }
.mobile .top-btn kbd { display: none; }
.mobile .top-left .top-btn:nth-child(2), .mobile .top-left .top-btn:nth-child(3) { display: none !important; }
.mobile .round-plate { font-size: 14px !important; padding: 3px 14px !important; }
.mobile .top-right { gap: 10px !important; font-size: 12px !important; }
.mobile .board { top: 40px; width: 220px; transform: scale(0.9); transform-origin: top right; }
.mobile .banner { font-size: 16px !important; }
.mob-hero {
  position: absolute; top: 42px; left: calc(118px + env(safe-area-inset-left)); display: flex; gap: 7px; align-items: center; z-index: 7;
  padding: 4px 8px 4px 4px; background: rgba(8, 10, 14, 0.7); border: 1px solid var(--line-dim); pointer-events: none;
}
.mob-hero img { width: 36px; height: 36px; box-shadow: 0 0 0 1px #000, 0 0 0 2px var(--line); }
.mh-info { width: 140px; display: grid; gap: 3px; }
.mh-top { display: flex; justify-content: space-between; font: 600 12px var(--body); color: var(--muted); }
.mh-top b { color: var(--gold); font-family: var(--title); font-size: 13px; }
.mh-bar { position: relative; height: 8px; background: #05070a; box-shadow: 0 0 0 1px #000; }
.mh-bar i { position: absolute; inset: 0 auto 0 0; display: block; }
.mh-bar.xp i { background: linear-gradient(180deg, #c48aff, #6a2aa8); }
.mh-bar.mp { height: 11px; }
.mh-bar.mp i { background: linear-gradient(180deg, #6a9aff, #1f3aa8); }
.mh-bar span { position: absolute; inset: 0; font: 700 9px/11px var(--body); color: #fff; text-align: center; text-shadow: 0 0 2px #000; }
.rotate-hint {
  position: fixed; inset: 0; z-index: 100; display: grid; place-content: center; justify-items: center; gap: 12px; text-align: center;
  background: rgba(3, 6, 11, 0.94); color: var(--text); font: 600 16px var(--body);
}
.rotate-hint .tft-btn { width: auto; }
.rot-ico { font-size: 54px; animation: rot 1.8s ease-in-out infinite; }
@keyframes rot { 50% { transform: rotate(-90deg); } }

/* ---------------- hộp thoại */
.menu-dlg { width: 320px; display: grid; gap: 14px; padding: 22px 26px; }
.menu-dlg h2, .help-dlg h2 { text-align: center; }
.help-dlg { width: min(560px, 94vw); padding: 22px 26px; }
.help-grid { display: grid; grid-template-columns: auto 1fr; gap: 8px 14px; align-items: center; margin-bottom: 12px; }
.help-grid kbd { justify-self: start; font-size: 13px; padding: 1px 8px; }
.help-note { color: #d6d1c2; line-height: 1.45; margin: 0 0 16px; }

/* ---------------- bảng điểm */
.board { position: absolute; top: 48px; right: 10px; min-width: 250px; padding: 12px 24px 14px; font-size: 14px; background-color: rgba(28, 30, 36, 0.88); }
.board-title { color: var(--gold); text-align: center; font-family: var(--title); font-weight: 700; border-bottom: 1px solid #4b515c; margin-bottom: 4px; padding-bottom: 3px; text-shadow: 0 1px 0 #000; }
.board-row { display: flex; gap: 8px; padding: 2px 4px; text-shadow: 0 1px 1px #000; }
.board-row.mine { background: rgba(60, 255, 60, 0.07); }
.board-row.dead { opacity: 0.5; }
.bname { flex: 1; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; font-weight: 700; }
.blv { width: 38px; text-align: right; color: #c8ccd4; }
.bsc { width: 34px; text-align: right; color: #fff; font-weight: 700; }
.board-row .bname { text-shadow: 0 1px 0 #000, 0 0 3px #000, 1px 1px 1px #000; }

/* ---------------- đếm ngược */
.countdown {
  position: absolute; top: 30%; left: 50%; transform: translate(-50%, -50%); z-index: 15; pointer-events: none;
  font-family: var(--title); font-weight: 700; font-size: 140px; line-height: 1;
  background: linear-gradient(180deg, #fff6c0 0%, #ffd34a 40%, #c27410 70%, #ffdf70 100%);
  -webkit-background-clip: text; background-clip: text; color: transparent;
  -webkit-text-stroke: 2px #2a1203;
  filter: drop-shadow(0 4px 0 #000) drop-shadow(0 0 18px rgba(255, 190, 60, 0.6));
  animation: cdpop 1s ease-out;
}
.countdown.go { font-size: 96px; animation: cdgo 1.2s ease-out forwards; }
@keyframes cdpop { 0% { transform: translate(-50%, -50%) scale(1.8); opacity: 0; } 25% { opacity: 1; } 100% { transform: translate(-50%, -50%) scale(1); opacity: 0.9; } }
@keyframes cdgo { 0% { transform: translate(-50%, -50%) scale(0.6); opacity: 0; } 20% { transform: translate(-50%, -50%) scale(1.1); opacity: 1; } 100% { transform: translate(-50%, -50%) scale(1.3); opacity: 0; } }

/* ---------------- thông báo */
.banners { position: absolute; top: 76px; left: 50%; transform: translateX(-50%); width: min(90vw, 820px); text-align: center; pointer-events: none; }
.banner { margin-bottom: 6px; font-family: var(--title); font-size: 24px; font-weight: 700; color: var(--gold); text-shadow: 0 2px 0 #000, 0 0 4px #000, 0 0 12px #000; animation: pop 0.3s ease-out; }
@keyframes pop { from { transform: scale(1.3); opacity: 0; } }
.dead-note { position: absolute; top: 34%; left: 50%; transform: translateX(-50%); font-family: var(--title); font-size: 22px; color: #ffb4a0; text-shadow: 0 2px 0 #000, 0 0 8px #000; pointer-events: none; }
.toast { position: absolute; bottom: 210px; left: 50%; transform: translateX(-50%); color: var(--gold); font-weight: 700; font-size: 17px; text-shadow: 0 1px 0 #000, 0 0 4px #000; }
.hint { position: absolute; bottom: 210px; left: 50%; transform: translateX(-50%); color: #e9e2c8; text-shadow: 0 1px 2px #000; }
.hint b { color: var(--gold); }

.chat { position: absolute; left: 12px; bottom: 214px; width: min(520px, 60vw); font-size: 15px; pointer-events: none; }
.chat.log { background: rgba(0, 0, 0, 0.6); padding: 6px 8px; }
.chat .line { text-shadow: 0 1px 1px #000, 0 0 3px #000; padding: 1px 0; color: #fff; }
.chat .sys { color: var(--gold); }
.chat-input-wrap { display: flex; gap: 6px; align-items: center; pointer-events: auto; margin-top: 4px; text-shadow: 0 1px 0 #000; }
.chat-input { flex: 1; padding: 4px 8px; }

/* ---------------- tooltip kiểu WC3 */
.tooltip {
  position: absolute; right: 12px; bottom: 206px; width: 330px; padding: 9px 12px;
  background: rgba(0, 0, 0, 0.9); box-shadow: inset 0 0 0 1px #000, inset 0 0 0 2px #6b717c, 0 0 0 1px #000;
  font-size: 14px; pointer-events: none; z-index: 6;
}
.tip-title { color: var(--gold); font-weight: 700; }
.tip-hot { color: var(--gold); }
.tip-cost { color: #fff; margin-top: 3px; display: flex; align-items: center; gap: 5px; }
.manaorb { width: 12px; height: 12px; border-radius: 50%; background: radial-gradient(circle at 35% 35%, #cfe3ff, #2d6cff 55%, #0a1d55); box-shadow: 0 0 0 1px #000; }
.tip-req { color: #ff6060; margin-top: 3px; }
.tip-body { color: #fff; margin-top: 5px; line-height: 1.4; }

/* ---------------- HUD dưới */
.hud { position: absolute; left: 0; right: 0; bottom: 0; display: flex; align-items: flex-end; justify-content: center; gap: 8px; padding: 0 8px 8px; pointer-events: none; }
.hud > * { pointer-events: auto; }
.mini-frame { padding: 9px; position: absolute; left: 8px; bottom: 8px; }
.mini-frame canvas { width: 176px; height: 176px; display: block; cursor: pointer; box-shadow: 0 0 0 1px #000, 0 0 0 2px #4b515c; }

.hero-plate { display: flex; gap: 12px; padding: 12px 16px 12px 12px; width: 400px; }
.portrait { width: 104px; height: 120px; flex: none; background: radial-gradient(ellipse at 50% 30%, #3d6a90, #06101c 75%); box-shadow: inset 0 0 0 1px #000, 0 0 0 2px #4b515c, 0 0 0 3px #000; overflow: hidden; }
.portrait canvas { width: 104px; height: 120px; }
.hero-info { flex: 1; min-width: 0; display: flex; flex-direction: column; gap: 6px; }
.hero-top { display: flex; justify-content: space-between; align-items: baseline; }
.hero-name { font-family: var(--title); font-size: 21px; font-weight: 700; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.hero-lv { color: #fff; font-family: var(--title); text-shadow: 0 1px 1px #000; }
.bar { position: relative; height: 16px; background: #06070a; box-shadow: inset 0 0 0 1px #000, 0 0 0 1px #4b515c; font-size: 12px; }
.bar > div { height: 100%; transition: width 0.2s; }
.bar.xp > div { background: linear-gradient(#c38bff, #6a24b8 60%, #3d1270); }
.bar.mp > div { background: linear-gradient(#78a4ff, #2546c8 60%, #10236e); }
.bar span { position: absolute; inset: 0; text-align: center; line-height: 16px; color: #fff; text-shadow: 0 1px 0 #000; }
.state-line { display: flex; gap: 12px; font-size: 14px; margin-top: 2px; text-shadow: 0 1px 1px #000; }
.st { color: #e6e2d6; }
.st.ice { color: #9fd8ff; }
.st.walk { color: #e2d3b0; }
.st.fly { color: #ffc070; }
.st.ww { color: #c8b8ff; }
.st.dr { color: #8ff0ff; }
.st.dead { color: #ff8a70; }
.sp-line { font-size: 13px; color: var(--gold); text-shadow: 0 1px 1px #000; }
.sp-line b { color: #fff; }
.chips { display: flex; flex-wrap: wrap; gap: 5px; margin-top: 2px; }
.chip { font-size: 12px; padding: 1px 8px; color: #fff; text-shadow: 0 1px 0 #000; box-shadow: inset 0 0 0 1px rgba(255, 255, 255, 0.25), 0 0 0 1px #000; }
.chip.ice { background: linear-gradient(#5fb8f0, #1e6aa8); }
.chip.walk { background: linear-gradient(#a99a80, #6a5a40); }
.chip.fly { background: linear-gradient(#ffb060, #c06010); }
.chip.ww { background: linear-gradient(#a890ff, #5a3ec0); }
.chip.dr { background: linear-gradient(#7ff0ff, #1aa0b8); }
.chip.dead { background: linear-gradient(#ff6a50, #8a1a10); }
.chip.sp { background: linear-gradient(#7dff7d, #1f9a1f); color: #052005; text-shadow: none; font-weight: 700; animation: glowg 1.2s infinite; }
@keyframes glowg { 50% { filter: brightness(1.3); } }

.skill-plate { padding: 12px 14px 10px; }
.skills { display: flex; gap: 8px; }
.skill { position: relative; width: 64px; height: 64px; cursor: pointer; background: #000; box-shadow: 0 0 0 1px #000, 0 0 0 3px #5d636d, 0 0 0 4px #000; }
.skill img { position: absolute; inset: 0; width: 64px; height: 64px; }
.skill::after { content: ''; position: absolute; inset: 0; pointer-events: none; box-shadow: inset 2px 2px 0 rgba(255, 255, 255, 0.25), inset -2px -2px 0 rgba(0, 0, 0, 0.6); }
.skill:hover img { filter: brightness(1.25); }
.skill:active img { transform: translate(1px, 1px); }
.skill.off img { filter: grayscale(1) brightness(0.4); }
.skill.nomana img { filter: brightness(0.5) sepia(1) hue-rotate(190deg) saturate(3); }
.skill.active { box-shadow: 0 0 0 1px #000, 0 0 0 3px #3cff3c, 0 0 12px #3cff3c; }
.skill.ready { box-shadow: 0 0 0 1px #000, 0 0 0 3px #8f9bb0, 0 0 0 4px #000; }
.sweep { position: absolute; inset: 0; pointer-events: none; }
.hk { position: absolute; top: 1px; left: 4px; font-family: var(--title); font-weight: 700; font-size: 14px; color: var(--gold); text-shadow: 0 1px 0 #000, 1px 1px 0 #000, 0 0 2px #000; }
.cdt { position: absolute; inset: 0; display: grid; place-items: center; font-size: 22px; font-weight: 700; color: #fff; text-shadow: 0 1px 2px #000, 0 0 4px #000; }
.cost { position: absolute; bottom: 1px; right: 3px; font-size: 11px; color: #9fc0ff; text-shadow: 0 1px 0 #000, 0 0 2px #000; }
.pips { position: absolute; bottom: -9px; left: 0; right: 0; display: flex; justify-content: center; gap: 3px; }
.pips i { width: 7px; height: 7px; transform: rotate(45deg); background: #1a1b20; box-shadow: 0 0 0 1px #000; }
.pips i.on { background: linear-gradient(135deg, #fff6c0, #f2c540); }
.skills { padding-top: 30px; }
/* nút nâng cấp kiểu Liên Quân: vòng tròn "+" phía trên icon, toả sáng lấp lánh */
.learn {
  position: absolute; top: -36px; left: 50%; width: 28px; height: 28px; margin-left: -14px; padding: 0; border: none; border-radius: 50%;
  font-family: var(--body); font-size: 22px; font-weight: 700; line-height: 26px; color: #fff; text-shadow: 0 1px 2px rgba(80, 40, 0, 0.9);
  background: radial-gradient(circle at 35% 30%, #fff6c4 0%, #ffcf3a 45%, #c9820c 100%);
  box-shadow: 0 0 0 2px #5a3a06, 0 0 0 3px rgba(255, 230, 140, 0.8), 0 0 14px 3px rgba(255, 196, 60, 0.85);
  cursor: pointer; z-index: 2; animation: learnbob 1.2s ease-in-out infinite;
}
.learn::before {
  content: ''; position: absolute; inset: -6px; border-radius: 50%; border: 2px solid rgba(255, 214, 90, 0.9);
  animation: learnring 1.2s ease-out infinite; pointer-events: none;
}
.learn::after {
  content: ''; position: absolute; inset: -10px; pointer-events: none;
  background:
    radial-gradient(circle, #fff 0 1.5px, transparent 2.5px) 2px 6px / 8px 8px no-repeat,
    radial-gradient(circle, #fff 0 1.2px, transparent 2px) 34px 2px / 8px 8px no-repeat,
    radial-gradient(circle, #fff6c0 0 1.5px, transparent 2.5px) 36px 32px / 8px 8px no-repeat,
    radial-gradient(circle, #fff 0 1px, transparent 2px) 0 30px / 8px 8px no-repeat;
  animation: twinkle 0.9s steps(2) infinite, spin 4s linear infinite;
}
.learn:hover { filter: brightness(1.15); transform: scale(1.08); }
@keyframes learnbob { 50% { transform: translateY(-3px); } }
@keyframes learnring { from { transform: scale(0.8); opacity: 1; } to { transform: scale(1.6); opacity: 0; } }
@keyframes twinkle { 50% { opacity: 0.2; } }
@keyframes spin { to { transform: rotate(360deg); } }
.skill.learnable { box-shadow: 0 0 0 1px #000, 0 0 0 3px #e6b53a, 0 0 0 4px #000, 0 0 10px rgba(255, 200, 60, 0.55); animation: learnpulse 1.4s infinite; }
@keyframes learnpulse { 50% { box-shadow: 0 0 0 1px #000, 0 0 0 3px #ffd970, 0 0 0 4px #000, 0 0 16px rgba(255, 210, 80, 0.85); } }
.utils { display: flex; gap: 6px; margin-top: 16px; }
.cmdbtn { position: relative; width: 38px; height: 38px; padding: 0; border: none; background: #000; cursor: pointer; box-shadow: 0 0 0 1px #000, 0 0 0 2px #5d636d, 0 0 0 3px #000; }
.cmdbtn img { width: 38px; height: 38px; display: block; }
.cmdbtn:hover img { filter: brightness(1.25); }
.cmdbtn:active img { transform: translate(1px, 1px); }
.cmdbtn.on { box-shadow: 0 0 0 1px #000, 0 0 0 2px #3cff3c, 0 0 0 3px #000; }
.ck { position: absolute; top: 0; left: 3px; font-family: var(--title); font-size: 11px; font-weight: 700; color: var(--gold); text-shadow: 0 1px 0 #000, 1px 1px 0 #000; }
.pm { position: absolute; right: 2px; bottom: -2px; font-size: 18px; font-weight: 700; color: #fff; text-shadow: 0 1px 0 #000, 0 0 3px #000; }
.util {
  display: flex; align-items: center; gap: 5px; padding: 3px 10px; border: none; font-size: 13px; color: var(--btn-text);
  background: var(--metal-noise), radial-gradient(ellipse at 50% 30%, #2a2e97, #0c0d44);
  box-shadow: inset 0 0 0 1px #000, inset 0 0 0 2px #8f9bb0, 0 0 0 1px #000; text-shadow: 0 1px 1px #000;
}
.util img { width: 16px; height: 16px; }
.util:hover { filter: brightness(1.3); }
.util.on { box-shadow: inset 0 0 0 1px #000, inset 0 0 0 2px #3cff3c, 0 0 0 1px #000; }

/* ---------------- kết thúc */
.end { position: absolute; inset: 0; z-index: 40; display: grid; place-items: center; background: rgba(0, 0, 0, 0.55); }
.end-box { padding: 24px 32px; text-align: center; min-width: 380px; }
.end-box h1 { margin: 0 0 4px; font-size: 44px; font-family: var(--title); }
.end-box h1.victory { color: var(--gold); text-shadow: 0 2px 0 #000, 0 0 16px rgba(252, 211, 18, 0.5); }
.end-box h1.defeat { color: #ff4b3a; text-shadow: 0 2px 0 #000; }
.end-rank { margin: 14px 0; text-align: left; }
.end-rank .wc-row { display: grid; grid-template-columns: 26px 1fr 70px 80px; }
.end-actions { display: flex; gap: 10px; justify-content: center; align-items: center; }
.end-actions .wc-btn { width: auto; }

/* chừa chỗ cho bản đồ nhỏ ở góc trái để thanh điều khiển không đè lên */
.hud { padding-left: 214px !important; }
@media (max-width: 1400px) {
  .hud { padding-left: 8px !important; gap: 8px !important; }
  .mini-frame { position: static; }
  .mini-frame canvas { width: 150px; height: 150px; }
}
@media (max-width: 1100px) {
  .mini-frame { position: static; }
  .mini-frame canvas { width: 130px; height: 130px; }
  .hero-plate { width: 330px; }
  .skill, .skill img { width: 52px; height: 52px; }
}

/* ================= HUD v3 (tiết chế, thống nhất) ================= */
.topbar {
  background: linear-gradient(180deg, rgba(20, 24, 32, 0.96), rgba(10, 12, 17, 0.96)) !important;
  box-shadow: inset 0 -1px 0 var(--line), 0 2px 10px rgba(0, 0, 0, 0.6) !important;
  height: 36px !important;
}
.top-btn {
  font-family: var(--body) !important; font-size: 13px !important; font-weight: 600; color: var(--btn-text) !important;
  background: transparent !important; box-shadow: none !important; border: 1px solid transparent !important; padding: 4px 10px !important;
}
.top-btn:hover, .top-btn.on { border-color: var(--line-dim) !important; background: rgba(201, 162, 77, 0.08) !important; filter: none !important; }
.round-plate {
  clip-path: none !important; padding: 5px 22px !important; top: 4px !important;
  font-size: 17px !important; background: rgba(10, 12, 17, 0.85) !important;
  border: 1px solid var(--line); box-shadow: 0 0 0 1px #000 !important;
}
.top-right { font-family: var(--body); font-size: 14px !important; font-weight: 600; gap: 16px !important; }

.board {
  position: absolute; top: 46px; right: 10px; width: 250px; padding: 0 0 4px !important; font-size: 13px;
  background: rgba(8, 10, 14, 0.82) !important; border: 1px solid var(--line); box-shadow: 0 0 0 1px #000, 0 8px 20px rgba(0, 0, 0, 0.5);
}
.board-title { font-family: var(--title); font-size: 15px; color: var(--gold); text-align: center; padding: 6px 0 5px; margin: 0 !important; border-bottom: 1px solid var(--line-dim); }
.board-row { display: grid !important; grid-template-columns: 26px 1fr 34px 40px; gap: 8px !important; align-items: center; padding: 4px 12px !important; }
.board-row:nth-child(odd):not(.board-head) { background: rgba(255, 255, 255, 0.03); }
.board-head { color: var(--muted); font-size: 11px; text-transform: uppercase; letter-spacing: 0.06em; border-bottom: 1px solid rgba(255, 255, 255, 0.06); }
.board-head span:nth-child(n + 3), .blv, .bsc { text-align: right; }
.bname { color: #fff; font-weight: 600; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; }
.bdead { color: #ff8a70; font-weight: 400; }
.blv { color: var(--muted); width: auto !important; }
.bsc { color: var(--gold); font-weight: 700; width: auto !important; }
.board-row.mine { background: rgba(201, 162, 77, 0.12) !important; }

.hud { gap: 0 !important; }
.console {
  display: flex; align-items: stretch;
  background: var(--panel); border: 1px solid var(--line);
  box-shadow: 0 0 0 1px #000, inset 0 1px 0 rgba(255, 255, 255, 0.06), 0 -6px 24px rgba(0, 0, 0, 0.5);
}
.divider { width: 1px; background: linear-gradient(180deg, transparent, var(--line), transparent); margin: 10px 0; }
.hero-plate { width: 380px !important; padding: 12px 16px 12px 12px !important; }
.skill-plate { padding: 6px 14px 10px !important; }
.mini-frame {
  padding: 4px !important; background: rgba(8, 10, 14, 0.9); border: 1px solid var(--line);
  box-shadow: 0 0 0 1px #000, 0 6px 18px rgba(0, 0, 0, 0.5);
}
.mini-frame canvas { box-shadow: none !important; }
.portrait { box-shadow: 0 0 0 1px var(--line), 0 0 0 2px #000 !important; }
.hero-name { font-size: 19px !important; }
.hero-lv { font-family: var(--body) !important; font-size: 13px; color: var(--muted) !important; }
.bar { height: 14px !important; box-shadow: 0 0 0 1px #000, 0 0 0 2px rgba(255, 255, 255, 0.08) !important; }
.bar span { font-family: var(--body); font-size: 11px !important; line-height: 14px !important; font-weight: 600; }
.state-line { font-size: 13px !important; }
.sp-line { font-size: 12px !important; }
.skill { box-shadow: 0 0 0 1px #000, 0 0 0 2px rgba(201, 162, 77, 0.45) !important; }
.skill.ready { box-shadow: 0 0 0 1px #000, 0 0 0 2px rgba(201, 162, 77, 0.75) !important; }
.skill.learnable { animation: none !important; box-shadow: 0 0 0 1px #000, 0 0 0 2px #f0c860, 0 0 12px rgba(240, 200, 96, 0.5) !important; }
.skill.active { box-shadow: 0 0 0 1px #000, 0 0 0 2px #4ce34c, 0 0 12px #4ce34c !important; }
.hk { font-family: var(--body) !important; font-size: 12px !important; }
.cmdbtn { box-shadow: 0 0 0 1px #000, 0 0 0 2px rgba(201, 162, 77, 0.35) !important; }
.cmdbtn.on { box-shadow: 0 0 0 1px #000, 0 0 0 2px #4ce34c !important; }
.utils { margin-top: 14px !important; }
.tooltip { background: rgba(6, 8, 12, 0.94) !important; border: 1px solid var(--line); box-shadow: 0 0 0 1px #000 !important; font-family: var(--body); }
.tip-title { font-family: var(--title); font-size: 15px; }
.chat { font-family: var(--body); font-size: 14px !important; }
.banner { font-size: 22px !important; }

.ri { width: 18px; height: 18px; display: block; filter: drop-shadow(0 1px 1px #000); }
.bface { width: 22px; height: 22px; border: 2px solid; background: #0a0d14; overflow: hidden; display: block; box-shadow: 0 0 0 1px #000; }
.bface img { width: 100%; height: 100%; display: block; }
.lvtag { position: absolute; left: 50%; bottom: -10px; transform: translateX(-50%); padding: 0 5px; font-family: var(--body); font-size: 10px; font-weight: 700; line-height: 14px; color: #1a1205; background: linear-gradient(180deg, #ffe9a0, #d9a63a); box-shadow: 0 0 0 1px #000; white-space: nowrap; }
</style>
