// Icon nút lệnh kiểu WC3: hình vẽ từ game-icons.net (CC BY 3.0, xem
// gameicons.ts) đặt trên nền tranh tối có vân sơn, chữ hình đổ gradient kim
// loại, bóng đổ, viền vát. Kích thước gốc 512x512.
import { GAME_ICON_PATHS } from './gameicons'

interface Style {
  bg: [string, string] // tâm -> mép
  fg: [string, string, string] // trên -> giữa -> dưới
  glow: string
}

const STYLES: Record<string, Style> = {
  Q: { bg: ['#8a4a14', '#160802'], fg: ['#fff6c8', '#f5c242', '#9a5a0e'], glow: '#ffb347' },
  W: { bg: ['#34488a', '#05081a'], fg: ['#ffffff', '#c9c0ff', '#5a4fb0'], glow: '#b9a8ff' },
  E: { bg: ['#5a1650', '#0c020a'], fg: ['#f6e0ff', '#c07ae0', '#5a1f80'], glow: '#d68cff' },
  R: { bg: ['#145a7e', '#020c14'], fg: ['#ffffff', '#9be7ff', '#1f7ab0'], glow: '#7fdfff' },
  A: { bg: ['#7a2408', '#120402'], fg: ['#fff3b0', '#ff9a2a', '#b2300a'], glow: '#ff8a30' },
  S: { bg: ['#6a1414', '#120202'], fg: ['#ffffff', '#ffd0c8', '#a03020'], glow: '#ff6a50' },
  CAM: { bg: ['#2a5a32', '#041006'], fg: ['#f0fff0', '#9be89b', '#2a7a2a'], glow: '#8aff8a' },
  ZOOM: { bg: ['#4a4f5a', '#08090c'], fg: ['#ffffff', '#cfd6e2', '#6a7486'], glow: '#d0e0ff' },
}

function build(key: string): string {
  const st = STYLES[key]
  const path = GAME_ICON_PATHS[key]?.d
  if (!st || !path) return ''
  const id = 'i' + key
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
<defs>
  <radialGradient id="${id}b" cx="50%" cy="38%" r="75%"><stop offset="0" stop-color="${st.bg[0]}"/><stop offset="1" stop-color="${st.bg[1]}"/></radialGradient>
  <linearGradient id="${id}f" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${st.fg[0]}"/><stop offset=".5" stop-color="${st.fg[1]}"/><stop offset="1" stop-color="${st.fg[2]}"/></linearGradient>
  <radialGradient id="${id}v" cx="50%" cy="50%" r="70%"><stop offset=".6" stop-color="#000" stop-opacity="0"/><stop offset="1" stop-color="#000" stop-opacity=".75"/></radialGradient>
  <filter id="${id}n" x="0" y="0" width="100%" height="100%"><feTurbulence type="fractalNoise" baseFrequency=".9" numOctaves="2" seed="3"/><feColorMatrix values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 .22 0"/><feComposite in2="SourceGraphic" operator="in"/></filter>
  <filter id="${id}s" x="-10%" y="-10%" width="120%" height="120%"><feGaussianBlur in="SourceAlpha" stdDeviation="14" result="b"/><feFlood flood-color="${st.glow}" flood-opacity=".55"/><feComposite in2="b" operator="in" result="g"/><feDropShadow dx="6" dy="10" stdDeviation="6" flood-color="#000" flood-opacity=".85" result="d"/><feMerge><feMergeNode in="g"/><feMergeNode in="d"/></feMerge></filter>
</defs>
<rect width="512" height="512" fill="url(#${id}b)"/>
<rect width="512" height="512" fill="#fff" filter="url(#${id}n)" opacity=".5"/>
<g transform="translate(56 56) scale(.78125)">
  <path d="${path}" fill="url(#${id}f)" stroke="#0a0604" stroke-width="10" stroke-linejoin="round" paint-order="stroke" filter="url(#${id}s)"/>
  <path d="${path}" fill="none" stroke="#ffffff" stroke-opacity=".25" stroke-width="3" transform="translate(-3 -4)"/>
</g>
<rect width="512" height="512" fill="url(#${id}v)"/>
<path d="M6 6h500v500H6z" fill="none" stroke="#000" stroke-width="12"/>
<path d="M14 498V14h484" fill="none" stroke="#ffffff" stroke-opacity=".35" stroke-width="10"/>
<path d="M498 14v484H14" fill="none" stroke="#000" stroke-opacity=".6" stroke-width="10"/>
</svg>`
}

const cache = new Map<string, string>()

export function iconUrl(key: string) {
  let u = cache.get(key)
  if (!u) {
    u = 'data:image/svg+xml;utf8,' + encodeURIComponent(build(key) || build('S'))
    cache.set(key, u)
  }
  return u
}

const GLYPH: Record<string, [string, string, string]> = {
  GOLD: ['#fff4b8', '#f2c540', '#8a5a10'],
  SCORE: ['#fff4b8', '#e8b830', '#7a4a08'],
  DRAGON: ['#ffd0b8', '#e85a30', '#7a1a08'],
  PING: ['#d8ffd8', '#5ee05e', '#1a6a1a'],
}

/** Icon hình khối nhỏ (không nền) cho thanh tài nguyên, bảng điểm... */
export function glyphUrl(key: string) {
  const ck = 'g:' + key
  let u = cache.get(ck)
  if (u) return u
  const c = GLYPH[key] ?? GLYPH.GOLD
  const d = GAME_ICON_PATHS[key]?.d ?? ''
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><defs><linearGradient id="g" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${c[0]}"/><stop offset=".5" stop-color="${c[1]}"/><stop offset="1" stop-color="${c[2]}"/></linearGradient></defs><path d="${d}" fill="url(#g)" stroke="#000" stroke-width="22" stroke-linejoin="round" paint-order="stroke"/></svg>`
  u = 'data:image/svg+xml;utf8,' + encodeURIComponent(svg)
  cache.set(ck, u)
  return u
}

