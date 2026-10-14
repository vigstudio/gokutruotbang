// Gửi lỗi phía trình duyệt về server (/api/clientlog) để chẩn đoán các lỗi chỉ
// xảy ra trên máy người chơi. Giới hạn số lần gửi mỗi phiên.
let sent = 0
let gpu = ''

function gpuName() {
  if (gpu) return gpu
  try {
    const gl = document.createElement('canvas').getContext('webgl')
    const ext = gl?.getExtension('WEBGL_debug_renderer_info')
    gpu = (ext && gl ? String(gl.getParameter(ext.UNMASKED_RENDERER_WEBGL)) : 'unknown').slice(0, 120)
  } catch {
    gpu = 'unknown'
  }
  return gpu
}

export function reportError(kind: string, detail: unknown, extra: Record<string, unknown> = {}) {
  if (sent >= 15) return
  sent++
  const err = detail instanceof Error ? `${detail.name}: ${detail.message} @ ${(detail.stack ?? '').split('\n').slice(1, 4).join(' | ')}` : String(detail)
  const body = JSON.stringify({
    kind,
    err: err.slice(0, 900),
    ...extra,
    ua: navigator.userAgent.slice(0, 160),
    gpu: gpuName(),
    view: `${innerWidth}x${innerHeight}@${devicePixelRatio}`,
    mem: (navigator as unknown as { deviceMemory?: number }).deviceMemory,
  })
  try {
    navigator.sendBeacon?.('/api/clientlog', body) || fetch('/api/clientlog', { method: 'POST', body, keepalive: true })
  } catch {
    /* bỏ qua */
  }
}

export function installErrorReporting() {
  window.addEventListener('error', (e) => reportError('error', e.error ?? e.message, { src: `${e.filename}:${e.lineno}` }))
  window.addEventListener('unhandledrejection', (e) => reportError('rejection', e.reason))
}
