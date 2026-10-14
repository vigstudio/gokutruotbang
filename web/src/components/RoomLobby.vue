<script setup lang="ts">
import { computed, nextTick, onMounted, ref, watch } from 'vue'
import { isHost, loadMap, send, store } from '../net'
import { loadBlpCanvas } from '../game/models'

const room = computed(() => store.room!)
const slots = computed(() => {
  const out = []
  for (let i = 0; i < 11; i++) out.push(room.value.members.find((m) => m.slot === i) ?? null)
  return out
})
const preview = ref<HTMLCanvasElement>()
const chatBox = ref<HTMLDivElement>()
const chatText = ref('')
const mapName = ref('Goku Trượt Băng')
const mapDesc = ref('')
const author = ref('Vietnghiavnn')
const copied = ref(false)

onMounted(async () => {
  const m = await loadMap()
  mapName.value = m.name.replace(/\s*v?\d+(\.\d+)+\s*$/i, '').replace(/^Goku truot bang$/i, 'Goku Trượt Băng')
  mapDesc.value = m.description
  author.value = m.author
  try {
    const img = await loadBlpCanvas('war3mapMap.blp')
    const cv = preview.value!
    cv.getContext('2d')!.drawImage(img, 0, 0, cv.width, cv.height)
  } catch {
    /* không có ảnh minimap gốc */
  }
})

watch(
  () => store.chat.length,
  () => nextTick(() => chatBox.value && (chatBox.value.scrollTop = chatBox.value.scrollHeight)),
)

function sendChat() {
  if (chatText.value.trim()) send({ t: 'chat', text: chatText.value })
  chatText.value = ''
}
async function copyCode() {
  try {
    await navigator.clipboard.writeText(room.value.id)
    copied.value = true
    setTimeout(() => (copied.value = false), 1500)
  } catch {
    /* trình duyệt chặn clipboard */
  }
}
</script>

<template>
  <div class="layout">
    <section class="iron snowy players">
      <h2>{{ room.name }}</h2>
      <div class="well">
        <div class="wc-row head">
          <span>Người chơi</span><span>Nhân vật</span><span>Đội</span><span>Màu</span>
        </div>
        <div v-for="(m, i) in slots" :key="i" class="wc-row" :class="{ mine: m && m.id === room.you }">
          <span class="pname">
            <template v-if="m">
              <span v-if="m.id === room.host" class="host" title="Chủ phòng">♛</span>
              {{ m.name }}
            </template>
            <span v-else class="open-slot">Mở</span>
          </span>
          <span>{{ m ? 'Goku' : '' }}</span>
          <span>{{ m ? 1 : '' }}</span>
          <span><i class="swatch" :style="{ background: store.colors[i] }"></i></span>
        </div>
        <div class="wc-row comp">
          <span class="pname comp-name">Rồng (Máy)</span><span>Rồng</span><span>2</span>
          <span><i class="swatch" :style="{ background: store.colors[11] }"></i></span>
        </div>
      </div>

      <div ref="chatBox" class="well chat">
        <div v-for="(l, i) in store.chat" :key="i" class="line">
          <template v-if="l.slot >= 0"><b :style="{ color: store.colors[l.slot] }">{{ l.name }}:</b> {{ l.text }}</template>
          <i v-else class="gold">{{ l.text }}</i>
        </div>
      </div>
      <input v-model="chatText" class="tft-input chat-input" maxlength="200" placeholder="Nhập tin nhắn rồi nhấn Enter" @keyup.enter="sendChat" />
    </section>

    <aside class="side">
      <div class="hang">
        <section class="iron snowy info">
          <canvas ref="preview" class="preview well" width="256" height="256"></canvas>
          <div class="mapname gold">{{ mapName }}</div>
          <dl>
            <dt>Mã phòng</dt>
            <dd>
              <button class="code" title="Sao chép mã để mời bạn" @click="copyCode">{{ room.id }}</button>
              <span v-if="copied" class="copied">đã chép</span>
            </dd>
            <dt>Loại phòng</dt>
            <dd>{{ room.private ? 'Riêng tư' : 'Công khai' }}{{ room.locked ? ' · có mật khẩu' : '' }}</dd>
            <dt>Tác giả</dt>
            <dd>{{ author }}</dd>
            <dt>Mô tả</dt>
            <dd>{{ mapDesc || 'Goku trượt băng – giải trí' }}</dd>
          </dl>
          <div class="buttons">
            <button v-if="isHost()" class="tft-btn" @click="send({ t: 'start' })">Bắt đầu trò chơi</button>
            <div v-else class="wait">Đang chờ chủ phòng bắt đầu…</div>
            <button class="tft-btn" @click="send({ t: 'leave' })">Rời khỏi</button>
          </div>
        </section>
      </div>
    </aside>
  </div>
</template>

<style scoped>
.layout { position: absolute; inset: 0; z-index: 3; }
.players { position: absolute; left: 28px; top: 170px; bottom: 44px; width: min(440px, calc(100vw - 460px)); display: flex; flex-direction: column; gap: 10px; background-color: rgba(30, 33, 40, 0.86); }
.wc-row { display: grid; grid-template-columns: 1fr 90px 50px 50px; gap: 6px; align-items: center; padding: 4px 10px; }
.head { color: var(--gold-soft); font-size: 14px; background: rgba(0, 0, 0, 0.6); border-bottom: 1px solid #3d424b; }
.mine { background: rgba(60, 255, 60, 0.06); }
.pname { color: #fff; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; }
.host { color: var(--gold); margin-right: 4px; }
.open-slot { color: var(--muted); font-style: italic; }
.comp { border-top: 1px solid #3d424b; }
.comp-name { color: #c9b28a; }
.chat { flex: 1; min-height: 80px; overflow: auto; padding: 6px 10px; font-size: 14px; }
.chat .line { padding: 1px 0; }
.chat-input { width: 100%; }
.side { position: absolute; right: 36px; top: 150px; width: 340px; }
.info { padding: 20px 22px 24px; font-size: 14px; }
.preview { display: block; width: 100%; aspect-ratio: 1; background: #000; }
.mapname { font-size: 20px; margin: 10px 0 8px; text-align: center; font-weight: 700; }
dl { display: grid; grid-template-columns: auto 1fr; gap: 4px 10px; margin: 0 0 16px; }
dt { color: var(--gold-soft); }
dd { margin: 0; }
.code {
  font-family: var(--title);
  font-size: 16px;
  letter-spacing: 0.25em;
  color: var(--btn-text);
  padding: 1px 8px;
  border: none;
  background: radial-gradient(ellipse at 50% 30%, #2a2e97, #0c0d44);
  box-shadow: inset 0 0 0 1px #96a0b2, 0 0 0 1px #000;
}
.copied { color: #8fe08f; margin-left: 6px; font-size: 12px; }
.buttons { display: grid; gap: 14px; }
.wait { font-style: italic; color: var(--muted); text-align: center; }
@media (max-width: 900px) {
  .players { left: 16px; right: 16px; width: auto; top: 640px; bottom: auto; height: 520px; }
  .side { left: 16px; right: 16px; width: auto; top: 130px; }
  .layout { overflow: auto; }
}
</style>
