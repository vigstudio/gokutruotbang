<script setup lang="ts">
// Cửa hàng Krusty Krab (như map gốc): Mua / Ghép / Bán / Rồng Thần.
// Mọi giao dịch do server kiểm tra (tầm quán, vàng, chỗ trong túi).
import { computed, ref } from 'vue'
import type { HeroState } from '../types'
import { ALL_BALLS, ballCount, catalog, itemDef, RARITY, sellPrice, type ItemDef } from '../game/items'
import { ballUrl, glyphUrl, itemIconUrl } from '../game/icons'
import { sendInput } from '../net'

const props = defineProps<{ hero: HeroState | null }>()
const emit = defineEmits<{ close: [] }>()

type Tab = 'buy' | 'craft' | 'sell' | 'wish'
const tab = ref<Tab>('buy')
const sel = ref<string>('')

const gold = computed(() => props.hero?.g ?? 0)
const inv = computed(() => Array.from({ length: 6 }, (_, i) => props.hero?.inv?.[i] ?? { i: '', n: 0 }))
const shopItems = computed(() => (catalog.value?.items ?? []).filter((i) => i.price > 0))
const recipes = computed(() => catalog.value?.recipes ?? [])
const balls = computed(() => props.hero?.db ?? 0)

function count(id: string) {
  return inv.value.reduce((n, s) => n + (s.i === id ? s.n : 0), 0)
}
// khớp Hero.canAdd trên server
function canAdd(d: ItemDef) {
  if (d.id === 'revive' && count('revive') >= d.stack) return false
  return inv.value.some((s) => (s.i === d.id && s.n < d.stack) || !s.i)
}
function buyState(d: ItemDef) {
  if (gold.value < d.price) return 'Không đủ vàng'
  if (!canAdd(d)) return d.id === 'revive' && count('revive') >= d.stack ? 'Đã giữ tối đa' : 'Túi đầy'
  return ''
}
function craftState(r: { id: string; needs: string[]; gold: number }) {
  const need: Record<string, number> = {}
  for (const n of r.needs) need[n] = (need[n] ?? 0) + 1
  for (const [n, c] of Object.entries(need)) if (count(n) < c) return 'Thiếu ' + (itemDef(n)?.name ?? n)
  if (gold.value < r.gold) return 'Không đủ vàng'
  return ''
}

const detail = computed(() => {
  const d = itemDef(sel.value)
  return d ? { d, r: RARITY[d.rarity] } : null
})

function buy(d: ItemDef) {
  sel.value = d.id
  if (!buyState(d)) sendInput({ t: 'buy', ab: d.id })
}
function craft(id: string) {
  sel.value = id
  sendInput({ t: 'craft', ab: id })
}
function sell(idx: number) {
  if (inv.value[idx].i) sendInput({ t: 'sell', x: idx })
}
function wish(id: string) {
  sendInput({ t: 'wish', ab: id })
  emit('close')
}
defineExpose({ tab })
</script>

