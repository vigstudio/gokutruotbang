// Asset 3D dùng chung cho menu và màn chơi: cây thông, tinh thể băng, bầu
// trời + env map (cho mặt băng phản chiếu), ánh sáng có bóng đổ, tuyết rơi.
// Hệ toạ độ theo WC3: X đông, Y bắc, Z hướng lên.
import * as THREE from 'three'
import { clusterMatrices } from './cluster'
import { mergeGeometries } from 'three/examples/jsm/utils/BufferGeometryUtils.js'

function rng(seed: number) {
  return () => {
    seed = (seed * 1664525 + 1013904223) >>> 0
    return seed / 4294967296
  }
}

function paint(geo: THREE.BufferGeometry, fn: (x: number, y: number, z: number, nz: number) => [number, number, number]) {
  const pos = geo.getAttribute('position')
  const nor = geo.getAttribute('normal')
  const col = new Float32Array(pos.count * 3)
  for (let i = 0; i < pos.count; i++) {
    const c = fn(pos.getX(i), pos.getY(i), pos.getZ(i), nor.getZ(i))
    col[i * 3] = c[0]
    col[i * 3 + 1] = c[1]
    col[i * 3 + 2] = c[2]
  }
  geo.setAttribute('color', new THREE.BufferAttribute(col, 3))
  geo.deleteAttribute('uv')
  return geo
}

/** Cây thông phủ tuyết: thân + 7 tầng lá rủ, mép lá lởm chởm. Cao ~260. */
export function pineGeometry(seed = 1): THREE.BufferGeometry {
  const r = rng(seed)
  const parts: THREE.BufferGeometry[] = []
  const trunk = new THREE.CylinderGeometry(5, 9, 70, 7).rotateX(Math.PI / 2).translate(0, 0, 35)
  parts.push(paint(trunk.toNonIndexed(), () => [0.23, 0.15, 0.1]))
  const tiers = 7
  for (let t = 0; t < tiers; t++) {
    const k = t / (tiers - 1)
    const base = 45 + t * 27
    const rad = 78 * (1 - k * 0.82) + 8
    const h = 70 - k * 22
    const seg = 28
    const cone = new THREE.ConeGeometry(rad, h, seg, 3, true).rotateX(Math.PI / 2).translate(0, 0, base + h / 2)
    const pos = cone.getAttribute('position')
    for (let i = 0; i < pos.count; i++) {
      const x = pos.getX(i)
      const y = pos.getY(i)
      const z = pos.getZ(i)
      const rr = Math.hypot(x, y)
      if (rr < 1) continue
      const a = Math.atan2(y, x)
      const edge = rr / rad // 1 ở mép dưới
      // mép lá lởm chởm + rủ xuống
      const jag = 1 + (Math.sin(a * 7 + t * 1.7) * 0.05 + (r() - 0.5) * 0.06) * edge
      const droop = -edge * edge * (10 + r() * 8)
      pos.setXYZ(i, Math.cos(a) * rr * jag, Math.sin(a) * rr * jag, z + droop)
    }
    cone.computeVertexNormals()
    const g = cone.toNonIndexed()
    const snowy = 0.55 + r() * 0.35
    paint(g, (x, y, z, nz) => {
      const up = (z - base) / h // 0 đáy -> 1 đỉnh tầng
      const rr = Math.hypot(x, y) / rad
      // tuyết đọng mặt trên, gần thân và trên đỉnh
      const snow = Math.min(1, Math.max(0, (nz - 0.35) * 2.2) * snowy * (0.6 + up * 0.6) + (rr < 0.25 ? 0.4 : 0))
      const v = 0.85 + r() * 0.3
      const green: [number, number, number] = [0.05 * v, 0.17 * v, 0.12 * v]
      const white: [number, number, number] = [0.86, 0.92, 0.98]
      return [green[0] + (white[0] - green[0]) * snow, green[1] + (white[1] - green[1]) * snow, green[2] + (white[2] - green[2]) * snow]
    })
    parts.push(g)
  }
  const merged = mergeGeometries(parts)!
  merged.computeBoundingSphere()
  return merged
}

