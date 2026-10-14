<script setup lang="ts">
import { computed, watch } from 'vue'
import { store } from './net'
import Auth from './components/Auth.vue'
import Lobby from './components/Lobby.vue'
import RoomLobby from './components/RoomLobby.vue'
import GameView from './components/GameView.vue'
import MenuScene from './components/MenuScene.vue'
import SoundButton from './components/SoundButton.vue'
import { playMusic } from './audio/music'

const screen = computed(() => {
  if (!store.loggedIn) return 'auth'
  if (!store.room) return 'lobby'
  return store.room.state === 'game' ? 'game' : 'room'
})
watch(screen, (s) => playMusic(s === 'game' ? 'game' : 'menu'), { immediate: true })
</script>

<template>
  <GameView v-if="screen === 'game'" />
  <div v-else class="menu">
    <MenuScene :focus="screen === 'auth' ? 'left' : 'center'" />
    <div class="vignette" aria-hidden="true"></div>
    <header class="logo">
      <div class="logo-main">GOKU</div>
      <div class="logo-sub">Trượt Băng</div>
    </header>
    <template v-if="store.connected || store.authChecked">
      <Auth v-if="screen === 'auth'" />
      <Lobby v-else-if="screen === 'lobby'" />
      <RoomLobby v-else />
    </template>
    <div class="status">
      <span :class="store.connected ? 'on' : 'off'">{{ store.connected ? 'Đã kết nối máy chủ' : 'Đang kết nối máy chủ…' }}</span>
      <span>Map gốc: vietnghiavnn · Icon: <a href="https://game-icons.net" target="_blank" rel="noopener">game-icons.net</a> (CC BY 3.0, Lorc &amp; Delapouite) · Texture/HDRI/model: <a href="https://polyhaven.com" target="_blank" rel="noopener">Poly Haven</a> (CC0)</span>
    </div>
    <div v-if="store.error" class="err iron">{{ store.error }}</div>
    <SoundButton class="menu-sound" />
  </div>
</template>

<style scoped>
.menu { position: relative; height: 100%; overflow: hidden; }
.menu-sound { position: fixed; z-index: 4; left: 50%; transform: translateX(-50%); bottom: 26px; }
.vignette { position: fixed; inset: 0; pointer-events: none; box-shadow: inset 0 0 220px 60px rgba(0, 0, 0, 0.85); }
.logo {
  position: absolute;
  z-index: 2;
  top: 18px;
  left: 28px;
  text-align: center;
  pointer-events: none;
  user-select: none;
}
.logo-main {
  font-family: var(--title);
  font-weight: 700;
  font-size: clamp(46px, 7vw, 86px);
  line-height: 0.9;
  letter-spacing: 0.04em;
  background: linear-gradient(180deg, #fff6c0 0%, #ffd34a 32%, #e08a12 58%, #ffcf4a 74%, #8a3e06 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  -webkit-text-stroke: 1.5px #2a1203;
  filter: drop-shadow(0 3px 0 #000) drop-shadow(0 0 10px rgba(255, 170, 40, 0.35));
}
.logo-sub {
  margin-top: -2px;
  font-family: var(--title);
  font-weight: 700;
  font-size: clamp(17px, 2.2vw, 26px);
  letter-spacing: 0.18em;
  text-transform: uppercase;
  background: linear-gradient(180deg, #ffffff 0%, #c9dcf0 45%, #6f8fb4 60%, #e2eefa 100%);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  filter: drop-shadow(0 2px 0 #000) drop-shadow(0 0 8px rgba(140, 190, 255, 0.6));
}
.status {
  position: fixed;
  z-index: 2;
  left: 0;
  right: 0;
  bottom: 0;
  display: flex;
  justify-content: space-between;
  padding: 6px 14px;
  font-size: 13px;
  color: #b9c0cf;
  text-shadow: 0 1px 2px #000;
  pointer-events: none;
}
.status a { color: #c9d4e6; pointer-events: auto; }
.on { color: #8fe08f; }
.off { color: #e0b060; }
.err { position: fixed; z-index: 40; left: 50%; top: 20px; transform: translateX(-50%); color: #ffb8a8; padding: 12px 26px; }
</style>

<style>
/* ================= menu trên điện thoại / màn hình nhỏ =================
   Các khung menu máy tính dùng vị trí tuyệt đối; màn nhỏ chuyển sang bố cục
   theo luồng, cuộn được. Màn ngang (thấp) chia 2 cột, màn dọc xếp 1 cột. */
@media (max-width: 900px), (max-height: 560px) {
  .menu { overflow-y: auto !important; -webkit-overflow-scrolling: touch; display: flex; flex-direction: column; min-height: 100%; height: 100dvh; }
  .menu .logo { position: relative !important; top: auto !important; left: auto !important; margin: 10px auto 4px; z-index: 3; flex: none; }
  .menu .logo-main { font-size: 40px !important; }
  .menu .logo-sub { font-size: 14px !important; }
  .menu .hang::before { display: none !important; }
  .menu .layout { position: relative !important; inset: auto !important; display: flex; flex-direction: column; gap: 22px; padding: 22px 12px 12px; z-index: 3; flex: 1 0 auto; }
  .menu .side, .menu .games, .menu .players {
    position: relative !important; left: auto !important; right: auto !important; top: auto !important; bottom: auto !important;
    width: auto !important; height: auto !important; max-height: none !important; z-index: 3;
  }
  .menu > .side { margin: 6px 12px 12px; }
  .menu .side { gap: 14px !important; }
  .menu .games .list, .menu .players .well { max-height: 46vh; overflow-y: auto; }
  .menu .iron { padding: 14px 16px !important; }
  .menu .iron.snowy { padding-top: 24px !important; }
  .menu > .side { margin-top: auto !important; }
  .menu .iron > h2 { font-size: 16px !important; margin-bottom: 10px !important; padding-bottom: 6px !important; }
  .menu .tft-btn { min-height: 36px; font-size: 15px; padding: 6px 12px; }
  .menu .buttons { gap: 10px !important; margin-top: 14px !important; }
  .menu .status {
    position: relative !important; flex: none; flex-direction: column; gap: 2px; padding: 6px 12px 10px !important;
    font-size: 10px !important; text-align: center; z-index: 3;
  }
  .menu .preview { display: none !important; }
  .menu .layout > .side { order: -1; }
}
/* màn ngang thấp: logo bên trái phía trên, nội dung 2 cột */
@media (max-height: 560px) and (orientation: landscape) {
  .menu .logo { margin: 8px 0 0 16px; text-align: left; }
  .menu .layout { flex-direction: row; align-items: flex-start; }
  .menu .layout > * { flex: 1 1 0; min-width: 0; }
  .menu .layout > .side { order: 0; }
  .menu > .side { align-self: flex-end; width: min(360px, 48vw) !important; margin: -40px 16px 10px auto !important; }
  .menu .games .list, .menu .players .well { max-height: 52vh; }
}
</style>
