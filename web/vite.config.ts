import { defineConfig, type Plugin } from 'vite'
import vue from '@vitejs/plugin-vue'

/**
 * Vá shader "SD" (model WC3 cổ điển) của thư viện war3-model: bản gốc không
 * tính ánh sáng nên trong cảnh 3D model trông bệt như giấy. Thêm pháp tuyến
 * xoay theo xương + camera, ánh sáng khuếch tán, ánh sáng môi trường và viền sáng.
 */
function war3LitShader(): Plugin {
  return {
    name: 'war3-lit-shader',
    enforce: 'pre',
    transform(code, id) {
      if (!id.includes('war3-model')) return null
      let out = code
      // vertex shader skinning bằng GPU: pháp tuyến theo xương + view
      out = out.replace(
        /(var sdHardwareSkinning_vs_default = "[^"]*?)vNormal = aNormal;/,
        '$1vNormal = normalize(mat3(uMVMatrix) * mat3(uNodesMatrices[int(aGroup[0])]) * aNormal);',
      )
      // vertex shader skinning bằng CPU
      out = out.replace(/(var sdSoftwareSkinning_vs_default = "[^"]*?)vNormal = aNormal;/, '$1vNormal = normalize(mat3(uMVMatrix) * aNormal);')
      // fragment shader: chiếu sáng
      out = out.replace(
        /(var sd_fs_default = "[^"]*?)gl_FragColor = texture2D\(uSampler, texCoord\);/,
        '$1gl_FragColor = texture2D(uSampler, texCoord);\\n        vec3 nn = normalize(vNormal);\\n        float lam = max(dot(nn, normalize(vec3(-0.35, 0.6, 0.72))), 0.0);\\n        float rim = pow(1.0 - abs(nn.z), 2.5);\\n        gl_FragColor.rgb *= 0.58 + 0.7 * lam;\\n        gl_FragColor.rgb += vec3(0.42, 0.55, 0.75) * rim * 0.28 * gl_FragColor.a;',
      )
      if (out === code) this.warn('war3-lit-shader: không tìm thấy shader để vá')
      // thư viện gọi alert() khi shader lỗi (vd. WebGL context vừa bị huỷ lúc
      // chuyển trang) -> người chơi thấy hộp thoại "null". Chuyển sang console.
      out = out.replace(/\balert\(/g, 'console.warn("[war3-model]", ')
      return { code: out, map: null }
    },
  }
}

// Khi chạy `npm run dev`, chuyển /ws và /api sang Go server (cổng 8080).
export default defineConfig({
  plugins: [war3LitShader(), vue()],
  optimizeDeps: { exclude: ['war3-model'] },
  server: {
    port: 5173,
    proxy: {
      '/api': 'http://localhost:8080',
      '/ws': { target: 'ws://localhost:8080', ws: true },
    },
  },
})
