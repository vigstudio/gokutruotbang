<script setup lang="ts">
import { computed, ref } from 'vue'
import { logout, send, store } from '../net'
import type { RoomInfo } from '../types'
import { fetchRetry } from '../fetchRetry'

const selected = ref('')
const dialog = ref<'' | 'create' | 'password' | 'code' | 'board'>('')
const roomName = ref('')
const roomPass = ref('')
const roomPrivate = ref(false)
const joinPass = ref('')
const joinCode = ref('')
const board = ref<{ name: string; totalScore: number; games: number; wins: number; bestRound: number }[]>([])

const selectedRoom = computed(() => store.rooms.find((r) => r.id === selected.value) ?? null)
const canJoin = computed(() => !!selectedRoom.value && selectedRoom.value.state === 'lobby' && selectedRoom.value.players < selectedRoom.value.max)

function create() {
  send({ t: 'create', name: roomName.value, password: roomPass.value, private: roomPrivate.value })
  dialog.value = ''
  roomPass.value = ''
}
function join(r: RoomInfo | null = selectedRoom.value) {
  if (!r) return
  selected.value = r.id
  if (r.locked) {
    joinPass.value = ''
    dialog.value = 'password'
    return
  }
  send({ t: 'join', room: r.id })
}
function joinWithPass() {
  send({ t: 'join', room: selected.value, password: joinPass.value })
  dialog.value = ''
}
function joinByCode() {
  send({ t: 'join', room: joinCode.value.trim().toUpperCase(), password: joinPass.value })
  dialog.value = ''
}
async function openBoard() {
  dialog.value = 'board'
  try {
    board.value = await (await fetchRetry('/api/leaderboard')).json()
  } catch {
    board.value = []
  }
}
</script>

<template>
  <div class="layout">
    <section class="iron snowy games">
      <h2>Trò chơi tùy chỉnh</h2>
      <div class="well list">
        <div class="wc-row head">
          <span>Tên trò chơi</span><span>Người chơi</span><span>Trạng thái</span>
        </div>
        <div
          v-for="r in store.rooms"
          :key="r.id"
          class="wc-row selectable"
          :class="{ selected: r.id === selected }"
          @click="selected = r.id"
          @dblclick="join(r)"
        >
          <span class="gname"><span v-if="r.locked" class="lock" title="Có mật khẩu">🔒</span>{{ r.name }}</span>
          <span>{{ r.players }}/{{ r.max }}</span>
          <span :class="r.state === 'lobby' ? 'open' : 'busy'">{{ r.state === 'lobby' ? 'Đang chờ' : `Đang chơi · vòng ${r.round}` }}</span>
        </div>
        <div v-if="store.rooms.length === 0" class="empty">Chưa có trò chơi công khai nào. Hãy tạo một trò chơi mới.</div>
      </div>
    </section>

    <aside class="side">
      <div class="hang">
        <section class="iron snowy menu-panel">
          <div class="hello">Xin chào, <b class="gold">{{ store.name }}</b></div>
          <div class="buttons">
            <button class="tft-btn" @click="dialog = 'create'">Tạo trò chơi</button>
            <button class="tft-btn" :disabled="!canJoin" @click="join()">Tham gia</button>
            <button class="tft-btn" @click="((joinCode = ''), (joinPass = ''), (dialog = 'code'))">Vào bằng mã phòng</button>
            <button class="tft-btn" @click="send({ t: 'rooms' })">Làm mới</button>
            <button class="tft-btn" @click="openBoard">Bảng xếp hạng</button>
          </div>
        </section>
      </div>
      <section class="iron snowy quit-panel">
        <button class="tft-btn" @click="logout">Đăng xuất</button>
      </section>
    </aside>

    <!-- hộp thoại -->
    <div v-if="dialog" class="modal-back" @mousedown.self="dialog = ''">
      <form v-if="dialog === 'create'" class="iron snowy modal" @submit.prevent="create">
        <h2>Tạo trò chơi</h2>
        <label class="wc-label">Tên trò chơi</label>
        <input v-model="roomName" class="tft-input full" maxlength="30" :placeholder="`Phòng của ${store.name}`" autofocus />
        <label class="wc-label gap">Mật khẩu phòng (để trống nếu không cần)</label>
        <input v-model="roomPass" class="tft-input full" maxlength="32" autocomplete="off" />
        <label class="check gap"><input v-model="roomPrivate" type="checkbox" /> Phòng riêng — không hiện trong danh sách, mời bạn bè bằng mã phòng</label>
        <div class="row">
          <button class="tft-btn" type="button" @click="dialog = ''">Hủy</button>
          <button class="tft-btn" type="submit">Tạo</button>
        </div>
      </form>

      <form v-else-if="dialog === 'password'" class="iron snowy modal" @submit.prevent="joinWithPass">
        <h2>Phòng có mật khẩu</h2>
        <p class="sub">{{ selectedRoom?.name }}</p>
        <label class="wc-label">Mật khẩu</label>
        <input v-model="joinPass" class="tft-input full" type="password" maxlength="32" autofocus />
        <div class="row">
          <button class="tft-btn" type="button" @click="dialog = ''">Hủy</button>
          <button class="tft-btn" type="submit">Vào phòng</button>
        </div>
      </form>

      <form v-else-if="dialog === 'code'" class="iron snowy modal" @submit.prevent="joinByCode">
        <h2>Vào bằng mã phòng</h2>
        <label class="wc-label">Mã phòng (5 ký tự)</label>
        <input v-model="joinCode" class="tft-input full code" maxlength="5" autofocus />
        <label class="wc-label gap">Mật khẩu (nếu có)</label>
        <input v-model="joinPass" class="tft-input full" type="password" maxlength="32" />
        <div class="row">
          <button class="tft-btn" type="button" @click="dialog = ''">Hủy</button>
          <button class="tft-btn" type="submit" :disabled="joinCode.trim().length !== 5">Vào phòng</button>
        </div>
      </form>

      <div v-else-if="dialog === 'board'" class="iron snowy modal wide">
        <h2>Bảng xếp hạng</h2>
        <div class="well">
          <div class="wc-row head brow"><span>#</span><span>Người chơi</span><span>Điểm</span><span>Trận</span><span>Thắng</span></div>
          <div v-for="(p, i) in board" :key="p.name" class="wc-row brow">
            <span>{{ i + 1 }}</span><span class="gold">{{ p.name }}</span><span>{{ p.totalScore }}</span><span>{{ p.games }}</span><span>{{ p.wins }}</span>
          </div>
          <div v-if="board.length === 0" class="empty">Chưa có ai hoàn thành trận nào.</div>
        </div>
        <div class="row single"><button class="tft-btn" @click="dialog = ''">Đóng</button></div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.layout { position: absolute; inset: 0; z-index: 3; }
