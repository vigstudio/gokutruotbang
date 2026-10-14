<script setup lang="ts">
// Nút bật/tắt nhạc nền (dùng ở trang chủ và trong trận).
import { music, toggleMute } from '../audio/music'
</script>

<template>
  <button class="sound" :class="{ off: music.muted }" :title="music.muted ? 'Bật nhạc nền' : 'Tắt nhạc nền'" @click.stop="toggleMute">
    <svg viewBox="0 0 24 24" aria-hidden="true">
      <path d="M4 9h4l5-4v14l-5-4H4z" fill="currentColor" />
      <template v-if="!music.muted">
        <path d="M16 8.5a5 5 0 0 1 0 7" />
        <path d="M18.5 6a8.5 8.5 0 0 1 0 12" />
      </template>
      <path v-else d="M16 9l6 6M22 9l-6 6" />
    </svg>
  </button>
</template>

<style scoped>
.sound {
  display: inline-grid; place-items: center; width: 30px; height: 26px; padding: 0; color: var(--btn-text); cursor: pointer;
  background: rgba(0, 0, 0, 0.35); border: 1px solid rgba(255, 255, 255, 0.1);
}
.sound:hover { border-color: var(--line); color: #fff7d6; }
.sound.off { color: var(--muted); }
svg { width: 18px; height: 18px; fill: none; stroke: currentColor; stroke-width: 2; stroke-linecap: round; }
</style>
