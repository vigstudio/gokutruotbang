<script setup lang="ts">
// Điều khiển cảm ứng kiểu Liên Quân: cần gạt bên trái, cụm kỹ năng hình
// vòng cung bên phải (kéo để ngắm kỹ năng chọn điểm), ô đồ ở giữa.
import { computed, onBeforeUnmount, reactive, ref } from 'vue'
import type { AbilityDef, HeroState } from '../types'
import { iconUrl, itemIconUrl } from '../game/icons'
import { itemDef } from '../game/items'

const props = defineProps<{ hero: HeroState | null; abilities: AbilityDef[]; nearShop: boolean }>()
const emit = defineEmits<{
  move: [nx: number, ny: number]
  moveEnd: []
  cast: [key: string]
  aim: [key: string, nx: number, ny: number]
  aimEnd: [key: string, fire: boolean]
  learn: [key: string]
  use: [idx: number]
  shop: []
  stop: []
}>()

// ---------------------------------------------------------------- cần gạt
const JOY_R = 46
const joy = reactive({ active: false, id: -1, cx: 0, cy: 0, kx: 0, ky: 0 })
function joyDown(e: PointerEvent) {
  const el = e.currentTarget as HTMLElement
  el.setPointerCapture(e.pointerId)
  const r = el.getBoundingClientRect()
  joy.active = true
  joy.id = e.pointerId
  joy.cx = r.left + r.width / 2
  joy.cy = r.top + r.height / 2
  joyMove(e)
}
function joyMove(e: PointerEvent) {
  if (!joy.active || e.pointerId !== joy.id) return
  let dx = e.clientX - joy.cx
  let dy = e.clientY - joy.cy
  const l = Math.hypot(dx, dy)
  if (l > JOY_R) {
    dx = (dx / l) * JOY_R
    dy = (dy / l) * JOY_R
  }
  joy.kx = dx
  joy.ky = dy
  if (l > 10) emit('move', dx / JOY_R, dy / JOY_R)
}
function joyUp(e: PointerEvent) {
  if (e.pointerId !== joy.id) return
  joy.active = false
  joy.kx = joy.ky = 0
  emit('moveEnd')
}

// ---------------------------------------------------------------- kỹ năng
// Q to ở giữa, các kỹ năng còn lại xếp vòng cung (góc tính từ tâm Q)
const ARC: Record<string, number> = { W: 192, E: 151, R: 111, A: 72 }
const ARC_R = 104
function lv(a: AbilityDef) {
  return props.hero?.ab[a.key] ?? 0
}
function canLearn(a: AbilityDef) {
  const h = props.hero
  if (!h || h.sp <= 0) return false
  const next = lv(a) + 1
  return next <= a.maxLevel && h.lv >= 2 * next - 1
}
function cost(a: AbilityDef) {
  return a.mana[Math.max(0, lv(a) - 1)]
}
function cdLeft(a: AbilityDef) {
  return props.hero?.cd[a.key] ?? 0
}
function sweep(a: AbilityDef) {
  const l = lv(a)
  const c = cdLeft(a)
  if (!c || !l) return {}
  const deg = (c / a.cooldown[l - 1]) * 360
  return { background: `conic-gradient(from 0deg, transparent ${360 - deg}deg, rgba(0,0,0,0.7) ${360 - deg}deg)` }
}
function ready(a: AbilityDef) {
  const h = props.hero
  return !!h && h.a && lv(a) > 0 && !cdLeft(a) && h.mp >= cost(a)
}
function pos(key: string) {
  if (key === 'Q') return { right: '22px', bottom: '18px' }
  const ang = ((ARC[key] ?? 180) * Math.PI) / 180
  // tâm Q cách mép phải 22+37, mép dưới 18+37
  const cx = 59 + -Math.cos(ang) * ARC_R
  const cy = 55 + Math.sin(ang) * ARC_R
  return { right: cx - 26 + 'px', bottom: cy - 26 + 'px' }
}