.games { position: absolute; left: 28px; top: 170px; bottom: 44px; width: min(440px, calc(100vw - 460px)); display: flex; flex-direction: column; background-color: rgba(30, 33, 40, 0.86); }
.list { flex: 1; overflow: auto; }
.wc-row { display: grid; grid-template-columns: 1fr 90px 160px; gap: 8px; align-items: center; }
.head { color: var(--gold-soft); background: rgba(0, 0, 0, 0.6); position: sticky; top: 0; font-size: 14px; border-bottom: 1px solid #3d424b; }
.gname { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: #fff; }
.lock { margin-right: 6px; font-size: 12px; }
.open { color: #8fe08f; }
.busy { color: #e0a868; }
.empty { padding: 30px; text-align: center; font-style: italic; color: var(--muted); }
.side { position: absolute; right: 36px; top: 150px; width: 340px; display: flex; flex-direction: column; gap: 46px; }
.menu-panel { padding: 22px 26px 26px; }
.hello { margin-bottom: 18px; text-shadow: 0 1px 1px #000; }
.buttons { display: grid; gap: 16px; }
.quit-panel { padding: 18px 26px; }
.full { width: 100%; }
.gap { margin-top: 12px; }
.code { text-transform: uppercase; letter-spacing: 0.3em; font-size: 20px; text-align: center; }
.row { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 22px; }
.row.single { grid-template-columns: 1fr; }
.sub { margin: -4px 0 10px; color: var(--text); }
.wide { width: min(560px, 94vw); }
.brow { grid-template-columns: 30px 1fr 70px 60px 60px; }
@media (max-width: 900px) {
  .games { left: 16px; right: 16px; width: auto; top: 470px; }
  .side { left: 16px; right: 16px; width: auto; top: 130px; gap: 30px; }
}
</style>
