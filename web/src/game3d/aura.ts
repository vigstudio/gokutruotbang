// Hiệu ứng khí (nội công) Super Saiyan cho trang chủ: vỏ hào quang lửa vàng,
// hạt khí bay lên, tia điện SS3, sao lấp lánh, vầng sáng dưới chân.
// Toạ độ Z hướng lên, gốc tại chân nhân vật.
import * as THREE from 'three'

const auraVert = /* glsl */ `
varying vec3 vPos;
varying vec3 vNormalV;
varying vec3 vViewDir;
void main() {
  vPos = position;
  vec4 mv = modelViewMatrix * vec4(position, 1.0);
  vNormalV = normalize(normalMatrix * normal);
  vViewDir = normalize(-mv.xyz);
  gl_Position = projectionMatrix * mv;
}`

const auraFrag = /* glsl */ `
uniform float uTime;
uniform vec3 uColor;
uniform vec3 uCore;
varying vec3 vPos;
varying vec3 vNormalV;
varying vec3 vViewDir;
float hash(vec3 p) { return fract(sin(dot(p, vec3(12.9898, 78.233, 37.719))) * 43758.5453); }
float noise(vec3 p) {
  vec3 i = floor(p); vec3 f = fract(p);
  f = f * f * (3.0 - 2.0 * f);
  float n000 = hash(i), n100 = hash(i + vec3(1,0,0)), n010 = hash(i + vec3(0,1,0)), n110 = hash(i + vec3(1,1,0));
  float n001 = hash(i + vec3(0,0,1)), n101 = hash(i + vec3(1,0,1)), n011 = hash(i + vec3(0,1,1)), n111 = hash(i + vec3(1,1,1));
  return mix(mix(mix(n000,n100,f.x), mix(n010,n110,f.x), f.y), mix(mix(n001,n101,f.x), mix(n011,n111,f.x), f.y), f.z);
}
float fbm(vec3 p) { float v = 0.0; float a = 0.5; for (int i = 0; i < 4; i++) { v += a * noise(p); p *= 2.07; a *= 0.5; } return v; }
void main() {
  // ngọn lửa bốc lên theo trục Z
  vec3 p = vPos * 0.018 + vec3(0.0, 0.0, -uTime * 1.6);
  float flame = fbm(p + fbm(p * 1.7 + uTime * 0.3));
  float h = clamp(vPos.z / 420.0, 0.0, 1.0);
  float rim = pow(1.0 - abs(dot(vNormalV, vViewDir)), 1.6);
  float a = smoothstep(0.48, 0.86, flame) * (0.06 + rim * rim * 1.4) * (1.0 - h * 0.55);
  a *= smoothstep(0.0, 0.08, h);
  vec3 col = mix(uColor, uCore, smoothstep(0.6, 0.95, flame));
  gl_FragColor = vec4(col * (1.2 + rim), a);
}`

const partVert = /* glsl */ `
attribute float aSeed;
uniform float uTime;
uniform float uScale;
varying float vAlpha;
varying float vHot;
void main() {
  float life = fract(uTime * (0.35 + aSeed * 0.4) + aSeed * 7.0);
  vec3 p = position;
  float ang = aSeed * 50.0 + uTime * (0.6 + aSeed);
  p.x += cos(ang) * 10.0 * life;
  p.y += sin(ang) * 10.0 * life;
  p.z += life * (220.0 + aSeed * 160.0);
  vAlpha = sin(life * 3.14159) * (0.55 + 0.45 * sin(uTime * 23.0 + aSeed * 90.0));
  vHot = aSeed;
  vec4 mv = modelViewMatrix * vec4(p, 1.0);
  gl_PointSize = uScale * (4.0 + aSeed * 6.0) / -mv.z;
  gl_Position = projectionMatrix * mv;
}`

const partFrag = /* glsl */ `
varying float vAlpha;
varying float vHot;
void main() {
  vec2 c = gl_PointCoord - 0.5;
  float d = length(c);
  float core = smoothstep(0.5, 0.0, d);
  // tia sáng hình chữ thập cho hạt lấp lánh
  float cross = max(smoothstep(0.08, 0.0, abs(c.x)) * smoothstep(0.5, 0.1, abs(c.y)), smoothstep(0.08, 0.0, abs(c.y)) * smoothstep(0.5, 0.1, abs(c.x)));
  float a = (core * core + cross * 0.6 * step(0.9, vHot)) * vAlpha * 0.85;
  vec3 col = mix(vec3(1.0, 0.78, 0.25), vec3(1.0, 0.98, 0.85), core);
  gl_FragColor = vec4(col, a);
}`

