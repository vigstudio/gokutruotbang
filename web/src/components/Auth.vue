<script setup lang="ts">
import { computed, ref } from 'vue'
import { login, register, store } from '../net'

const mode = ref<'login' | 'register'>('login')
const username = ref(localStorage.getItem('goku.lastUser') ?? '')
const password = ref('')
const confirm = ref('')
const localMsg = ref('')

const msg = computed(() => localMsg.value || store.authMsg)

function submit() {
  localMsg.value = ''
  const u = username.value.trim()
  if (!u || !password.value) {
    localMsg.value = 'Hãy nhập tên tài khoản và mật khẩu'
    return
  }
  localStorage.setItem('goku.lastUser', u)
  if (mode.value === 'register') {
    if (!/^[A-Za-z0-9_]{5,16}$/.test(u)) {
      localMsg.value = 'Tên tài khoản 5–16 ký tự, chỉ gồm chữ không dấu, số và _'
      return
    }
    if (password.value !== confirm.value) {
      localMsg.value = 'Mật khẩu nhập lại không khớp'
      return
    }
    register(u, password.value)
  } else {
    login(u, password.value)
  }
}
function toggle() {
  mode.value = mode.value === 'login' ? 'register' : 'login'
  localMsg.value = ''
  store.authMsg = ''
}
</script>

<template>
  <div class="side">
    <div class="hang">
      <section class="iron snowy panel">
        <h2>{{ mode === 'login' ? 'Đăng nhập' : 'Tạo tài khoản mới' }}</h2>
        <form @submit.prevent="submit">
          <label class="wc-label">Tên tài khoản</label>
          <input v-model="username" class="tft-input" autocomplete="username" maxlength="16" autofocus />
          <label class="wc-label gap">Mật khẩu</label>
          <input v-model="password" class="tft-input" type="password" :autocomplete="mode === 'login' ? 'current-password' : 'new-password'" maxlength="72" />
          <template v-if="mode === 'register'">
            <label class="wc-label gap">Nhập lại mật khẩu</label>
            <input v-model="confirm" class="tft-input" type="password" autocomplete="new-password" maxlength="72" />
            <p class="hint">Tên 5–16 ký tự (chữ không dấu, số, _), không dùng các tên như admin, mod, root… Mật khẩu ít nhất 6 ký tự.</p>
          </template>
          <p v-if="msg" class="msg">{{ msg }}</p>
          <div class="buttons">
            <button class="tft-btn" type="submit" :disabled="!store.connected || store.authBusy">
              {{ mode === 'login' ? 'Đăng nhập' : 'Tạo tài khoản' }}
            </button>
            <button class="tft-btn" type="button" @click="toggle">
              {{ mode === 'login' ? 'Tạo tài khoản mới' : 'Đã có tài khoản' }}
            </button>
          </div>
        </form>
      </section>
    </div>
  </div>
</template>

<style scoped>
.side { position: absolute; z-index: 3; right: 36px; top: 150px; width: 340px; }
.panel { padding: 22px 26px 24px; }
.tft-input { width: 100%; }
.gap { margin-top: 12px; }
.buttons { display: grid; gap: 14px; margin-top: 20px; }
.msg { color: #ffb4a0; margin: 12px 0 0; text-shadow: 0 1px 1px #000; }
.hint { color: var(--muted); font-size: 13px; margin: 8px 0 0; }
@media (max-width: 720px) {
  .side { left: 16px; right: 16px; width: auto; top: 140px; }
}
</style>
