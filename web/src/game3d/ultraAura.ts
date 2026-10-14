// Hào quang Bản Năng Vô Cực kiểu anime cho trang chủ:
//  - lửa khí: tấm luôn quay về camera, viền lửa sắc, cuộn lên, vệt tốc độ
//    (một lớp sau lưng nhân vật, một lớp mỏng phía trước)
//  - sấm sét: tia gấp khúc có độ dày thật (lõi trắng + quầng xanh), có nhánh
import * as THREE from 'three'

const flameVert = /* glsl */ `
varying vec2 vUv;
void main() {
  vUv = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}`

const flameFrag = /* glsl */ `
uniform float uTime;
uniform float uAlpha;
uniform float uSeed;
uniform vec3 uOuter;
uniform vec3 uInner;
varying vec2 vUv;
float hash(vec2 p) { return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453); }
float noise(vec2 p) {
  vec2 i = floor(p), f = fract(p);
  f = f * f * (3.0 - 2.0 * f);
  return mix(mix(hash(i), hash(i + vec2(1, 0)), f.x), mix(hash(i + vec2(0, 1)), hash(i + vec2(1, 1)), f.x), f.y);
}
float fbm(vec2 p) { float v = 0.0, a = 0.5; for (int i = 0; i < 4; i++) { v += a * noise(p); p = p * 2.03 + 7.1; a *= 0.5; } return v; }
void main() {
  vec2 p = vUv * 2.0 - 1.0;
  float t = uTime + uSeed;
  // hình giọt lửa quanh thân, ngọn lửa dài hơn ở phía trên
  float d = length(vec2(p.x / 0.58, (p.y + 0.18) / 0.82));
  float ang = atan(p.x, p.y + 0.18);
  float n = fbm(vec2(ang * 2.6 + sin(t * 0.7) * 0.3, d * 2.2 - t * 2.4));
  float tongue = fbm(vec2(p.x * 3.4, p.y * 1.6 - t * 3.2));
  float top = smoothstep(-0.2, 1.0, p.y);
  float edge = 0.9 + (n - 0.5) * 0.5 + top * (tongue - 0.35) * 0.9;
  // viền sắc kiểu anime: 3 dải màu
  float outer = 1.0 - smoothstep(edge - 0.02, edge, d);
  float mid = 1.0 - smoothstep(edge * 0.86 - 0.02, edge * 0.86, d);
  float core = 1.0 - smoothstep(edge * 0.66 - 0.04, edge * 0.66, d);
  // vệt tốc độ chạy lên
  float streak = smoothstep(0.78, 0.95, noise(vec2(p.x * 26.0, p.y * 1.4 - t * 7.0))) * mid;
  // viền ngoài đậm màu, dải giữa sáng hơn, lõi gần như trong suốt (nhìn rõ nhân vật)
  float rimLine = (1.0 - smoothstep(0.0, 0.035, abs(d - edge * 0.86))) * outer;
  vec3 col = uOuter * (outer - mid) + uInner * (mid - core) * 0.8 + vec3(0.9, 0.97, 1.0) * rimLine + vec3(1.0) * streak * 0.6;
  float a = ((outer - mid) * 0.55 + (mid - core) * 0.22 + core * 0.03 + rimLine * 0.55 + streak * 0.35) * uAlpha;
  a *= smoothstep(1.0, 0.75, abs(p.x)) * smoothstep(-1.0, -0.75, p.y);
  gl_FragColor = vec4(col, a);
}`

function flameLayer(w: number, h: number, alpha: number, seed: number) {
  const mat = new THREE.ShaderMaterial({
    vertexShader: flameVert,
    fragmentShader: flameFrag,
    uniforms: {
      uTime: { value: 0 },
      uAlpha: { value: alpha },
      uSeed: { value: seed },
      uOuter: { value: new THREE.Color(0x2f6bff) },
      uInner: { value: new THREE.Color(0x8fc4ff) },
    },
    transparent: true,
    depthWrite: false,
    blending: THREE.AdditiveBlending,
  })
  const m = new THREE.Mesh(new THREE.PlaneGeometry(w, h), mat)
  m.frustumCulled = false
  return m
}

/** Dải tia sét luôn quay về camera, cập nhật trên CPU mỗi lần lóe. */
class BoltRibbons {
  readonly mesh: THREE.Mesh
  private pos: Float32Array
  private count = 0
  constructor(
    private max: number,
    color: number,
    opacity: number,
  ) {
    this.pos = new Float32Array(max * 4 * 3)
    const idx: number[] = []
    for (let i = 0; i < max; i++) idx.push(i * 4, i * 4 + 1, i * 4 + 2, i * 4 + 2, i * 4 + 1, i * 4 + 3)
    const g = new THREE.BufferGeometry()
    g.setAttribute('position', new THREE.BufferAttribute(this.pos, 3))
    g.setIndex(idx)
    this.mesh = new THREE.Mesh(
      g,
      new THREE.MeshBasicMaterial({ color, transparent: true, opacity, blending: THREE.AdditiveBlending, depthWrite: false, side: THREE.DoubleSide }),
    )
    this.mesh.frustumCulled = false
  }
  clear() {
    this.count = 0
  }
  /** Thêm đoạn a-b dày `w`, mặt quay về hướng nhìn `view`. */
  seg(a: THREE.Vector3, b: THREE.Vector3, w: number, view: THREE.Vector3) {
    if (this.count >= this.max) return
    const dir = new THREE.Vector3().subVectors(b, a)
    const side = new THREE.Vector3().crossVectors(dir, view).normalize().multiplyScalar(w / 2)
    const o = this.count * 12
    this.pos.set([a.x - side.x, a.y - side.y, a.z - side.z, a.x + side.x, a.y + side.y, a.z + side.z], o)
    this.pos.set([b.x - side.x, b.y - side.y, b.z - side.z, b.x + side.x, b.y + side.y, b.z + side.z], o + 6)
    this.count++
  }
  commit() {
    this.mesh.geometry.setDrawRange(0, this.count * 6)
    this.mesh.geometry.getAttribute('position').needsUpdate = true
  }
}

