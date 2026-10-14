import { reactive, shallowRef } from 'vue'
import type { AbilityDef, ChatLine, GameEvent, MapData, RoomInfo, RoomState, Snapshot } from './types'
import { fetchRetry } from './fetchRetry'

// Trạng thái dùng chung cho UI. Snapshot cho renderer giữ ngoài reactive để
// không tốn chi phí theo dõi 25 lần/giây.
export const store = reactive({
  connected: false,
  loggedIn: false,
  authChecked: false, // đã biết kết quả khôi phục phiên chưa
  authMsg: '',
  authBusy: false,
  myId: 0,
  playerId: 0,
  name: '',
  rooms: [] as RoomInfo[],
  room: null as RoomState | null,
  abilities: [] as AbilityDef[],
  colors: [] as string[],
  chat: [] as ChatLine[],
  error: '',
  ping: 0,
  hud: null as Snapshot | null, // bản sao cho HUD, cập nhật ~8 lần/giây
})

export const mapData = shallowRef<MapData | null>(null)

export interface SnapBuf {
  snap: Snapshot
  at: number
}
/** Toàn bộ rồng cho bản đồ nhỏ: [x, y, đại ca] (toạ độ thế giới), cập nhật ~2 lần/giây. */
export const minimapDragons: { list: [number, number, number][]; at: number } = { list: [], at: 0 }
let mapBounds: { minX: number; minY: number; maxX: number; maxY: number } | null = null
export function setMapBounds(b: typeof mapBounds) {
  mapBounds = b
}

function b64(s: string) {
  const bin = atob(s)
  const out = new Uint8Array(bin.length)
  for (let i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i)
  return out
}

/** Giải mã phần nhị phân của snapshot + điền mặc định cho Goku của mình. */
function decodeSnapshot(s: Snapshot) {
  const dr: Snapshot['dragons'] = []
  if (s.dr) {
    const b = b64(s.dr)
    const v = new DataView(b.buffer)
    for (let o = 0; o + 8 <= b.length; o += 8) {
      const flags = b[o + 7]
      dr.push([v.getUint16(o, true), v.getInt16(o + 2, true), v.getInt16(o + 4, true), (b[o + 6] / 256) * 360, flags & 0x80 ? 1 : 0, flags & 0x7f])
    }
  }
  s.dragons = dr
  if (s.mm && mapBounds) {
    const b = b64(s.mm)
    const W = mapBounds.maxX - mapBounds.minX
    const H = mapBounds.maxY - mapBounds.minY
    const list: [number, number, number][] = []
    for (let o = 0; o + 3 <= b.length; o += 3) list.push([mapBounds.minX + (b[o] / 255) * W, mapBounds.minY + (b[o + 1] / 255) * H, b[o + 2]])
    minimapDragons.list = list
    minimapDragons.at = performance.now()
  }
  // Goku của mình: server bỏ các trường bằng 0 -> điền lại cho code UI
  for (const h of s.heroes ?? []) {
    if (!h.me) continue
    h.xp ??= 0
    h.xp0 ??= 0
    h.xp1 ??= 0
    h.sp ??= 0
    h.g ??= 0
    h.q ??= 0
    h.ab ??= {}
    h.cd ??= {}
  }
}

/** Các snapshot gần nhất, sắp theo tick. */
export const snaps: SnapBuf[] = []

// ------------------------------------------------------------ đồng hồ server
const TICK_MS = 20
const offsets: { v: number; at: number }[] = []
let offsetInit = false
export const clock = {
  offset: 0, // ms: serverTick*20 ≈ performance.now() + offset
  rtt: 0,
  jitter: 0,
  /** Tick server mới nhất mà client có thể đã nhận (ước lượng). */
  serverTick(now = performance.now()) {
    return (now + this.offset) / TICK_MS
  },
}
function trackClock(tick: number, at: number) {
  const v = tick * TICK_MS - at
  offsets.push({ v, at })
  while (offsets.length > 0 && at - offsets[0].at > 4000) offsets.shift()
  // lấy mẫu ít trễ nhất trong 4 giây gần đây => ít bị ảnh hưởng bởi jitter
  let best = -Infinity
  for (const o of offsets) best = Math.max(best, o.v)
  const prevJ = clock.jitter
  clock.jitter = prevJ * 0.9 + Math.abs(best - v) * 0.1
  // chỉnh đồng hồ từ từ (tối đa 1 ms mỗi gói ≈ 2.5%) để thời gian không nhảy cóc;
  // lệch quá xa (vừa vào trận, mạng đổi hẳn) thì đặt thẳng
  const d = best - clock.offset
  clock.offset = Math.abs(d) > 200 || !offsetInit ? best : clock.offset + Math.max(-1, Math.min(1, d))
  offsetInit = true
}