const AIM_R = 80
const aim = reactive({ key: '', id: -1, sx: 0, sy: 0, moved: false, cancel: false })
const cancelEl = ref<HTMLElement>()
function skillDown(a: AbilityDef, e: PointerEvent) {
  if (!ready(a)) {
    emit('cast', a.key) // để GameView báo lý do (chưa học/hồi chiêu/thiếu mana)
    return
  }
  if (a.target !== 'point') {
    emit('cast', a.key)
    return
  }
  ;(e.currentTarget as HTMLElement).setPointerCapture(e.pointerId)
  Object.assign(aim, { key: a.key, id: e.pointerId, sx: e.clientX, sy: e.clientY, moved: false, cancel: false })
  emit('aim', a.key, 0, 0)
}
function skillMove(e: PointerEvent) {
  if (!aim.key || e.pointerId !== aim.id) return
  let dx = e.clientX - aim.sx
  let dy = e.clientY - aim.sy
  const l = Math.hypot(dx, dy)
  if (l > 12) aim.moved = true
  if (l > AIM_R) {
    dx = (dx / l) * AIM_R
    dy = (dy / l) * AIM_R
  }
  const c = cancelEl.value?.getBoundingClientRect()
  aim.cancel = !!c && e.clientX >= c.left && e.clientX <= c.right && e.clientY >= c.top && e.clientY <= c.bottom
  emit('aim', aim.key, dx / AIM_R, dy / AIM_R)
}
function skillUp(e: PointerEvent) {
  if (!aim.key || e.pointerId !== aim.id) return
  emit('aimEnd', aim.key, !aim.cancel)
  aim.key = ''
}

// ---------------------------------------------------------------- ô đồ
const slots = computed(() => Array.from({ length: 6 }, (_, i) => props.hero?.inv?.[i] ?? { i: '', n: 0 }))

function onCancel() {
  /* chỉ là vùng thả để huỷ */
}
onBeforeUnmount(() => {
  if (joy.active) emit('moveEnd')
})
</script>

<template>
  <div class="mc" @contextmenu.prevent>
    <!-- cần gạt -->
    <div class="joy-zone" @pointerdown.prevent="joyDown" @pointermove="joyMove" @pointerup="joyUp" @pointercancel="joyUp">
      <div class="joy-base" :class="{ on: joy.active }">
        <div class="joy-knob" :style="{ transform: `translate(${joy.kx}px, ${joy.ky}px)` }"></div>
      </div>
    </div>

    <!-- ô đồ + nút phụ -->
    <div class="items">
      <button v-for="(s, i) in slots" :key="i" class="slot" :class="{ empty: !s.i }" @pointerdown.prevent="s.i && emit('use', i)">
        <img v-if="s.i" :src="itemIconUrl(s.i, itemDef(s.i)?.rarity)" alt="" draggable="false" />
        <span v-if="s.n > 1" class="cnt">{{ s.n }}</span>
      </button>
      <button class="slot util" :class="{ near: nearShop }" @pointerdown.prevent="emit('shop')"><img :src="itemIconUrl('SHOP', 'legend')" alt="" /></button>
      <button class="slot util" @pointerdown.prevent="emit('stop')"><img :src="iconUrl('S')" alt="" /></button>
    </div>

    <!-- cụm kỹ năng -->
    <div class="skills">
      <div
        v-for="a in abilities"
        :key="a.key"
        class="sk"
        :class="{ big: a.key === 'Q', off: lv(a) === 0, ready: ready(a), aiming: aim.key === a.key }"
        :style="pos(a.key)"
        @pointerdown.prevent="skillDown(a, $event)"
        @pointermove="skillMove"
        @pointerup="skillUp"
        @pointercancel="skillUp"
      >
        <img :src="iconUrl(a.key)" alt="" draggable="false" />
        <div class="sweep" :style="sweep(a)"></div>
        <span v-if="cdLeft(a) && lv(a)" class="cd">{{ Math.ceil(cdLeft(a)) }}</span>
        <span v-if="lv(a)" class="lvl">{{ lv(a) }}</span>
        <button v-if="canLearn(a)" class="learn" @pointerdown.stop.prevent="emit('learn', a.key)">+</button>
      </div>
      <div v-show="aim.key" ref="cancelEl" class="cancel" :class="{ hot: aim.cancel }" @pointerup="onCancel">Hủy</div>
    </div>
  </div>
</template>

<style scoped>
.mc { position: absolute; inset: 0; pointer-events: none; z-index: 8; user-select: none; -webkit-user-select: none; }
.mc > * { pointer-events: auto; touch-action: none; }