export class UltraAura {
  readonly group = new THREE.Group()
  private back = flameLayer(1, 1, 1, 0)
  private back2 = flameLayer(1, 1, 0.7, 17.3)
  private front = flameLayer(1, 1, 0.32, 41.7)
  private core = new BoltRibbons(160, 0xffffff, 1)
  private glow = new BoltRibbons(160, 0x6fb4ff, 0.38)
  private boltTimer = 0
  private flash = 0
  private thin = 1 // co độ dày tia sét khi camera ở gần

  /** `size`: kích thước hào quang (đơn vị thế giới). */
  constructor(private size = 560) {
    this.back.scale.set(size * 0.85, size * 1.15, 1)
    this.back2.scale.set(size * 0.95, size * 1.25, 1)
    this.front.scale.set(size * 0.8, size * 1.05, 1)
    this.back.renderOrder = 9
    this.back2.renderOrder = 8
    this.front.renderOrder = 12
    this.core.mesh.renderOrder = 13
    this.glow.mesh.renderOrder = 12
    this.group.add(this.back2, this.back, this.front, this.glow.mesh, this.core.mesh)
  }

  /**
   * `center`: tâm hào quang (ngực nhân vật, toạ độ thế giới); `body`: bán kính
   * vùng tia sét bò quanh người.
   */
  update(t: number, dt: number, camera: THREE.Camera, center: THREE.Vector3, body = 120) {
    const dist = camera.position.distanceTo(center)
    this.thin = Math.max(0.3, Math.min(1, dist / 800))
    const view = new THREE.Vector3().subVectors(camera.position, center).normalize()
    // lửa: tấm quay về camera, lớp sau đẩy ra sau lưng, lớp trước kéo về phía camera
    const place = (m: THREE.Mesh, push: number, lift: number) => {
      m.position.copy(center).addScaledVector(view, push)
      m.position.z += lift
      m.quaternion.copy(camera.quaternion)
      ;(m.material as THREE.ShaderMaterial).uniforms.uTime.value = t
    }
    place(this.back, -60, this.size * 0.12)
    place(this.back2, -90, this.size * 0.16)
    place(this.front, 70, this.size * 0.08)
    const pulse = 1 + Math.sin(t * 9) * 0.025 + Math.sin(t * 23.7) * 0.015
    this.back.scale.set(this.size * 0.85 * pulse, this.size * 1.15 * pulse, 1)

    // sấm sét: lóe theo cụm, nghỉ ngắt quãng
    this.boltTimer -= dt
    this.flash = Math.max(0, this.flash - dt * 9)
    if (this.boltTimer <= 0) {
      this.core.clear()
      this.glow.clear()
      const burst = Math.random() < 0.72
      this.boltTimer = burst ? 0.05 + Math.random() * 0.07 : 0.12 + Math.random() * 0.25
      if (burst) {
        this.flash = 1
        const n = this.thin < 0.6 ? 1 + Math.floor(Math.random() * 2) : 1 + Math.floor(Math.random() * 3)
        for (let i = 0; i < n; i++) this.bolt(center, body, view, 0)
      }
      this.core.commit()
      this.glow.commit()
    }
    ;(this.core.mesh.material as THREE.MeshBasicMaterial).opacity = 0.55 + this.flash * 0.45
    ;(this.glow.mesh.material as THREE.MeshBasicMaterial).opacity = 0.2 + this.flash * 0.25
  }

  private bolt(center: THREE.Vector3, body: number, view: THREE.Vector3, depth: number, from?: THREE.Vector3, len = 0) {
    const r = () => (Math.random() - 0.5) * 2
    let p = from ? from.clone() : center.clone().add(new THREE.Vector3(r() * body, r() * body, r() * body * 1.2))
    const segs = from ? Math.max(3, len) : 6 + Math.floor(Math.random() * 6)
    const dir = new THREE.Vector3(r(), r(), r() * 1.3).normalize()
    const step = body * (0.16 + Math.random() * 0.1)
    for (let s = 0; s < segs; s++) {
      const q = p.clone().addScaledVector(dir, step).add(new THREE.Vector3(r(), r(), r()).multiplyScalar(step * 0.75))
      const w = (depth ? 1.4 : 2.6) * (1 - s / (segs * 1.6)) * this.thin
      this.core.seg(p, q, w, view)
      this.glow.seg(p, q, w * (2.5 + this.thin * 3), view)
      if (depth < 1 && Math.random() < 0.18) this.bolt(center, body, view, depth + 1, q, 3 + Math.floor(Math.random() * 3))
      p = q
    }
  }
}
