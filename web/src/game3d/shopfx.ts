// Quán Krusty Krab, hộp quà trên băng và quầng Khiên Băng quanh Goku.
import * as THREE from 'three'
import { radialTexture } from './env'

function signTexture(text: string) {
  const cv = document.createElement('canvas')
  cv.width = 512
  cv.height = 128
  const ctx = cv.getContext('2d')!
  const g = ctx.createLinearGradient(0, 0, 0, 128)
  g.addColorStop(0, '#5a3418')
  g.addColorStop(1, '#2e1808')
  ctx.fillStyle = g
  ctx.fillRect(0, 0, 512, 128)
  // vân gỗ
  ctx.globalAlpha = 0.18
  for (let i = 0; i < 18; i++) {
    ctx.fillStyle = i % 2 ? '#000' : '#a0703a'
    ctx.fillRect(0, i * 7 + Math.sin(i) * 3, 512, 2)
  }
  ctx.globalAlpha = 1
  ctx.strokeStyle = '#c9a24d'
  ctx.lineWidth = 6
  ctx.strokeRect(6, 6, 500, 116)
  ctx.font = "bold 64px 'Philosopher', Georgia, serif"
  ctx.textAlign = 'center'
  ctx.textBaseline = 'middle'
  ctx.lineWidth = 8
  ctx.strokeStyle = '#1a0c02'
  ctx.strokeText(text, 256, 68)
  const tg = ctx.createLinearGradient(0, 30, 0, 100)
  tg.addColorStop(0, '#fff3b0')
  tg.addColorStop(1, '#e8a830')
  ctx.fillStyle = tg
  ctx.fillText(text, 256, 68)
  const t = new THREE.CanvasTexture(cv)
  t.colorSpace = THREE.SRGBColorSpace
  t.anisotropy = 4
  return t
}

/** Quầy hàng gỗ mái tuyết, biển hiệu, đèn lồng và cột sáng vàng. */
export function shopStall(): { group: THREE.Group; update: (t: number) => void } {
  const g = new THREE.Group()
  const wood = new THREE.MeshStandardMaterial({ color: 0x6a4424, roughness: 0.85 })
  const dark = new THREE.MeshStandardMaterial({ color: 0x3a2412, roughness: 0.9 })
  const snow = new THREE.MeshStandardMaterial({ color: 0xdfe8f2, roughness: 0.95 })
  const add = (geo: THREE.BufferGeometry, mat: THREE.Material, x: number, y: number, z: number) => {
    const m = new THREE.Mesh(geo, mat)
    m.position.set(x, y, z)
    m.castShadow = true
    m.receiveShadow = true
    g.add(m)
    return m
  }
  add(new THREE.BoxGeometry(220, 150, 14), dark, 0, 0, 7) // sàn
  add(new THREE.BoxGeometry(200, 34, 70), wood, 0, -48, 49) // quầy
  add(new THREE.BoxGeometry(212, 42, 8), dark, 0, -50, 88) // mặt quầy
  for (const [x, y] of [[-96, -66], [96, -66], [-96, 62], [96, 62]]) add(new THREE.CylinderGeometry(7, 8, 200, 8).rotateX(Math.PI / 2), wood, x, y, 107)
  // mái hai dốc lợp ván, tuyết phủ mỏng trên mặt (đỉnh mái chạy theo trục X)
  const shingle = new THREE.MeshStandardMaterial({ color: 0x4a2a16, roughness: 0.9 })
  for (const side of [-1, 1]) {
    const slab = new THREE.Group()
    const board = new THREE.Mesh(new THREE.BoxGeometry(250, 118, 8), shingle)
    board.castShadow = board.receiveShadow = true
    slab.add(board)
    // các hàng ván
    for (let i = 0; i < 4; i++) {
      const strip = new THREE.Mesh(new THREE.BoxGeometry(252, 4, 4), dark)
      strip.position.set(0, -45 + i * 30, 5)
      slab.add(strip)
    }
    const cover = new THREE.Mesh(new THREE.BoxGeometry(254, 104, 5), snow)
    cover.position.set(0, 6, 6.5)
    cover.castShadow = cover.receiveShadow = true
    slab.add(cover)
    slab.position.set(0, side * 50, 238)
    slab.rotation.x = -side * 0.5
    g.add(slab)
  }
  add(new THREE.BoxGeometry(258, 10, 10), dark, 0, 0, 266) // nóc mái
  // biển hiệu
  const sign = new THREE.Mesh(new THREE.PlaneGeometry(190, 46), new THREE.MeshStandardMaterial({ map: signTexture('Krusty Krab'), roughness: 0.7 }))
  sign.rotation.x = Math.PI / 2
  sign.position.set(0, -98, 178)
  g.add(sign)
  // thùng hàng, hũ trên quầy
  const crate = new THREE.MeshStandardMaterial({ color: 0x8a5a2a, roughness: 0.9 })
  add(new THREE.BoxGeometry(36, 36, 36), crate, -70, 30, 32)
  add(new THREE.BoxGeometry(30, 30, 30), crate, -40, 44, 29)
  const potion = (c: number, x: number) => {
    const m = add(new THREE.SphereGeometry(9, 12, 10), new THREE.MeshStandardMaterial({ color: c, emissive: c, emissiveIntensity: 0.6, roughness: 0.2 }), x, -50, 101)
    m.castShadow = false
  }
  potion(0x4a7aff, -50)
  potion(0x3aff9a, -25)
  potion(0xff4a3a, 40)
  // đèn lồng
  const lanterns: THREE.Mesh[] = []
  for (const x of [-96, 96]) {
    const l = new THREE.Mesh(new THREE.SphereGeometry(10, 12, 10), new THREE.MeshStandardMaterial({ color: 0xffc060, emissive: 0xffa030, emissiveIntensity: 2 }))
    l.position.set(x, -82, 168)
    g.add(l)
    lanterns.push(l)
  }
  const glow = new THREE.Sprite(new THREE.SpriteMaterial({ map: radialTexture('rgba(255,200,110,0.9)', 'rgba(255,160,60,0)'), blending: THREE.AdditiveBlending, depthWrite: false }))
  glow.scale.set(320, 320, 1)
  glow.position.set(0, -60, 120)
  g.add(glow)
  const update = (t: number) => {
    const k = 1.8 + Math.sin(t * 7) * 0.25 + Math.sin(t * 13) * 0.15
    lanterns.forEach((l) => ((l.material as THREE.MeshStandardMaterial).emissiveIntensity = k))
    ;(glow.material as THREE.SpriteMaterial).opacity = 0.55 + Math.sin(t * 3) * 0.1
  }
  return { group: g, update }
}