/** Cụm tinh thể băng: 3-5 mảnh nhọn chĩa lên. Cao ~1 đơn vị (scale khi dùng). */
export function crystalGeometry(seed = 1, shards = 4): THREE.BufferGeometry {
  const r = rng(seed)
  const parts: THREE.BufferGeometry[] = []
  for (let i = 0; i < shards; i++) {
    const h = i === 0 ? 1 : 0.45 + r() * 0.4
    const w = h * (0.16 + r() * 0.08)
    const g = new THREE.OctahedronGeometry(1, 0)
    g.scale(w, w, h / 2)
    g.translate(0, 0, h / 2)
    g.rotateX((r() - 0.5) * (i === 0 ? 0.2 : 0.9))
    g.rotateY((r() - 0.5) * (i === 0 ? 0.2 : 0.9))
    g.rotateZ(r() * Math.PI * 2)
    if (i > 0) g.translate((r() - 0.5) * 0.3, (r() - 0.5) * 0.3, 0)
    parts.push(g.index ? g.toNonIndexed() : g)
  }
  const m = mergeGeometries(parts)!
  m.computeVertexNormals()
  return m
}

export function crystalMaterial(): THREE.Material {
  return new THREE.MeshPhysicalMaterial({
    color: 0xbfe8ff,
    // không dùng transmission: three.js phải vẽ lại cả cảnh vào một render
    // target mỗi khung hình chỉ để làm khúc xạ -> tụt FPS rất mạnh
    roughness: 0.06,
    metalness: 0.1,
    clearcoat: 1,
    clearcoatRoughness: 0.05,
    emissive: 0x2a6fa8,
    emissiveIntensity: 0.4,
    transparent: true,
    opacity: 0.88,
    flatShading: true,
  })
}

/** Bầu trời đêm băng giá dạng gradient; trả về texture nền và env map PMREM. */
export function makeSky(renderer: THREE.WebGLRenderer) {
  const cv = document.createElement('canvas')
  cv.width = 16
  cv.height = 512
  const ctx = cv.getContext('2d')!
  const g = ctx.createLinearGradient(0, 0, 0, 512)
  g.addColorStop(0, '#1b2a4a')
  g.addColorStop(0.45, '#5f7ea8')
  g.addColorStop(0.62, '#b9cde4')
  g.addColorStop(1, '#dfe9f4')
  ctx.fillStyle = g
  ctx.fillRect(0, 0, 16, 512)
  const tex = new THREE.CanvasTexture(cv)
  tex.colorSpace = THREE.SRGBColorSpace
  tex.mapping = THREE.EquirectangularReflectionMapping
  const pmrem = new THREE.PMREMGenerator(renderer)
  const env = pmrem.fromEquirectangular(tex).texture
  pmrem.dispose()
  return { background: tex, env }
}

/** Ánh trăng lạnh từ tây-bắc + ánh sáng bán cầu trời/tuyết. */
export function makeLights(scene: THREE.Scene, shadowSize = 1800) {
  const hemi = new THREE.HemisphereLight(0xc6dcff, 0x5a6a80, 1.1)
  hemi.up.set(0, 0, 1)
  hemi.position.set(0, 0, 1)
  scene.add(hemi)
  const sun = new THREE.DirectionalLight(0xf2f6ff, 2.6)
  sun.position.set(-900, 1100, 1800)
  sun.castShadow = true
  sun.shadow.mapSize.set(2048, 2048)
  const c = sun.shadow.camera
  c.left = -shadowSize
  c.right = shadowSize
  c.top = shadowSize
  c.bottom = -shadowSize
  c.near = 10
  c.far = 6000
  sun.shadow.bias = -0.0006
  sun.shadow.normalBias = 1.5
  scene.add(sun)
  scene.add(sun.target)
  return { hemi, sun }
}