type EventListener = (e: GameEvent) => void
const eventListeners = new Set<EventListener>()
export function onGameEvent(fn: EventListener) {
  eventListeners.add(fn)
  return () => eventListeners.delete(fn)
}
type SnapListener = (s: Snapshot) => void
const snapListeners = new Set<SnapListener>()
export function onSnapshot(fn: SnapListener) {
  snapListeners.add(fn)
  return () => snapListeners.delete(fn)
}

let ws: WebSocket | null = null
let hudAt = 0
let seq = 0
let pingTimer = 0

export function connect() {
  const proto = location.protocol === 'https:' ? 'wss' : 'ws'
  ws = new WebSocket(`${proto}://${location.host}/ws`)
  ws.onopen = () => {
    store.connected = true
    store.error = ''
    hello()
    clearInterval(pingTimer)
    pingTimer = window.setInterval(() => send({ t: 'ping', c: performance.now() }), 2000)
  }
  ws.onclose = () => {
    store.connected = false
    store.loggedIn = false
    clearInterval(pingTimer)
    setTimeout(connect, 1500)
  }
  ws.onmessage = (ev) => handle(JSON.parse(ev.data))
}

function hello() {
  send({ t: 'hello', token: localStorage.getItem('goku.token') ?? '' })
}

export function login(username: string, password: string) {
  store.authBusy = true
  store.authMsg = ''
  send({ t: 'login', username, password })
}

export function register(username: string, password: string) {
  store.authBusy = true
  store.authMsg = ''
  send({ t: 'register', username, password })
}

export function logout() {
  localStorage.removeItem('goku.token')
  store.loggedIn = false
  store.room = null
  send({ t: 'logout' })
}

export function send(msg: Record<string, unknown>) {
  if (ws && ws.readyState === WebSocket.OPEN) ws.send(JSON.stringify(msg))
}

/** Gửi lệnh trong trận, kèm số thứ tự để đối chiếu với dự đoán. */
export function sendInput(msg: Record<string, unknown>): number {
  seq++
  send({ ...msg, s: seq })
  return seq
}


export async function loadMap() {
  if (mapData.value) return mapData.value
  const r = await fetchRetry('/api/map')
  mapData.value = await r.json()
  return mapData.value!
}

function handle(m: any) {
  switch (m.t) {
    case 'welcome':
      store.myId = m.id
      store.abilities = m.abilities
      store.colors = m.colors
      break
    case 'session':
      localStorage.setItem('goku.token', m.token)
      store.playerId = m.playerId
      store.name = m.name
      store.loggedIn = true
      store.authChecked = true
      store.authBusy = false
      store.authMsg = ''
      break
    case 'auth':
      store.loggedIn = false
      store.authChecked = true
      store.authBusy = false
      store.room = null
      if (m.text && /phiên/i.test(m.text)) {
        localStorage.removeItem('goku.token')
        store.authMsg = ''
      } else {
        store.authMsg = m.text ?? ''
      }
      break
    case 'pong':
      store.ping = Math.round(performance.now() - m.c)
      clock.rtt = clock.rtt ? clock.rtt * 0.7 + store.ping * 0.3 : store.ping
      break
    case 'rooms':
      store.rooms = m.rooms
      if (!store.room) break
      store.room = null
      break
    case 'room': {
      const prev = store.room
      store.room = m as RoomState
      if (!prev || prev.state !== m.state) {
        snaps.length = 0
      offsetInit = false
        offsets.length = 0
        store.hud = null
        if (m.state === 'game') store.chat = []
      }
      break
    }
    case 'snap': {
      const now = performance.now()
      const s = m as Snapshot
      decodeSnapshot(s)
      if (snaps.length && s.tick < snaps[snaps.length - 1].snap.tick) break // gói đến trễ
      snaps.push({ snap: s, at: now })
      if (snaps.length > 12) snaps.shift()
      // lúc đang nạp, tick server chưa chạy: không dùng để đồng bộ đồng hồ
      if (s.phase !== 'loading') trackClock(s.tick, now)
      snapListeners.forEach((fn) => fn(s))
      if (now - hudAt > 120 || s.phase !== store.hud?.phase) {
        hudAt = now
        store.hud = s
      }
      break
    }
    case 'events':
      for (const e of m.events as GameEvent[]) {
        if (e.kind === 'msg' || e.kind === 'round') pushChat({ slot: -1, text: e.text ?? '', time: Date.now() })
        eventListeners.forEach((fn) => fn(e))
      }
      break
    case 'chat':
      pushChat({ slot: m.slot, name: m.name, text: m.text, time: Date.now() })
      break
    case 'kicked':
      store.room = null
      store.error = m.text
      break
    case 'error':
      store.error = m.text
      setTimeout(() => (store.error = ''), 4000)
      break
  }
}

function pushChat(l: ChatLine) {
  store.chat.push(l)
  if (store.chat.length > 60) store.chat.splice(0, store.chat.length - 60)
}

export function mySlot(): number {
  return store.room?.slot ?? -1
}

export function isHost(): boolean {
  return !!store.room && store.room.host === store.room.you
}