// ---------------------------------------------------------------- vật phẩm
const ITEM_STYLES: Record<string, Style> = {
  revive: { bg: ['#6a3a8e', '#0e0414'], fg: ['#fff8d0', '#f2c94c', '#8a5a10'], glow: '#ffd76a' },
  shield: { bg: ['#1f5f8e', '#020a14'], fg: ['#ffffff', '#a8e4ff', '#2a7ab8'], glow: '#9fe2ff' },
  boots: { bg: ['#5a3a1c', '#0c0603'], fg: ['#fff0d8', '#d8a06a', '#6a3a14'], glow: '#ffc080' },
  gokuboots: { bg: ['#8a3a08', '#140402'], fg: ['#fff4c0', '#ffb030', '#a03a08'], glow: '#ff9a30' },
  speedpot: { bg: ['#1c6a5a', '#021210'], fg: ['#e8fff8', '#6af0c8', '#108a6a'], glow: '#7affd8' },
  manapot: { bg: ['#1c2e8a', '#02041a'], fg: ['#e8f0ff', '#7aa2ff', '#2a3ab8'], glow: '#8ab0ff' },
  pendant: { bg: ['#1c5a7a', '#020c14'], fg: ['#ffffff', '#9ae0ff', '#2a6aa0'], glow: '#9ae0ff' },
  pendant2: { bg: ['#4a1c7a', '#08020e'], fg: ['#fff0ff', '#e0a0ff', '#7a2ab0'], glow: '#e0a0ff' },
  sobi: { bg: ['#6a4a14', '#0e0802'], fg: ['#fff4d8', '#e8c070', '#7a5010'], glow: '#ffd890' },
  tomexp: { bg: ['#2a5a2a', '#040c04'], fg: ['#f0fff0', '#a0e890', '#2a7a2a'], glow: '#b0ff90' },
  tomepow: { bg: ['#7a1c1c', '#120202'], fg: ['#fff0d0', '#ff9a50', '#b02a10'], glow: '#ff8a40' },
  senzu: { bg: ['#3a6a14', '#060e02'], fg: ['#f8ffe0', '#b8e860', '#4a8a10'], glow: '#c8ff70' },
  SHOP: { bg: ['#6a4a14', '#0e0802'], fg: ['#fff4d0', '#f0c860', '#8a5a10'], glow: '#ffd060' },
  WISH: { bg: ['#14506a', '#02080e'], fg: ['#f0fff0', '#7ae88a', '#1a7a3a'], glow: '#9affa0' },
}

const RARITY_RING: Record<string, string> = {
  common: '#8a8f99',
  uncommon: '#4cc44c',
  rare: '#3c8cff',
  epic: '#b46cff',
  legend: '#ff8a1e',
}