.joy-zone {
  position: absolute; left: calc(14px + env(safe-area-inset-left)); bottom: 12px; width: 140px; height: 140px;
  display: grid; place-items: center;
}
.joy-base {
  width: 104px; height: 104px; border-radius: 50%; display: grid; place-items: center;
  background: radial-gradient(circle, rgba(255, 255, 255, 0.04), rgba(10, 16, 28, 0.22));
  border: 2px solid rgba(255, 255, 255, 0.28); box-shadow: inset 0 0 14px rgba(0, 0, 0, 0.25);
}
.joy-base.on { border-color: rgba(240, 200, 96, 0.7); }
.joy-knob {
  width: 46px; height: 46px; border-radius: 50%; opacity: 0.85;
  background: radial-gradient(circle at 40% 35%, #fff4c8, #e8b84a 45%, #8a5a10);
  box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.6), 0 3px 8px rgba(0, 0, 0, 0.45);
}

.items {
  position: absolute; left: 50%; bottom: 8px; transform: translateX(-50%); display: flex; gap: 4px;
  padding: 3px; background: rgba(8, 10, 14, 0.25); border: 1px solid rgba(255, 255, 255, 0.08);
}
.slot {
  position: relative; width: 34px; height: 34px; padding: 0; border: 0;
  background: rgba(0, 0, 0, 0.2); box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.5), 0 0 0 2px rgba(255, 255, 255, 0.12);
}
.slot img { width: 100%; height: 100%; display: block; opacity: 0.9; }
.slot.util { margin-left: 4px; }
.slot.near { box-shadow: 0 0 0 1px #000, 0 0 0 2px #f0c860, 0 0 12px rgba(240, 200, 96, 0.7); }
.cnt { position: absolute; right: 1px; bottom: 0; font: 700 11px var(--body); color: #fff; background: rgba(0, 0, 0, 0.75); padding: 0 3px; }

.skills { position: absolute; right: env(safe-area-inset-right); bottom: 0; width: 210px; height: 200px; pointer-events: none; }
.sk {
  position: absolute; width: 52px; height: 52px; border-radius: 50%; overflow: visible; pointer-events: auto; touch-action: none;
  box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.55), 0 0 0 3px rgba(255, 255, 255, 0.22);
}
.sk.big { width: 74px; height: 74px; }
.sk img { width: 100%; height: 100%; border-radius: 50%; display: block; opacity: 0.78; }
.sk.off img { filter: grayscale(0.7) brightness(0.85); opacity: 0.45; }
.sk.ready img { opacity: 0.92; }
.sk.ready { box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.55), 0 0 0 3px rgba(240, 200, 96, 0.75), 0 0 10px rgba(240, 200, 96, 0.3); }
.sk.aiming { box-shadow: 0 0 0 1px #000, 0 0 0 3px #4ce34c, 0 0 14px #4ce34c; }
.sweep { position: absolute; inset: 0; border-radius: 50%; pointer-events: none; }
.cd { position: absolute; inset: 0; display: grid; place-items: center; font: 700 17px var(--body); color: #fff; text-shadow: 0 0 4px #000, 0 0 2px #000; pointer-events: none; }
.lvl {
  position: absolute; right: -2px; bottom: -2px; min-width: 18px; height: 18px; border-radius: 9px; padding: 0 4px;
  font: 700 11px/18px var(--body); text-align: center; color: #1a1002; background: #f0c860; box-shadow: 0 0 0 1px #000;
}
.learn {
  position: absolute; z-index: 20; left: 50%; top: -24px; width: 22px; height: 22px; margin-left: -11px; padding: 0; border: 0; border-radius: 50%;
  font: 700 16px/21px var(--body); color: #3a2400; pointer-events: auto;
  background: radial-gradient(circle at 40% 35%, #fff6c8, #f0c048 55%, #a06a10);
  box-shadow: 0 0 0 2px #000, 0 0 12px rgba(255, 210, 90, 0.9); animation: lp 1s ease-in-out infinite alternate;
}
@keyframes lp { to { transform: scale(1.12); box-shadow: 0 0 0 2px #000, 0 0 20px rgba(255, 220, 110, 1); } }
.cancel {
  position: absolute; right: 14px; bottom: 176px; width: 52px; height: 52px; border-radius: 50%; display: grid; place-items: center;
  font: 700 14px var(--body); color: #fff; background: rgba(120, 20, 20, 0.6); border: 2px solid rgba(255, 120, 100, 0.6); pointer-events: auto;
}
.cancel.hot { background: rgba(200, 30, 30, 0.85); border-color: #fff; transform: scale(1.1); }
</style>
