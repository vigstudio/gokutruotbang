// Kiểu dữ liệu khớp với server Go (internal/game/snapshot.go, netserver).

export interface Rect { minX: number; minY: number; maxX: number; maxY: number }

export interface MapData {
  name: string
  author: string
  description: string
  bounds: Rect
  terrain: {
    originX: number; originY: number; cellSize: number
    cols: number; rows: number; tiles: string[]
    ground: string // base64
    layer: string
  }
  pathing: {
    originX: number; originY: number; cellSize: number
    cols: number; rows: number
    walkable: string // base64, 1 = đi được
  }
  regions: Record<string, Rect>
  units: { type: string; owner: number; x: number; y: number; facing: number }[]
  doodads: { type: string; x: number; y: number; angle: number; scale: number }[]
}

export interface AbilityDef {
  key: string
  name: string
  desc: string
  maxLevel: number
  cooldown: number[]
  mana: number[]
  target: 'none' | 'point'
  range: number
}

export interface HeroState {
  s: number; n: string
  x: number; y: number; f: number
  a: boolean; ice: boolean; h: number
  lv: number; xp: number; xp0: number; xp1: number
  mp: number; mmp: number; sp: number
  ab: Record<string, number>
  cd: Record<string, number>
  sc: number; g: number
  ww?: boolean; dr?: boolean
  /** túi đồ 6 ô (i = id vật phẩm, '' = ô trống) */
  inv?: { i: string; n: number }[]
  /** Ngọc Rồng (bit 0 = 1 sao) */
  db?: number
  /** đang bất tử (khiên vỡ / vừa hồi sinh bằng bùa) */
  iv?: boolean
  /** đã dùng Bùa Hồi Sinh, đang chờ sống lại */
  rv?: boolean
  /** đang giữ Khiên Băng */
  sh?: boolean
  /** bản đầy đủ = Goku của chính mình */
  me?: boolean
  q: number // seq lệnh cuối server đã xử lý
  mv?: boolean; tx?: number; ty?: number
  rs?: number; spd: number
}

export type Phase = 'loading' | 'countdown' | 'playing' | 'intermission' | 'victory' | 'defeat'

export interface Snapshot {
  t: 'snap'
  tick: number
  time: number
  count?: number
  phase: Phase
  round: number
  final: number
  heroes: HeroState[] | null
  /** rồng trong vùng nhìn [id, x, y, hướng, đại ca 0/1, %máu] (giải mã từ `dr`) */
  dragons: [number, number, number, number, number, number][] | null
  /** rồng nhị phân base64 (8 byte/con) - net.ts giải mã thành `dragons` */
  dr?: string
  /** toàn bộ rồng cho bản đồ nhỏ, base64 3 byte/con (gửi ~2 lần/giây) */
  mm?: string
  markers: [number, number, number][] | null
  thaws: [number, number][] | null
  /** hộp quà trên băng [id, x, y] */
  boxes?: [number, number, number][]
}

export interface GameEvent {
  kind: 'go' | 'msg' | 'cast' | 'death' | 'revive' | 'round' | 'levelup' | 'dragonDie' | 'error' | 'end' | 'item' | 'use' | 'pickup' | 'shield' | 'ball' | 'wish'
  slot: number
  by?: number
  ab?: string
  x?: number; y?: number; tx?: number; ty?: number
  text?: string
  dur?: number
}

export interface RoomInfo { id: string; name: string; players: number; max: number; state: string; round: number; locked: boolean }

export interface Member { id: number; name: string; slot: number; color: string; away?: boolean }

export interface RoomState {
  id: string
  name: string
  host: number
  state: 'lobby' | 'game'
  members: Member[]
  you: number
  slot: number
  private?: boolean
  locked?: boolean
}

export interface ChatLine { slot: number; name?: string; text: string; time: number }