<template>
  <div class="shop" @mousedown.stop @contextmenu.prevent>
    <header>
      <img class="sicon" :src="itemIconUrl('SHOP', 'legend')" alt="" />
      <div class="stitle">
        <h3>Krusty Krab</h3>
        <span class="muted">Quán vật phẩm · đi xa sẽ tự đóng</span>
      </div>
      <span class="sgold"><img :src="glyphUrl('GOLD')" alt="" />{{ gold }}</span>
      <button class="x" title="Đóng (B / Esc)" @click="emit('close')">✕</button>
    </header>
    <nav>
      <button :class="{ on: tab === 'buy' }" @click="tab = 'buy'">Mua</button>
      <button :class="{ on: tab === 'craft' }" @click="tab = 'craft'">Ghép đồ</button>
      <button :class="{ on: tab === 'sell' }" @click="tab = 'sell'">Bán</button>
      <button :class="{ on: tab === 'wish', glow: balls === ALL_BALLS }" @click="tab = 'wish'">Rồng Thần <small>{{ ballCount(balls) }}/7</small></button>
    </nav>

    <section v-if="tab === 'buy'" class="grid">
      <button
        v-for="d in shopItems"
        :key="d.id"
        class="cell"
        :class="{ off: !!buyState(d), sel: sel === d.id }"
        :title="buyState(d)"
        @click="buy(d)"
        @mouseenter="sel = d.id"
      >
        <img class="ic" :src="itemIconUrl(d.id, d.rarity)" alt="" draggable="false" />
        <span class="cname" :style="{ color: RARITY[d.rarity].color }">{{ d.name }}</span>
        <span class="price"><img :src="glyphUrl('GOLD')" alt="" />{{ d.price }}</span>
      </button>
    </section>

    <section v-else-if="tab === 'craft'" class="recipes">
      <div v-for="r in recipes" :key="r.id" class="recipe" :class="{ off: !!craftState(r) }" @mouseenter="sel = r.id">
        <div class="parts">
          <template v-for="(n, i) in r.needs" :key="i">
            <img :src="itemIconUrl(n, itemDef(n)?.rarity)" :class="{ miss: count(n) < r.needs.filter((x) => x === n).length }" :title="itemDef(n)?.name" alt="" />
            <span class="op">+</span>
          </template>
          <span class="price"><img :src="glyphUrl('GOLD')" alt="" />{{ r.gold }}</span>
          <span class="op">→</span>
          <img class="result" :src="itemIconUrl(r.id, itemDef(r.id)?.rarity)" :title="itemDef(r.id)?.name" alt="" />
        </div>
        <div class="rinfo">
          <b :style="{ color: RARITY[itemDef(r.id)?.rarity ?? 'common'].color }">{{ itemDef(r.id)?.name }}</b>
          <span class="muted">{{ craftState(r) || 'Đủ nguyên liệu' }}</span>
        </div>
        <button class="tft-btn small" :disabled="!!craftState(r)" @click="craft(r.id)">Ghép</button>
      </div>
    </section>

    <section v-else-if="tab === 'sell'" class="grid">
      <p v-if="!inv.some((s) => s.i)" class="empty muted">Túi đồ trống.</p>
      <template v-for="(s, i) in inv" :key="i">
        <button v-if="s.i" class="cell" :class="{ sel: sel === s.i }" @click="sell(i)" @mouseenter="sel = s.i">
          <img class="ic" :src="itemIconUrl(s.i, itemDef(s.i)?.rarity)" alt="" draggable="false" />
          <span class="cname">{{ itemDef(s.i)?.name }}<template v-if="s.n > 1"> ×{{ s.n }}</template></span>
          <span class="price sellp">+{{ sellPrice(s.i) }}</span>
        </button>
      </template>
    </section>

    <section v-else class="dragon">
      <div class="dballs">
        <img v-for="n in 7" :key="n" :src="ballUrl(n, !!(balls & (1 << (n - 1))))" alt="" />
      </div>
      <p v-if="balls !== ALL_BALLS" class="muted">
        Gom đủ 7 viên Ngọc Rồng để gọi Rồng Thần. Ngọc rơi hiếm từ hộp quà trên băng và khi dùng kỹ năng E hạ rồng.
      </p>
      <div v-else class="wishes">
        <button v-for="w in catalog?.wishes ?? []" :key="w.id" class="wish" @click="wish(w.id)">
          <img :src="itemIconUrl('WISH', 'uncommon')" alt="" />
          <span><b>{{ w.name }}</b><small>{{ w.desc }}</small></span>
        </button>
      </div>
    </section>

    <footer v-if="detail && tab !== 'wish'">
      <b :style="{ color: detail.r.color }">{{ detail.d.name }}</b>
      <span class="muted"> · {{ detail.r.name }}{{ detail.d.use ? ' · dùng bằng phím 1-6' : ' · tác dụng khi để trong túi' }}</span>
      <p>{{ detail.d.desc }}</p>
    </footer>
  </div>
</template>