function starTexture() {
  const cv = document.createElement('canvas')
  cv.width = cv.height = 64
  const ctx = cv.getContext('2d')!
  const g = ctx.createRadialGradient(32, 32, 0, 32, 32, 32)
  g.addColorStop(0, 'rgba(255,255,255,1)')
  g.addColorStop(0.15, 'rgba(255,240,200,0.9)')
  g.addColorStop(1, 'rgba(255,200,80,0)')
  ctx.fillStyle = g
  ctx.fillRect(0, 0, 64, 64)
  ctx.strokeStyle = 'rgba(255,255,240,0.9)'
  ctx.lineWidth = 2
  ctx.beginPath()
  ctx.moveTo(32, 0)
  ctx.lineTo(32, 64)
  ctx.moveTo(0, 32)
  ctx.lineTo(64, 32)
  ctx.stroke()
  return new THREE.CanvasTexture(cv)
}

export class KiAura {
  group = new THREE.Group()
  private shell: THREE.Mesh
  private shell2: THREE.Mesh
  private parts: THREE.Points
  private bolts: THREE.LineSegments
  private stars: THREE.Sprite[] = []
  private light: THREE.PointLight
  private ground: THREE.Mesh
  private boltTimer = 0

  /** silver: hào quang Bản Năng Vô Cực (trắng bạc ánh xanh) thay cho vàng SS. */
  constructor(private height = 330, silver = false) {
    const k = height / 330
    // vỏ hào quang (2 lớp lệch pha)
    const mkShell = (r: number, col: number, core: number) => {
      const mat = new THREE.ShaderMaterial({
        vertexShader: auraVert,
        fragmentShader: auraFrag,
        uniforms: { uTime: { value: 0 }, uColor: { value: new THREE.Color(col) }, uCore: { value: new THREE.Color(core) } },
        transparent: true,
        depthWrite: false,
        blending: THREE.AdditiveBlending,
        side: THREE.DoubleSide,
      })
      const geo = new THREE.SphereGeometry(1, 48, 32)
      const pos = geo.getAttribute('position')
      for (let i = 0; i < pos.count; i++) {
        let x = pos.getX(i)
        let y = pos.getY(i)
        let z = pos.getZ(i)
        // hình giọt lửa: rộng ở dưới, nhọn ở trên
        const t = (z + 1) / 2
        const w = Math.sin(Math.min(1, t * 1.15) * Math.PI) * (1 - t * 0.35) + 0.05
        x *= w * r * 1.0
        y *= w * r * 0.8
        z = t * height * 1.25
        pos.setXYZ(i, x, y, z)
      }
      geo.computeVertexNormals()
      const m = new THREE.Mesh(geo, mat)
      m.renderOrder = 10
      return m
    }
    this.shell = silver ? mkShell(170 * k, 0x6fa8ff, 0xf2f8ff) : mkShell(170 * k, 0xffa020, 0xfff2b0)
    this.shell2 = silver ? mkShell(200 * k, 0x4a78e8, 0xd8eaff) : mkShell(200 * k, 0xff7a10, 0xffe080)
    this.shell2.rotation.z = 1.3
    this.group.add(this.shell, this.shell2)

    // hạt khí bay lên
    const N = 320
    const pos = new Float32Array(N * 3)
    const seed = new Float32Array(N)
    for (let i = 0; i < N; i++) {
      const a = Math.random() * Math.PI * 2
      const rr = (50 + Math.random() * 120) * k
      pos[i * 3] = Math.cos(a) * rr
      pos[i * 3 + 1] = Math.sin(a) * rr * 0.8
      pos[i * 3 + 2] = Math.random() * height * 0.7
      seed[i] = Math.random()
    }
    const pg = new THREE.BufferGeometry()
    pg.setAttribute('position', new THREE.BufferAttribute(pos, 3))
    pg.setAttribute('aSeed', new THREE.BufferAttribute(seed, 1))
    this.parts = new THREE.Points(
      pg,
      new THREE.ShaderMaterial({
        vertexShader: partVert,
        fragmentShader: silver ? partFrag.replace('vec3(1.0, 0.78, 0.25)', 'vec3(0.55, 0.75, 1.0)') : partFrag,
        uniforms: { uTime: { value: 0 }, uScale: { value: 900 } },
        transparent: true,
        depthWrite: false,
        blending: THREE.AdditiveBlending,
      }),
    )
    this.parts.frustumCulled = false
    this.parts.renderOrder = 11
    this.group.add(this.parts)

    // tia điện SS3
    const bg = new THREE.BufferGeometry()
    bg.setAttribute('position', new THREE.BufferAttribute(new Float32Array(3 * 2 * 60), 3))
    this.bolts = new THREE.LineSegments(
      bg,
      new THREE.LineBasicMaterial({ color: 0xcfe9ff, transparent: true, opacity: 0.95, blending: THREE.AdditiveBlending, depthWrite: false }),
    )
    this.bolts.frustumCulled = false
    this.group.add(this.bolts)

    // sao lấp lánh
    const tex = starTexture()
    for (let i = 0; i < 6; i++) {
      const sp = new THREE.Sprite(new THREE.SpriteMaterial({ map: tex, blending: THREE.AdditiveBlending, depthWrite: false, transparent: true }))
      sp.userData.seed = Math.random() * 100
      this.stars.push(sp)
      this.group.add(sp)
    }

    // vầng sáng dưới chân + đèn vàng
    const gcv = document.createElement('canvas')
    gcv.width = gcv.height = 128
    const gctx = gcv.getContext('2d')!
    const gg = gctx.createRadialGradient(64, 64, 0, 64, 64, 64)
    gg.addColorStop(0, silver ? 'rgba(200,225,255,0.85)' : 'rgba(255,220,120,0.85)')
    gg.addColorStop(0.4, silver ? 'rgba(110,160,255,0.35)' : 'rgba(255,170,40,0.35)')
    gg.addColorStop(1, silver ? 'rgba(90,140,255,0)' : 'rgba(255,150,30,0)')
    gctx.fillStyle = gg
    gctx.fillRect(0, 0, 128, 128)
    this.ground = new THREE.Mesh(
      new THREE.CircleGeometry(320 * k, 48),
      new THREE.MeshBasicMaterial({ map: new THREE.CanvasTexture(gcv), transparent: true, depthWrite: false, blending: THREE.AdditiveBlending }),
    )
    this.ground.position.z = 3
    this.group.add(this.ground)
    this.light = new THREE.PointLight(silver ? 0x9cc4ff : 0xffb040, 12, 900 * k, 1.5)
    this.light.position.set(0, 0, height * 0.55)
    this.group.add(this.light)
  }

