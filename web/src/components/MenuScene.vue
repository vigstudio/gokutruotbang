<script setup lang="ts">
// Cảnh nền 3D của menu (giống tinh thần cảnh tháp Icecrown ở menu Frozen
// Throne): tháp băng có cột sáng, sừng băng cong, mặt băng, rừng thông, sương,
// tuyết rơi; Goku và rồng là model gốc của map render trực tiếp.
import { onBeforeUnmount, onMounted, ref } from 'vue'
import * as THREE from 'three'
import { crystalGeometry, crystalMaterial, lightBeam, makeLights, makeSky, pineGeometry, radialTexture, Snowfall } from '../game3d/env'
import { W3Model } from '../game3d/w3model'
import { KiAura } from '../game3d/aura'
import { UltraAura } from '../game3d/ultraAura'
import { loadProAssets } from '../game3d/proassets'
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js'
import { MeshoptDecoder } from 'three/examples/jsm/libs/meshopt_decoder.module.js'
import { fetchRetry } from '../fetchRetry'

/**
 * Model Goku tuỳ chọn cho trang chủ: đặt file glTF nhị phân tại
 * web/public/assets/menu/goku.glb (cần đúng giấy phép của tác giả).
 * Không có file thì dùng model gốc của map.
 */
/** Trọng số cú cận (0 = toàn cảnh, 1 = cận) theo chu kỳ 30 giây: 16s toàn cảnh,
 *  2s đẩy vào, 10s cận, 2s kéo ra. */
function closeWeight(t: number) {
  const p = t % 30
  const ease = (x: number) => x * x * (3 - 2 * x)
  if (p < 16) return 0
  if (p < 18) return ease((p - 16) / 2)
  if (p < 28) return 1
  return ease(1 - (p - 28) / 2)
}