/** Hộp quà: hộp phát sáng có ruy băng, xoay và nhấp nhô. */
export function giftBox(): THREE.Group {
  const g = new THREE.Group()
  const body = new THREE.MeshStandardMaterial({ color: 0x2a6ae8, emissive: 0x1a3a9a, emissiveIntensity: 0.6, roughness: 0.35, metalness: 0.2 })
  const ribbon = new THREE.MeshStandardMaterial({ color: 0xffd040, emissive: 0xffa020, emissiveIntensity: 0.9, roughness: 0.3, metalness: 0.6 })
  const box = new THREE.Mesh(new THREE.BoxGeometry(34, 34, 30), body)
  box.position.z = 15
  const lid = new THREE.Mesh(new THREE.BoxGeometry(38, 38, 8), body)
  lid.position.z = 33
  const r1 = new THREE.Mesh(new THREE.BoxGeometry(39, 8, 39), ribbon)
  r1.position.z = 19
  const r2 = new THREE.Mesh(new THREE.BoxGeometry(8, 39, 39), ribbon)
  r2.position.z = 19
  const bow = new THREE.Mesh(new THREE.TorusKnotGeometry(6, 2.2, 32, 6, 2, 3), ribbon)
  bow.position.z = 42
  const inner = new THREE.Group()
  inner.add(box, lid, r1, r2, bow)
  inner.children.forEach((c) => (c.castShadow = true))
  g.add(inner)
  const glow = new THREE.Sprite(new THREE.SpriteMaterial({ map: radialTexture('rgba(140,200,255,0.9)', 'rgba(140,200,255,0)'), blending: THREE.AdditiveBlending, depthWrite: false }))
  glow.scale.set(130, 130, 1)
  glow.position.z = 20
  g.add(glow)
  return g
}

/** Quầng Khiên Băng: vỏ cầu fresnel xanh băng. */
export function shieldBubble(): THREE.Mesh {
  const mat = new THREE.ShaderMaterial({
    transparent: true,
    depthWrite: false,
    blending: THREE.AdditiveBlending,
    uniforms: { uTime: { value: 0 }, uAlpha: { value: 1 } },
    vertexShader: `varying vec3 vN; varying vec3 vV; varying vec3 vP;
      void main(){ vec4 mv = modelViewMatrix * vec4(position,1.0); vN = normalize(normalMatrix*normal); vV = normalize(-mv.xyz); vP = position; gl_Position = projectionMatrix*mv; }`,
    fragmentShader: `uniform float uTime; uniform float uAlpha; varying vec3 vN; varying vec3 vV; varying vec3 vP;
      void main(){ float f = pow(1.0 - abs(dot(vN, vV)), 2.2);
        float hex = 0.5 + 0.5*sin(vP.x*0.25 + uTime*2.0)*sin(vP.y*0.25 - uTime*1.5)*sin(vP.z*0.25 + uTime);
        vec3 c = mix(vec3(0.35,0.75,1.0), vec3(0.85,0.97,1.0), hex);
        gl_FragColor = vec4(c, (f*0.85 + hex*0.06) * uAlpha); }`,
  })
  const m = new THREE.Mesh(new THREE.SphereGeometry(62, 32, 20), mat)
  m.scale.set(1, 1, 1.35)
  return m
}