/** Tuyết rơi quanh một điểm (gọi update mỗi khung hình). */
export class Snowfall {
  points: THREE.Points
  private vel: Float32Array
  /** gió ngang (đơn vị/giây) và tỉ lệ số hạt đang hiển thị (0..1) */
  wind = 0
  density = 1
  constructor(
    private count = 2500,
    private size = 2600,
    private height = 1400,
  ) {
    const pos = new Float32Array(count * 3)
    this.vel = new Float32Array(count)
    for (let i = 0; i < count; i++) {
      pos[i * 3] = (Math.random() - 0.5) * size
      pos[i * 3 + 1] = (Math.random() - 0.5) * size
      pos[i * 3 + 2] = Math.random() * height
      this.vel[i] = 60 + Math.random() * 90
    }
    const geo = new THREE.BufferGeometry()
    geo.setAttribute('position', new THREE.BufferAttribute(pos, 3))
    const cv = document.createElement('canvas')
    cv.width = cv.height = 32
    const ctx = cv.getContext('2d')!
    const gr = ctx.createRadialGradient(16, 16, 0, 16, 16, 16)
    gr.addColorStop(0, 'rgba(255,255,255,1)')
    gr.addColorStop(0.5, 'rgba(255,255,255,0.6)')
    gr.addColorStop(1, 'rgba(255,255,255,0)')
    ctx.fillStyle = gr
    ctx.fillRect(0, 0, 32, 32)
    const mat = new THREE.PointsMaterial({ size: 7, map: new THREE.CanvasTexture(cv), transparent: true, depthWrite: false, opacity: 0.9 })
    this.points = new THREE.Points(geo, mat)
    this.points.frustumCulled = false
  }
  private fall = 0
  private drift = 0
  private gpu: { uniforms: Record<string, THREE.IUniform> } | null = null
  /** Chỉ cập nhật vài uniform; vị trí hạt tính trong vertex shader. */
  update(dt: number, cx: number, cy: number, t: number) {
    this.fall += dt * (1 + Math.abs(this.wind) / 300)
    this.drift += this.wind * dt
    if (!this.gpu) {
      const mat = this.points.material as THREE.PointsMaterial
      const self = this
      mat.onBeforeCompile = (sh) => {
        sh.uniforms.uFall = { value: 0 }
        sh.uniforms.uDrift = { value: 0 }
        sh.uniforms.uTime = { value: 0 }
        sh.uniforms.uCam = { value: new THREE.Vector2() }
        sh.uniforms.uBox = { value: new THREE.Vector2(self.size, self.height) }
        self.gpu = sh
        sh.vertexShader = sh.vertexShader
          .replace('#include <common>', '#include <common>\nattribute float aVel;\nuniform float uFall, uDrift, uTime;\nuniform vec2 uCam, uBox;')
          .replace(
            '#include <begin_vertex>',
            `vec3 transformed = position;
            transformed.z = mod(position.z - aVel * uFall, uBox.y);
            transformed.x += sin(uTime * 0.7 + aVel) * 12.0 + uDrift;
            transformed.y += uDrift * 0.35;
            // giữ hạt quanh camera
            transformed.xy = uCam + mod(transformed.xy - uCam + 0.5 * uBox.x, uBox.x) - 0.5 * uBox.x;`,
          )
      }
      this.points.geometry.setAttribute('aVel', new THREE.BufferAttribute(this.vel, 1))
      this.gpu = { uniforms: {} }
    }
    const u = this.gpu.uniforms
    if (u.uFall) {
      u.uFall.value = this.fall
      u.uDrift.value = this.drift
      u.uTime.value = t
      ;(u.uCam.value as THREE.Vector2).set(cx, cy)
    }
    this.points.geometry.setDrawRange(0, Math.floor(this.count * Math.max(0, Math.min(1, this.density))))
  }
}

/** Texture tròn mờ dùng cho bóng, quầng sáng. */
export function radialTexture(inner: string, outer: string, size = 128) {
  const cv = document.createElement('canvas')
  cv.width = cv.height = size
  const ctx = cv.getContext('2d')!
  const g = ctx.createRadialGradient(size / 2, size / 2, 0, size / 2, size / 2, size / 2)
  g.addColorStop(0, inner)
  g.addColorStop(1, outer)
  ctx.fillStyle = g
  ctx.fillRect(0, 0, size, size)
  const t = new THREE.CanvasTexture(cv)
  t.colorSpace = THREE.SRGBColorSpace
  return t
}

/** Cột sáng (như tháp Icecrown trong menu Frozen Throne). */
export function lightBeam(color: number, height: number, radius: number) {
  const geo = new THREE.CylinderGeometry(radius * 0.6, radius, height, 24, 1, true).rotateX(Math.PI / 2).translate(0, 0, height / 2)
  const cv = document.createElement('canvas')
  cv.width = 4
  cv.height = 256
  const ctx = cv.getContext('2d')!
  const g = ctx.createLinearGradient(0, 0, 0, 256)
  g.addColorStop(0, 'rgba(255,255,255,0)')
  g.addColorStop(0.7, 'rgba(255,255,255,0.35)')
  g.addColorStop(1, 'rgba(255,255,255,0.9)')
  ctx.fillStyle = g
  ctx.fillRect(0, 0, 4, 256)
  const mat = new THREE.MeshBasicMaterial({
    color,
    map: new THREE.CanvasTexture(cv),
    transparent: true,
    blending: THREE.AdditiveBlending,
    depthWrite: false,
    side: THREE.DoubleSide,
  })
  return new THREE.Mesh(geo, mat)
}