  update(t: number, dt: number) {
    ;(this.shell.material as THREE.ShaderMaterial).uniforms.uTime.value = t
    ;(this.shell2.material as THREE.ShaderMaterial).uniforms.uTime.value = t * 1.2 + 10
    ;(this.parts.material as THREE.ShaderMaterial).uniforms.uTime.value = t
    const pulse = 1 + Math.sin(t * 6) * 0.03 + Math.sin(t * 13.7) * 0.02
    this.shell.scale.set(pulse, pulse, 1)
    this.shell2.scale.set(pulse * 1.02, pulse * 1.02, 1)
    this.light.intensity = 10 + Math.sin(t * 9) * 2.5 + Math.random() * 1.5
    ;(this.ground.material as THREE.MeshBasicMaterial).opacity = 0.75 + Math.sin(t * 5) * 0.15

    // tia điện: vẽ lại vài đường gấp khúc mỗi ~70ms
    this.boltTimer -= dt
    if (this.boltTimer <= 0) {
      this.boltTimer = 0.05 + Math.random() * 0.08
      const arr = (this.bolts.geometry.getAttribute('position') as THREE.BufferAttribute).array as Float32Array
      arr.fill(0)
      let w = 0
      const n = Math.random() < 0.65 ? 1 + Math.floor(Math.random() * 3) : 0
      for (let b = 0; b < n; b++) {
        const a = Math.random() * Math.PI * 2
        let x = Math.cos(a) * (40 + Math.random() * 60)
        let y = Math.sin(a) * (30 + Math.random() * 50)
        let z = 60 + Math.random() * this.height * 0.8
        for (let s = 0; s < 10 && w < 60; s++) {
          const nx = x + (Math.random() - 0.5) * 50
          const ny = y + (Math.random() - 0.5) * 40
          const nz = z + (Math.random() - 0.3) * 45
          arr.set([x, y, z, nx, ny, nz], w * 6)
          w++
          x = nx
          y = ny
          z = nz
        }
      }
      this.bolts.geometry.getAttribute('position').needsUpdate = true
    }

    // sao lấp lánh: hiện ra rồi tắt ở vị trí ngẫu nhiên quanh người
    for (const sp of this.stars) {
      const sd = sp.userData.seed as number
      const ph = (t * 0.9 + sd) % 1
      if (ph < 0.02 || sp.userData.ph === undefined) {
        const a = Math.random() * Math.PI * 2
        sp.position.set(Math.cos(a) * (60 + Math.random() * 120), Math.sin(a) * (50 + Math.random() * 90), 30 + Math.random() * this.height)
      }
      sp.userData.ph = ph
      const s = Math.max(0, Math.sin(ph * Math.PI)) ** 3 * 34
      sp.scale.set(s, s, 1)
      sp.material.rotation = t * 2 + sd
    }
  }
}