// Goku Ultra Instinct (bản nén từ Sketchfab); ?ss3 để xem lại bản Super Saiyan 3
const MENU_MODEL = new URLSearchParams(location.search).has('ss3') ? '/assets/menu/goku.glb' : '/assets/menu/goku_ui.glb'
const UI = MENU_MODEL.endsWith('goku_ui.glb')
async function loadCustomGoku(): Promise<{ obj: THREE.Object3D; mixer: THREE.AnimationMixer | null } | null> {
  try {
    const r = await fetchRetry(MENU_MODEL)
    if (!r.ok) return null
    const buf = await r.arrayBuffer()
    if (new TextDecoder().decode(new Uint8Array(buf, 0, 4)) !== 'glTF') return null // server trả index.html
    const gltf = await new GLTFLoader().setMeshoptDecoder(MeshoptDecoder).parseAsync(buf, '/assets/menu/')
    // bọc trong nhóm: inner xoay cho đứng thẳng (Z lên), outer để đặt vị trí/hướng
    const inner = gltf.scene
    // file export từ Sketchfab: xoay X 90° là đứng thẳng (tư thế thế võ)
    // Ultra Instinct: tư thế bay chéo vút lên, nắm đấm duỗi về phía trước (như bản xem trên Sketchfab)
    let best: number[] = UI ? [Math.PI / 2, 0, -Math.PI / 6] : [Math.PI / 2, 0, 0]
    const force = new URLSearchParams(location.search).get('glbrot')
    if (force) best = force.split(',').map((v) => (Number(v) * Math.PI) / 180)
    inner.rotation.set(best[0], best[1] ?? 0, best[2] ?? 0)
    inner.updateMatrixWorld(true)
    // đặt chân xuống z = 0, căn giữa
    const b0 = new THREE.Box3().setFromObject(inner)
    const c0 = b0.getCenter(new THREE.Vector3())
    inner.position.set(-c0.x, -c0.y, -b0.min.z)
    const obj = new THREE.Group()
    obj.add(inner)
    obj.updateMatrixWorld(true)
    const box = new THREE.Box3().setFromObject(obj)
    const size = box.getSize(new THREE.Vector3())
    const s = 330 / Math.max(size.z, 1) // cao ~330 đơn vị
    obj.scale.setScalar(s)
    obj.traverse((o) => {
      const mesh = o as THREE.Mesh
      if (!mesh.isMesh) return
      mesh.castShadow = mesh.receiveShadow = true
      // bản scan khai báo metallic: không có gì để phản chiếu nên gần như đen
      const mats = Array.isArray(mesh.material) ? mesh.material : [mesh.material]
      for (const m of mats) {
        const sm = m as THREE.MeshStandardMaterial
        if (sm.isMeshStandardMaterial) {
          // giống bản xem trên Sketchfab: bề mặt tượng bóng, không bị sương phủ
          sm.metalness = 0
          sm.roughness = 0.36
          sm.envMapIntensity = 1.5
          sm.fog = false
          // tóc vàng tự phát sáng nhẹ (màu càng vàng càng sáng)
          sm.onBeforeCompile = (sh) => {
            sh.fragmentShader = sh.fragmentShader.replace(
              '#include <emissivemap_fragment>',
              `#include <emissivemap_fragment>
              ${UI
                ? `// tóc bạc: sáng, ít bão hoà -> phát sáng nhẹ ánh xanh
              float mx = max(diffuseColor.r, max(diffuseColor.g, diffuseColor.b));
              float mn = min(diffuseColor.r, min(diffuseColor.g, diffuseColor.b));
              float sil = smoothstep(0.28, 0.62, mn) * (1.0 - smoothstep(0.1, 0.28, mx - mn));
              totalEmissiveRadiance += vec3(0.78, 0.88, 1.0) * sil * 0.85;`
                : `float yel = smoothstep(0.25, 0.6, diffuseColor.r + diffuseColor.g - 1.6 * diffuseColor.b);
              totalEmissiveRadiance += diffuseColor.rgb * yel * 0.55;`}`,
            )
          }
        }
      }
    })
    let mixer: THREE.AnimationMixer | null = null
    if (gltf.animations.length) {
      mixer = new THREE.AnimationMixer(obj)
      mixer.clipAction(gltf.animations[0]).play()
    }
    return { obj, mixer }
  } catch (e) {
    console.warn('Không đọc được model trang chủ:', e)
    return null
  }
}

const props = withDefaults(defineProps<{ focus?: 'left' | 'center' }>(), { focus: 'left' })
const cv = ref<HTMLCanvasElement>()
let raf = 0
let renderer: THREE.WebGLRenderer | null = null

function hash(x: number, y: number) {
  const s = Math.sin(x * 12.9898 + y * 78.233) * 43758.5453
  return s - Math.floor(s)
}
function noise(x: number, y: number) {
  const xi = Math.floor(x)
  const yi = Math.floor(y)
  const xf = x - xi
  const yf = y - yi
  const u = xf * xf * (3 - 2 * xf)
  const v = yf * yf * (3 - 2 * yf)
  const a = hash(xi, yi)
  const b = hash(xi + 1, yi)
  const c = hash(xi, yi + 1)
  const d = hash(xi + 1, yi + 1)
  return a + (b - a) * u + (c - a) * v + (a - b - c + d) * u * v
}
function fbm(x: number, y: number) {
  return noise(x, y) * 0.5 + noise(x * 2.03, y * 2.03) * 0.25 + noise(x * 4.1, y * 4.1) * 0.15 + noise(x * 8.3, y * 8.3) * 0.1
}

/** Sừng băng cong, thon dần: hình nón uốn cong bằng cách dịch đỉnh theo độ cao. */
function hornGeometry(len: number, r0: number, bend: number, twist = 0) {
  const prof: THREE.Vector2[] = []
  for (let i = 0; i <= 24; i++) {
    const t = i / 24
    prof.push(new THREE.Vector2(Math.max(0.5, r0 * Math.pow(1 - t, 1.3)), t * len))
  }
  const g = new THREE.LatheGeometry(prof, 14).rotateX(Math.PI / 2)
  const p = g.getAttribute('position')
  for (let i = 0; i < p.count; i++) {
    const z = p.getZ(i)
    const t = Math.max(0, Math.min(1, z / len))
    p.setX(i, p.getX(i) + bend * t * t)
    p.setY(i, p.getY(i) + twist * t * t)
  }
  g.computeVertexNormals()
  return g
}