<style scoped>
.shop {
  position: absolute; right: 12px; top: 46px; width: 420px; z-index: 30; max-height: calc(100vh - 220px);
  display: flex; flex-direction: column; color: var(--text); font: 13px/1.4 var(--body);
  background: var(--panel); border: 1px solid var(--line); box-shadow: 0 0 0 1px #000, 0 14px 34px rgba(0, 0, 0, 0.65);
}
header { display: flex; align-items: center; gap: 10px; padding: 10px 12px 8px; border-bottom: 1px solid var(--line-dim); }
.sicon { width: 38px; height: 38px; box-shadow: 0 0 0 1px #000; }
.stitle { flex: 1; display: flex; flex-direction: column; }
.stitle h3 { margin: 0; font: 700 18px var(--title); color: var(--gold); text-shadow: 0 1px 2px #000; }
.stitle span { font-size: 11px; }
.sgold { display: flex; align-items: center; gap: 4px; font-weight: 700; color: var(--gold); font-size: 15px; }
.sgold img, .price img { width: 15px; height: 15px; }
.x { background: none; border: 0; color: var(--muted); font-size: 16px; padding: 2px 6px; }
.x:hover { color: #fff; }
nav { display: flex; border-bottom: 1px solid var(--line-dim); }
nav button {
  flex: 1; padding: 7px 4px; background: none; border: 0; border-bottom: 2px solid transparent;
  font: 600 13px var(--body); color: var(--muted);
}
nav button:hover { color: var(--btn-text); }
nav button.on { color: var(--gold); border-bottom-color: var(--gold); background: rgba(201, 162, 77, 0.06); }
nav button.glow { color: #9affa0; text-shadow: 0 0 8px #3a9a4a; }
nav small { opacity: 0.8; }
.grid, .recipes, .dragon { overflow-y: auto; min-height: 0; flex: 1 1 auto; }
.grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 6px; padding: 10px; align-content: start; }
.cell {
  display: flex; flex-direction: column; align-items: center; gap: 3px; padding: 6px 4px 5px; text-align: center;
  background: rgba(0, 0, 0, 0.35); border: 1px solid rgba(255, 255, 255, 0.06); color: var(--text);
}
.cell .ic { width: 46px; height: 46px; box-shadow: 0 0 0 1px #000; }
.cell:hover { border-color: var(--line); background: rgba(201, 162, 77, 0.08); }
.cell.sel { border-color: var(--line); }
.cell.off .ic { filter: grayscale(0.85) brightness(0.6); }
.cell.off .price { color: #ff7a6a; }
.cname { font-size: 11px; line-height: 1.2; min-height: 26px; display: flex; align-items: center; }
.price { display: flex; align-items: center; gap: 3px; font-weight: 700; color: var(--gold); font-size: 12px; }
.sellp { color: #8fe08f; }
.empty { grid-column: 1 / -1; text-align: center; margin: 18px 0; }
.recipes { padding: 8px 10px; display: grid; gap: 6px; }
.recipe { display: grid; grid-template-columns: auto 1fr auto; align-items: center; gap: 10px; padding: 6px 8px; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(255, 255, 255, 0.05); }
.recipe .tft-btn { width: auto; }
.parts { display: flex; align-items: center; gap: 3px; }
.parts img { width: 30px; height: 30px; box-shadow: 0 0 0 1px #000; }
.parts img.miss { filter: grayscale(1) brightness(0.45); }
.parts .result { width: 36px; height: 36px; box-shadow: 0 0 0 1px #000, 0 0 10px rgba(255, 154, 46, 0.5); }
.op { color: var(--muted); font-weight: 700; }
.rinfo { display: flex; flex-direction: column; font-size: 12px; }
.dragon { padding: 14px 14px 10px; text-align: center; }
.dballs { display: flex; justify-content: center; gap: 6px; margin-bottom: 10px; }
.dballs img { width: 34px; height: 34px; }
.wishes { display: grid; gap: 6px; text-align: left; }
.wish {
  display: flex; align-items: center; gap: 10px; padding: 7px 10px; color: var(--text);
  background: linear-gradient(180deg, #16402a, #0b2416); border: 1px solid #5ac46a; box-shadow: 0 0 0 1px #000;
}
.wish:hover { background: linear-gradient(180deg, #1e5a3a, #10331f); }
.wish img { width: 34px; height: 34px; }
.wish span { display: flex; flex-direction: column; }
.wish b { font: 700 14px var(--title); color: #c8ffd0; }
.wish small { color: var(--muted); }
footer { padding: 8px 12px 10px; border-top: 1px solid var(--line-dim); background: rgba(0, 0, 0, 0.25); }
footer p { margin: 3px 0 0; }
</style>
