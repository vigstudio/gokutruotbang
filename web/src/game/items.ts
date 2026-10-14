// Danh mục vật phẩm/cửa hàng lấy từ server (/api/items) - một nguồn dữ liệu
// duy nhất cho tên, giá, mô tả, công thức ghép.
import { shallowRef } from 'vue'
import { fetchRetry } from '../fetchRetry'

export interface ItemDef {
  id: string
  name: string
  desc: string
  price: number
  stack: number
  rarity: Rarity
  use: boolean
}
export interface Recipe {
  id: string
  needs: string[]
  gold: number
}
export interface Wish {
  id: string
  name: string
  desc: string
}
export type Rarity = 'common' | 'uncommon' | 'rare' | 'epic' | 'legend'
export interface Catalog {
  items: ItemDef[]
  recipes: Recipe[]
  wishes: Wish[]
  shops: [number, number][]
  shopRange: number
  slots: number
}

export const catalog = shallowRef<Catalog | null>(null)

export async function loadCatalog() {
  if (catalog.value) return catalog.value
  const r = await fetchRetry('/api/items')
  catalog.value = (await r.json()) as Catalog
  return catalog.value
}

export function itemDef(id: string): ItemDef | undefined {
  return catalog.value?.items.find((i) => i.id === id)
}

export const RARITY: Record<Rarity, { name: string; color: string }> = {
  common: { name: 'Thường', color: '#c8ccd4' },
  uncommon: { name: 'Tốt', color: '#5fd35f' },
  rare: { name: 'Hiếm', color: '#4fa3ff' },
  epic: { name: 'Bùa', color: '#c27bff' },
  legend: { name: 'Huyền thoại', color: '#ff9a2e' },
}

export const ALL_BALLS = 0x7f

export function ballCount(mask = 0) {
  let n = 0
  for (let i = 0; i < 7; i++) if (mask & (1 << i)) n++
  return n
}

/** Quán gần nhất trong tầm (null nếu không có). */
export function shopNear(x: number, y: number): [number, number] | null {
  const c = catalog.value
  if (!c) return null
  for (const s of c.shops) if (Math.hypot(s[0] - x, s[1] - y) <= c.shopRange) return s
  return null
}

/** Giá bán lại (đồ ghép tính theo nguyên liệu) - khớp game.Sell trên server. */
export function sellPrice(id: string) {
  const d = itemDef(id)
  if (!d) return 0
  let p = d.price
  if (!p) {
    const r = catalog.value?.recipes.find((x) => x.id === id)
    if (r) p = r.gold + r.needs.reduce((s, n) => s + (itemDef(n)?.price ?? 0), 0)
  }
  return Math.floor(p * 0.5)
}