/** Tháp băng xoắn kiểu Icecrown. */
function spireGeometry() {
  const pts: THREE.Vector2[] = []
  const H = 2200
  for (let i = 0; i <= 40; i++) {
    const t = i / 40
    const r = 520 * Math.pow(1 - t, 1.6) + 40 + Math.sin(t * 22) * 30 * (1 - t) + (t > 0.9 ? -30 * (t - 0.9) * 10 : 0)
    pts.push(new THREE.Vector2(Math.max(8, r), t * H))
  }
  const g = new THREE.LatheGeometry(pts, 28).rotateX(Math.PI / 2)
  const p = g.getAttribute('position')
  for (let i = 0; i < p.count; i++) {
    const x = p.getX(i)
    const y = p.getY(i)
    const z = p.getZ(i)
    const tw = (z / H) * 2.2 // xoắn
    const n = 1 + (fbm(Math.atan2(y, x) * 2 + z / 300, z / 200) - 0.5) * 0.35
    const c = Math.cos(tw)
    const s = Math.sin(tw)
    p.setXYZ(i, (x * c - y * s) * n, (x * s + y * c) * n, z)
  }
  g.computeVertexNormals()
  return g
}

const DBG = new URLSearchParams(location.search)
onMounted(async () => {
  const canvas = cv.value!
  const r = new THREE.WebGLRenderer({ canvas, antialias: true })
  renderer = r
  r.setPixelRatio(Math.min(window.devicePixelRatio, 1.5))
  r.shadowMap.enabled = true
  r.shadowMap.type = THREE.PCFSoftShadowMap
  r.toneMapping = THREE.ACESFilmicToneMapping
  r.toneMappingExposure = 1.1

  const scene = new THREE.Scene()
  const fogCol = new THREE.Color(0x8f98c4)
  scene.background = fogCol
  scene.fog = new THREE.FogExp2(fogCol, 0.00022)
  scene.environment = makeSky(r).env
  loadProAssets(r).then((p) => (scene.environment = p.env)).catch(() => {})
  const { sun } = makeLights(scene, 3000)
  sun.position.set(-1600, 2600, 2400)
  sun.target.position.set(0, 1200, 0)
  sun.color.set(0xe6e8ff)

  const camera = new THREE.PerspectiveCamera(48, 1, 20, 30000)
  camera.up.set(0, 0, 1)

  // mặt đất tuyết gợn đồi
  const hillAt = (x: number, y: number) => {
    const d = Math.hypot(x, y - 1800)
    const k = Math.min(1, Math.max(0, (d - 3200) / 4000))
    return fbm(x / 2600, y / 2600) * 700 * k * k + fbm(x / 350, y / 350) * 45 - 22
  }
  const ground = new THREE.PlaneGeometry(22000, 22000, 220, 220)
  const gp = ground.getAttribute('position')
  const gcol = new Float32Array(gp.count * 3)
  for (let i = 0; i < gp.count; i++) {
    const x = gp.getX(i)
    const y = gp.getY(i)
    gp.setZ(i, hillAt(x, y))
    // tuyết có chỗ sáng chỗ xanh xám (gió thổi, bóng mây)
    const v = fbm(x / 900 + 3, y / 900)
    const c = 0.72 + v * 0.3
    gcol[i * 3] = c * 0.9
    gcol[i * 3 + 1] = c * 0.95
    gcol[i * 3 + 2] = c * 1.05
  }
  ground.setAttribute('color', new THREE.BufferAttribute(gcol, 3))
  ground.computeVertexNormals()
  const snowMat = new THREE.MeshStandardMaterial({ color: 0xffffff, vertexColors: true, roughness: 0.95 })
  const groundMesh = new THREE.Mesh(ground, snowMat)
  groundMesh.receiveShadow = true
  if (!DBG.has('noground')) scene.add(groundMesh)

  // hồ băng phẳng phản chiếu
  const lake = new THREE.Mesh(
    new THREE.CircleGeometry(1900, 64),
    new THREE.MeshPhysicalMaterial({ color: 0x8fb4d8, roughness: 0.04, metalness: 0.1, clearcoat: 1, envMapIntensity: 1.6 }),
  )
  lake.position.set(-200, 900, 2)
  lake.receiveShadow = true
  if (!DBG.has('nolake')) scene.add(lake)

  // tháp băng + cột sáng
  const spireMat = new THREE.MeshStandardMaterial({ color: 0xc9d3e6, roughness: 0.55, metalness: 0.05, flatShading: true })
  const spire = new THREE.Mesh(spireGeometry(), spireMat)
  spire.position.set(200, 2600, 0)
  spire.castShadow = true
  spire.receiveShadow = true
  if (!DBG.has('nospire')) scene.add(spire)
  const beam = lightBeam(0xb9b4ff, 9000, 160)
  beam.position.set(200, 2600, 2000)
  if (!DBG.has('nobeam')) scene.add(beam)
  const halo = new THREE.Sprite(new THREE.SpriteMaterial({ map: radialTexture('rgba(235,230,255,1)', 'rgba(180,170,255,0)'), blending: THREE.AdditiveBlending, depthWrite: false }))
  halo.scale.set(1400, 1400, 1)
  halo.position.set(200, 2600, 2150)
  if (!DBG.has('nohalo')) scene.add(halo)
  const topLight = new THREE.PointLight(0xc8c0ff, 30, 5000, 1.2)
  topLight.position.set(200, 2600, 2100)
  scene.add(topLight)

  // sừng băng cong khổng lồ quanh tháp
  const hornMat = new THREE.MeshStandardMaterial({ color: 0xb4c2d8, roughness: 0.35, metalness: 0.05, envMapIntensity: 1.2 })
  const rnd = (() => {
    let s = 99
    return () => ((s = (s * 1664525 + 1013904223) >>> 0) / 4294967296)
  })()
  for (let i = 0; i < 16; i++) {
    const a = (i / 16) * Math.PI * 2 + rnd() * 0.3
    const dist = 1500 + rnd() * 1600
    const len = 900 + rnd() * 1300
    const h = new THREE.Mesh(hornGeometry(len, 80 + rnd() * 70, (rnd() - 0.5) * len * 0.3, (rnd() - 0.5) * 160), hornMat)
    h.position.set(200 + Math.cos(a) * dist, 2600 + Math.sin(a) * dist, -40)
    h.rotation.z = a + Math.PI
    h.castShadow = false
    if (!DBG.has('nohorn')) scene.add(h)
  }

  // tinh thể băng tiền cảnh
  const cMat = crystalMaterial()
  const crystals: [number, number, number][] = [
    [-1300, -400, 260], [-900, -150, 180], [700, -300, 220], [1100, 200, 320], [-1600, 600, 380], [1500, 900, 300], [-400, 300, 120], [400, 500, 140],
  ]
  crystals.forEach(([x, y, s], i) => {
    const c = new THREE.Mesh(crystalGeometry(i + 3, 5), cMat)
    c.position.set(x, y, 0)
    c.scale.set(s, s, s * 1.2)
    c.castShadow = true
    if (!DBG.has('nocrystal')) scene.add(c)
  })

  // tảng đá cho Goku đứng
  const rock = new THREE.Mesh(new THREE.DodecahedronGeometry(120, 1), new THREE.MeshStandardMaterial({ color: 0x6a7488, roughness: 0.85, flatShading: true }))
  rock.scale.set(1.4, 1.2, 0.55)
  rock.position.set(-520, -620, 10)
  rock.castShadow = rock.receiveShadow = true
  if (!DBG.has('norock')) scene.add(rock)

  // rừng thông trên đồi xa
  const pineMat = new THREE.MeshStandardMaterial({ vertexColors: true, roughness: 0.92 })
  const pines = new THREE.InstancedMesh(pineGeometry(5), pineMat, 260)
  const dmy = new THREE.Object3D()
  for (let i = 0; i < 260; i++) {
    const a = rnd() * Math.PI * 2
    const d = 3200 + rnd() * 4000
    const x = Math.cos(a) * d
    const y = 1800 + Math.sin(a) * d
    if (y < -800) {
      i--
      continue
    }
    const z = hillAt(x, y) - 10
    const s = 1.4 + rnd() * 1.6
    dmy.position.set(x, y, z)
    dmy.rotation.set(0, 0, rnd() * 6.28)
    dmy.scale.set(s, s, s)
    dmy.updateMatrix()
    pines.setMatrixAt(i, dmy.matrix)
  }
  pines.castShadow = true
  if (!DBG.has('nopine')) scene.add(pines)

  const GX = -520
  const GY = -620
  const GZ = 64
  const aura = new KiAura(330, UI)
  aura.group.position.set(GX, GY, GZ)
  scene.add(aura.group)
  // Ultra Instinct: hào quang lửa anime + sấm sét bám theo ngực nhân vật
  const ultra = UI ? new UltraAura(560) : null
  if (ultra) {
    aura.minimal()
    scene.add(ultra.group)
  }
  // điểm nhìn của camera cận (toạ độ riêng của model: giữa mặt và ngực)
  const LOOK = new THREE.Vector3(-20, -20, 142)
  // hướng quay của Goku khi cận cảnh (độ) và độ lệch khung hình sang trái
  const YAW = Number(DBG.get('yaw') ?? 60)
  const SHIFT = Number(DBG.get('shift') ?? 0.14)
  const CHEST = new THREE.Vector3(-12, -9, 128)

  const snow = new Snowfall(3000, 5000, 2500)
  if (!DBG.has('nosnow')) scene.add(snow.points)

  // model gốc: Goku + rồng
  const gl = r.getContext()
  let goku: W3Model | null = null
  let dragon: W3Model | null = null
  const dbg = new URLSearchParams(location.search)
  let custom: Awaited<ReturnType<typeof loadCustomGoku>> = null
  loadCustomGoku().then((c) => {
    if (c) {
      custom = c
      c.obj.position.set(GX, GY, UI ? GZ + 40 : GZ - 4) // bản UI đang bay: nâng khỏi tảng đá
      const gz = Number(new URLSearchParams(location.search).get('glbz') ?? 'NaN')
      c.obj.rotation.z = ((Number.isFinite(gz) ? gz : UI ? 130 : 300) * Math.PI) / 180
      // đèn riêng cho Goku: rọi chính diện ấm + viền xanh băng phía sau
      // ánh sáng kiểu studio: đèn chính ấm, đèn hắt, đèn viền vàng phía sau
      const key = new THREE.SpotLight(0xfff1dc, 22, 2600, 0.55, 0.5, 1.0)
      key.position.set(GX - 700, GY - 1300, GZ + 900)
      key.target = c.obj
      const fill = new THREE.SpotLight(0xbfd8ff, 9, 2400, 0.7, 0.8, 1.0)
      fill.position.set(GX + 900, GY - 900, GZ + 400)
      fill.target = c.obj
      const rim = new THREE.SpotLight(0xffc860, 26, 2000, 0.6, 0.6, 1.0)
      rim.position.set(GX + 250, GY + 700, GZ + 650)
      rim.target = c.obj
      scene.add(key, fill, rim)
      scene.add(c.obj)
      // ?dbg: mở đối tượng cảnh ra console để căn chỉnh camera / hiệu ứng
      if (DBG.has('dbg')) (window as unknown as Record<string, unknown>).__menu = { THREE, camera, scene, renderer: r, goku: c.obj }
    } else if (!dbg.has('nogoku')) {
      W3Model.load(gl, 'war3mapImported/zMidouz.mdx').then((m) => (goku = m)).catch(() => {})
    }
  })
  if (!dbg.has('nodragon')) W3Model.load(gl, 'war3mapImported/ChineseDragon.mdx').then((m) => (dragon = m)).catch(() => {})

  const resize = () => {
    const w = canvas.clientWidth
    const h = canvas.clientHeight
    if (canvas.width !== Math.floor(w * r.getPixelRatio()) || canvas.height !== Math.floor(h * r.getPixelRatio())) {
      r.setSize(w, h, false)
      camera.aspect = w / h
      camera.updateProjectionMatrix()
    }
  }
  let prev = performance.now()
  const loop = (now: number) => {
    raf = requestAnimationFrame(loop)
    resize()
    const t = now / 1000
    const dt = Math.min(0.1, (now - prev) / 1000)
    prev = now
    // camera trôi chậm
    if (UI && custom && !DBG.has('closeup')) {
      // chuỗi cú máy: lượn toàn cảnh -> đẩy vào cận nửa thân trên -> kéo ra
      const base = (246 * Math.PI) / 180
      const o = custom.obj
      const portrait = camera.aspect < 1
      const c = DBG.has('wide') ? 0 : DBG.has('close') ? 1 : closeWeight(t)
      // cú toàn cảnh
      const thW = base + Math.sin(t * 0.085) * 1.15
      const R = 820 + Math.sin(t * 0.13 + 1) * 240
      // cú cận (lượn hẹp hơn, đẩy vào kéo ra, rung tay máy)
      const thC = base + Math.sin(t * 0.11) * 0.42
      const th = thW + (thC - thW) * c
      o.rotation.z = (120 * Math.PI) / 180 + ((YAW - 120) * Math.PI / 180) * c + (th - base) * 0.9
      o.position.z = GZ + 40 + Math.sin(t * 1.6) * 10
      o.updateMatrixWorld(true)
      const T = o.localToWorld(LOOK.clone())
      const D = (portrait ? 420 : 300) + Math.sin(t * 0.17) * 55
      const wide = new THREE.Vector3(GX + Math.cos(thW) * R, GY + Math.sin(thW) * R, GZ + 230 + Math.sin(t * 0.1) * 150)
      const close = new THREE.Vector3(T.x + Math.cos(thC) * D, T.y + Math.sin(thC) * D, T.z - 25 + Math.sin(t * 0.13) * 30)
      close.add(new THREE.Vector3(Math.sin(t * 1.9) * 2.5 + Math.sin(t * 4.7) * 0.8, Math.sin(t * 2.3) * 2.5, Math.sin(t * 1.3) * 2))
      camera.position.copy(wide).lerp(close, c)
      // điểm nhìn: toàn cảnh nhìn cả người (đẩy Goku sang trái, bảng menu bên phải), cận nhìn mặt-ngực
      const fwd = new THREE.Vector3(GX - camera.position.x, GY - camera.position.y, 0).normalize()
      const right = new THREE.Vector3(fwd.y, -fwd.x, 0)
      const wideShift = portrait ? 0 : props.focus === 'center' ? -R * 0.04 : R * 0.2
      const closeShift = portrait ? 0 : props.focus === 'center' ? 0 : D * SHIFT
      const lookW = new THREE.Vector3(GX + right.x * wideShift, GY + right.y * wideShift, GZ + (portrait ? -70 : 175) + Math.sin(t * 0.2) * 20)
      const lookC = new THREE.Vector3(T.x + right.x * closeShift, T.y + right.y * closeShift, T.z + (portrait ? -95 : 0))
      camera.lookAt(lookW.lerp(lookC, c))
      camera.fov = 46 + Math.sin(t * 0.11) * 3 + (40 - 46) * c
      camera.updateProjectionMatrix()
    } else if (DBG.has('closeup')) {
      camera.position.set(-520 - 300, -620 - 700, 260)
      camera.lookAt(-520, -620, 160)
    } else {
      // camera lượn vòng cung trước mặt Goku, xa gần + cao thấp nhịp nhàng
      const base = (246 * Math.PI) / 180
      const th = base + Math.sin(t * 0.085) * 1.15
      const R = 820 + Math.sin(t * 0.13 + 1) * 240
      const H = 230 + Math.sin(t * 0.1) * 150
      camera.position.set(GX + Math.cos(th) * R, GY + Math.sin(th) * R, GZ + H)
      // Goku Ultra Instinct xoay người theo camera để luôn hướng mặt về người xem
      // (góc 120° là chính diện khi camera ở góc gốc 246°), nhấp nhô như đang bay
      if (custom && UI && !DBG.has('glbz')) {
        custom.obj.rotation.z = (120 * Math.PI) / 180 + (th - base) * 0.9
        custom.obj.position.z = GZ + 40 + Math.sin(t * 1.6) * 12
      }
      // đẩy Goku sang trái khung hình (bên phải là bảng menu)
      const fwd = new THREE.Vector3(GX - camera.position.x, GY - camera.position.y, 0).normalize()
      const right = new THREE.Vector3(fwd.y, -fwd.x, 0)
      // trang đăng nhập: Goku bên trái; sảnh/phòng chờ: Goku giữa hai khung
      // màn dọc (điện thoại): Goku giữa, nằm nửa trên vì khung đăng nhập ở dưới
      const portrait = camera.aspect < 1
      const shift = portrait ? 0 : props.focus === 'center' ? -R * 0.04 : R * (UI ? 0.2 : 0.32)
      camera.lookAt(GX + right.x * shift, GY + right.y * shift, GZ + (portrait ? -70 : 175) + Math.sin(t * 0.2) * 20)
      camera.fov = 46 + Math.sin(t * 0.11) * 3
      camera.updateProjectionMatrix()
    }
    camera.updateMatrixWorld()
    ;(beam.material as THREE.MeshBasicMaterial).opacity = 0.65 + Math.sin(t * 1.3) * 0.15
    halo.material.opacity = 0.8 + Math.sin(t * 1.7) * 0.15
    snow.update(dt, camera.position.x, camera.position.y + 1200, t)
    custom?.mixer?.update(dt)
    aura.update(t, dt)
    if (ultra && custom) ultra.update(t, dt, camera, custom.obj.localToWorld(CHEST.clone()), 115)
    r.render(scene, camera)

    if (goku || dragon) {
      r.resetState()
      gl.enable(gl.DEPTH_TEST)
      gl.depthFunc(gl.LEQUAL)
      gl.depthMask(true)
      const view = camera.matrixWorldInverse.elements
      const proj = camera.projectionMatrix.elements
      if (goku) {
        goku.pose('Stand - 1', now, 40)
        goku.draw(view, proj, GX, GY, GZ, 238, 1.7)
      }
      if (dragon) {
        for (let i = 0; i < 3; i++) {
          const a = t * (0.16 + i * 0.03) + i * 2.1
          const rad = 1300 + i * 380
          const x = 200 + Math.cos(a) * rad
          const y = 2600 + Math.sin(a) * rad
          const z = 700 + i * 260 + Math.sin(t * 0.8 + i) * 80
          dragon.pose('Walk', now + i * 333, 24)
          dragon.draw(view, proj, x, y, z, ((a + Math.PI / 2) * 180) / Math.PI, 3.2 - i * 0.4)
        }
      }
      r.resetState()
    }
  }
  raf = requestAnimationFrame(loop)
})

onBeforeUnmount(() => {
  cancelAnimationFrame(raf)
  renderer?.dispose()
  renderer?.forceContextLoss()
})
</script>

<template>
  <canvas ref="cv" class="menu-scene" aria-hidden="true"></canvas>
</template>

<style scoped>
.menu-scene { position: fixed; inset: 0; width: 100%; height: 100%; display: block; }
</style>