// ---------------------------------------------------------------- cây thông v2
// Tán xếp tầng, mỗi tầng có 8 thuỳ cành rủ xuống; tuyết tính theo hướng pháp
// tuyến trong shader (mặt trên phủ tuyết, mặt dưới xanh thẫm) nên mịn, không răng cưa.
let pineCache: { foliage: THREE.BufferGeometry; trunk: THREE.BufferGeometry; fMat: THREE.Material; tMat: THREE.Material } | null = null

function pineParts() {
  if (pineCache) return pineCache
  const tiers = 7
  const parts: THREE.BufferGeometry[] = []
  for (let t = 0; t < tiers; t++) {
    const k = t / (tiers - 1)
    const base = 40 + t * 30
    const rad = 82 * (1 - k * 0.8) + 10
    const h = 78 - k * 26
    const seg = 48
    const cone = new THREE.ConeGeometry(rad, h, seg, 4, true).rotateX(Math.PI / 2).translate(0, 0, base + h / 2)
    const pos = cone.getAttribute('position')
    const phase = t * 0.7
    for (let i = 0; i < pos.count; i++) {
      const x = pos.getX(i)
      const y = pos.getY(i)
      const z = pos.getZ(i)
      const rr = Math.hypot(x, y)
      if (rr < 0.5) continue
      const a = Math.atan2(y, x)
      const e = rr / rad
      const lobe = 0.8 + 0.2 * Math.pow(Math.abs(Math.cos(a * 4 + phase)), 0.7) // 8 thuỳ cành
      const r2 = rr * (1 - e + e * lobe)
      const droop = -e * e * 16 * lobe
      pos.setXYZ(i, Math.cos(a) * r2, Math.sin(a) * r2, z + droop)
    }
    cone.computeVertexNormals()
    parts.push(cone)
  }
  const foliage = mergeGeometries(parts)!
  foliage.computeBoundingSphere()
  const trunk = new THREE.CylinderGeometry(5, 9, 80, 8).rotateX(Math.PI / 2).translate(0, 0, 40)
  const fMat = new THREE.MeshStandardMaterial({ color: 0x1c3a2a, roughness: 0.92, side: THREE.DoubleSide })
  fMat.onBeforeCompile = (sh) => {
    sh.vertexShader = sh.vertexShader
      .replace('#include <common>', '#include <common>\nvarying float vUp;\nvarying vec3 vLocal;')
      .replace('#include <begin_vertex>', '#include <begin_vertex>\nvUp = objectNormal.z;\nvLocal = position;')
    sh.fragmentShader = sh.fragmentShader
      .replace('#include <common>', '#include <common>\nvarying float vUp;\nvarying vec3 vLocal;')
      .replace(
        '#include <map_fragment>',
        `#include <map_fragment>
        float n = fract(sin(dot(floor(vLocal * 0.09), vec3(12.9898, 78.233, 37.719))) * 43758.5453);
        float snow = smoothstep(0.45, 0.8, vUp + (n - 0.5) * 0.35);
        vec3 green = diffuseColor.rgb * (0.8 + n * 0.4);
        diffuseColor.rgb = mix(green, vec3(0.86, 0.91, 0.97), snow * 0.9);`,
      )
  }
  const tMat = new THREE.MeshStandardMaterial({ color: 0x3a2a1e, roughness: 0.95 })
  pineCache = { foliage, trunk, fMat, tMat }
  return pineCache
}

/** Rừng thông instanced theo danh sách ma trận đặt cây. */
export function pineForest(matrices: THREE.Matrix4[], shadows = true): THREE.Group {
  const p = pineParts()
  const g = new THREE.Group()
  for (const [geo, mat] of [
    [p.foliage, p.fMat],
    [p.trunk, p.tMat],
  ] as const) {
    for (const part of clusterMatrices(matrices)) {
      const inst = new THREE.InstancedMesh(geo, mat, part.length)
      part.forEach((m, i) => inst.setMatrixAt(i, m))
      inst.castShadow = shadows
      inst.receiveShadow = shadows
      inst.computeBoundingSphere()
      g.add(inst)
    }
  }
  return g
}
