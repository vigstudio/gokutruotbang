<script setup lang="ts">
// Túi đồ 6 ô kiểu WC3 (phím 1-6) + hàng 7 Ngọc Rồng.
import { computed, ref } from 'vue'
import type { HeroState } from '../types'
import { ALL_BALLS, ballCount, itemDef, RARITY, sellPrice } from '../game/items'
import { ballUrl, itemIconUrl } from '../game/icons'

const props = defineProps<{ hero: HeroState | null; shopOpen: boolean }>()
const emit = defineEmits<{ use: [idx: number]; sell: [idx: number]; wish: [] }>()

const hover = ref(-1)
const slots = computed(() => {
  const inv = props.hero?.inv ?? []
  return Array.from({ length: 6 }, (_, i) => inv[i] ?? { i: '', n: 0 })
})
const balls = computed(() => props.hero?.db ?? 0)
const tip = computed(() => {
  const s = slots.value[hover.value]
  if (!s?.i) return null
  const d = itemDef(s.i)
  if (!d) return null
  return { d, r: RARITY[d.rarity], sell: sellPrice(s.i) }
})

function click(i: number) {
  const s = slots.value[i]
  if (!s.i) return
  if (props.shopOpen) emit('sell', i)
  else emit('use', i)
}
function rclick(i: number) {
  if (slots.value[i].i && props.shopOpen) emit('sell', i)
}
</script>

<template>
  <div class="inv">
    <div class="inv-grid">
      <div
        v-for="(s, i) in slots"
        :key="i"
        class="slot"
        :class="{ empty: !s.i, usable: !!s.i && itemDef(s.i)?.use, selling: !!s.i && shopOpen }"
        @click="click(i)"
        @contextmenu.prevent="rclick(i)"
        @mouseenter="hover = i"
        @mouseleave="hover = -1"
      >
        <img v-if="s.i" :src="itemIconUrl(s.i, itemDef(s.i)?.rarity)" alt="" draggable="false" />
        <span class="hk">{{ i + 1 }}</span>
        <span v-if="s.n > 1" class="cnt">{{ s.n }}</span>
      </div>
    </div>
    <div class="balls" :class="{ full: balls === ALL_BALLS }" :title="'Ngọc Rồng: ' + ballCount(balls) + '/7'">
      <img v-for="n in 7" :key="n" :src="ballUrl(n, !!(balls & (1 << (n - 1))))" alt="" draggable="false" />
    </div>
    <button v-if="balls === ALL_BALLS" class="wish" @click="emit('wish')">Gọi Rồng Thần</button>

    <div v-if="tip" class="itip">
      <div class="it-title" :style="{ color: tip.r.color }">{{ tip.d.name }}</div>
      <div class="it-rar">{{ tip.r.name }}<template v-if="tip.d.use"> · bấm hoặc phím {{ hover + 1 }} để dùng</template></div>
      <div class="it-body">{{ tip.d.desc }}</div>
      <div v-if="shopOpen" class="it-sell">Bấm để bán: <b>+{{ tip.sell }}</b> vàng</div>
    </div>
  </div>
</template>

<style scoped>
.inv { position: relative; display: flex; flex-direction: column; gap: 6px; padding: 8px 12px 8px 4px; }
.inv-grid { display: grid; grid-template-columns: repeat(3, 40px); gap: 5px; }
.slot {
  position: relative; width: 40px; height: 40px; cursor: pointer;
  background: rgba(0, 0, 0, 0.55); box-shadow: 0 0 0 1px #000, 0 0 0 2px rgba(201, 162, 77, 0.3), inset 0 2px 6px rgba(0, 0, 0, 0.8);
}
.slot.empty { cursor: default; }
.slot img { width: 100%; height: 100%; display: block; }
.slot:not(.empty):hover { box-shadow: 0 0 0 1px #000, 0 0 0 2px #f0c860; }
.slot.selling:hover { box-shadow: 0 0 0 1px #000, 0 0 0 2px #ff9a50; }
.hk { position: absolute; left: 2px; top: 0; font: 700 10px var(--body); color: #fff; text-shadow: 0 0 2px #000, 0 0 2px #000; }
.cnt {
  position: absolute; right: 1px; bottom: 0; padding: 0 3px; font: 700 11px var(--body); color: #fff;
  background: rgba(0, 0, 0, 0.75); text-shadow: 0 1px 0 #000;
}
.balls { position: relative; display: flex; gap: 2px; align-items: center; }
.balls img { width: 17px; height: 17px; }
.balls.full img { animation: ballglow 1.2s ease-in-out infinite alternate; }
@keyframes ballglow { to { filter: drop-shadow(0 0 4px #ffb42a) brightness(1.2); } }
.wish {
  position: absolute; left: 50%; top: -30px; transform: translateX(-50%); white-space: nowrap;
  padding: 5px 12px; font: 700 13px var(--title); color: #eaffea; cursor: pointer;
  background: linear-gradient(180deg, #1f6a3a, #0d3a1e); border: 1px solid #7ae88a;
  box-shadow: 0 0 0 1px #000, 0 0 14px rgba(122, 232, 138, 0.6); animation: ballglow 1.2s infinite alternate;
}
.itip {
  position: absolute; bottom: calc(100% + 10px); right: 0; width: 260px; padding: 9px 11px; pointer-events: none; z-index: 5;
  background: rgba(6, 8, 12, 0.95); border: 1px solid var(--line); box-shadow: 0 0 0 1px #000, 0 8px 18px rgba(0, 0, 0, 0.6);
  font: 13px/1.45 var(--body); color: var(--text);
}
.it-title { font: 700 15px var(--title); }
.it-rar { font-size: 11px; color: var(--muted); margin-bottom: 4px; }
.it-sell { margin-top: 5px; color: #ffb070; }
.it-sell b { color: var(--gold); }
</style>