function buildItem(key: string, rarity: string): string {
  const st = ITEM_STYLES[key] ?? STYLES.S
  const path = GAME_ICON_PATHS[key]?.d
  if (!path) return ''
  const id = 'it' + key
  const ring = RARITY_RING[rarity] ?? RARITY_RING.common
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
<defs>
  <radialGradient id="${id}b" cx="50%" cy="38%" r="75%"><stop offset="0" stop-color="${st.bg[0]}"/><stop offset="1" stop-color="${st.bg[1]}"/></radialGradient>
  <linearGradient id="${id}f" x1="0" y1="0" x2="0" y2="1"><stop offset="0" stop-color="${st.fg[0]}"/><stop offset=".5" stop-color="${st.fg[1]}"/><stop offset="1" stop-color="${st.fg[2]}"/></linearGradient>
  <radialGradient id="${id}v" cx="50%" cy="50%" r="70%"><stop offset=".62" stop-color="#000" stop-opacity="0"/><stop offset="1" stop-color="#000" stop-opacity=".7"/></radialGradient>
  <filter id="${id}n" x="0" y="0" width="100%" height="100%"><feTurbulence type="fractalNoise" baseFrequency=".9" numOctaves="2" seed="7"/><feColorMatrix values="0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0 0 0 .2 0"/><feComposite in2="SourceGraphic" operator="in"/></filter>
  <filter id="${id}s" x="-10%" y="-10%" width="120%" height="120%"><feGaussianBlur in="SourceAlpha" stdDeviation="16" result="b"/><feFlood flood-color="${st.glow}" flood-opacity=".6"/><feComposite in2="b" operator="in" result="g"/><feDropShadow dx="6" dy="10" stdDeviation="6" flood-color="#000" flood-opacity=".85" result="d"/><feMerge><feMergeNode in="g"/><feMergeNode in="d"/></feMerge></filter>
</defs>
<rect width="512" height="512" fill="url(#${id}b)"/>
<rect width="512" height="512" fill="#fff" filter="url(#${id}n)" opacity=".5"/>
<g transform="translate(66 66) scale(.742)">
  <path d="${path}" fill="url(#${id}f)" stroke="#0a0604" stroke-width="11" stroke-linejoin="round" paint-order="stroke" filter="url(#${id}s)"/>
  <path d="${path}" fill="none" stroke="#ffffff" stroke-opacity=".25" stroke-width="3" transform="translate(-3 -4)"/>
</g>
<rect width="512" height="512" fill="url(#${id}v)"/>
<path d="M6 6h500v500H6z" fill="none" stroke="#000" stroke-width="12"/>
<path d="M22 22h468v468H22z" fill="none" stroke="${ring}" stroke-width="14"/>
<path d="M30 482V30h452" fill="none" stroke="#ffffff" stroke-opacity=".28" stroke-width="5"/>
</svg>`
}

/** Icon vật phẩm kiểu WC3 với viền màu theo độ hiếm. */
export function itemIconUrl(id: string, rarity = 'common') {
  const ck = 'it:' + id + ':' + rarity
  let u = cache.get(ck)
  if (!u) {
    u = 'data:image/svg+xml;utf8,' + encodeURIComponent(buildItem(id, rarity) || build('S'))
    cache.set(ck, u)
  }
  return u
}

/** Ngọc Rồng n sao (1-7): quả cầu cam trong suốt, sao đỏ, ánh phản chiếu. */
export function ballUrl(stars: number, owned = true) {
  const ck = 'ball:' + stars + ':' + owned
  let u = cache.get(ck)
  if (u) return u
  const pos: [number, number][][] = [
    [[0, 0]],
    [[-22, -10], [22, 10]],
    [[0, -26], [-24, 16], [24, 16]],
    [[-22, -22], [22, -22], [-22, 22], [22, 22]],
    [[0, 0], [-28, -24], [28, -24], [-28, 24], [28, 24]],
    [[-26, -28], [26, -28], [-34, 4], [34, 4], [-14, 32], [14, 32]],
    [[0, 0], [0, -36], [31, -18], [31, 18], [0, 36], [-31, 18], [-31, -18]],
  ]
  const star = (x: number, y: number, r: number) => {
    let d = ''
    for (let i = 0; i < 10; i++) {
      const a = -Math.PI / 2 + (i * Math.PI) / 5
      const rr = i % 2 ? r * 0.45 : r
      d += (i ? 'L' : 'M') + (x + Math.cos(a) * rr).toFixed(1) + ' ' + (y + Math.sin(a) * rr).toFixed(1)
    }
    return `<path d="${d}Z" fill="#d81e10" stroke="#6a0800" stroke-width="2"/>`
  }
  const r = stars >= 6 ? 13 : stars >= 4 ? 15 : 18
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128">
<defs>
  <radialGradient id="o" cx="40%" cy="35%" r="70%"><stop offset="0" stop-color="#fff2b0"/><stop offset=".35" stop-color="#ffb42a"/><stop offset=".85" stop-color="#e2620a"/><stop offset="1" stop-color="#8a3000"/></radialGradient>
  <radialGradient id="h" cx="34%" cy="26%" r="22%"><stop offset="0" stop-color="#fff" stop-opacity=".95"/><stop offset="1" stop-color="#fff" stop-opacity="0"/></radialGradient>
</defs>
<g ${owned ? '' : 'opacity=".28" filter="grayscale(1)"'}>
<circle cx="64" cy="64" r="58" fill="url(#o)" stroke="#5a1e00" stroke-width="4"/>
<g transform="translate(64 66)">${pos[stars - 1].map(([x, y]) => star(x, y, r)).join('')}</g>
<circle cx="64" cy="64" r="58" fill="url(#h)"/>
<path d="M30 92a42 42 0 0 0 64 6" fill="none" stroke="#fff" stroke-opacity=".25" stroke-width="5" stroke-linecap="round"/>
</g></svg>`
  u = 'data:image/svg+xml;utf8,' + encodeURIComponent(svg)
  cache.set(ck, u)
  return u
}
