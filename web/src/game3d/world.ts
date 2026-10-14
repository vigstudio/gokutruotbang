// Thế giới 3D của bản đồ: địa hình có độ cao (vách núi băng dựng từ pathing
// gốc), texture procedural, cây thông 3D, doodad gốc và cột sáng ở đích.
import * as THREE from 'three'
import { mergeGeometries } from 'three/examples/jsm/utils/BufferGeometryUtils.js'
import type { MapInfo } from '../game/terrain'
import { renderTerrain, terrainTextures, TERRAIN_MARGIN, type TerrainImage } from '../game/terrain'
import { crystalGeometry, crystalMaterial, lightBeam, pineForest, radialTexture } from './env'
import type { QualitySettings } from './quality'
import { instanceModel, type ProAssets } from './proassets'


function smooth(a: number, b: number, x: number) {
  const t = Math.max(0, Math.min(1, (x - a) / (b - a)))
  return t * t * (3 - 2 * t)
}

function hash2(x: number, y: number) {
  const s = Math.sin(x * 127.1 + y * 311.7) * 43758.5453
  return s - Math.floor(s)
}
function vnoise(x: number, y: number) {
  const xi = Math.floor(x)
  const yi = Math.floor(y)
  const xf = x - xi
  const yf = y - yi
  const u = xf * xf * (3 - 2 * xf)
  const v = yf * yf * (3 - 2 * yf)
  const a = hash2(xi, yi)
  const b = hash2(xi + 1, yi)
  const c = hash2(xi, yi + 1)
  const d = hash2(xi + 1, yi + 1)
  return a + (b - a) * u + (c - a) * v + (a - b - c + d) * u * v
}
function fbm(x: number, y: number) {
  return vnoise(x, y) * 0.5 + vnoise(x * 2.1, y * 2.1) * 0.27 + vnoise(x * 4.3, y * 4.3) * 0.15 + vnoise(x * 8.7, y * 8.7) * 0.08
}

export interface World {
  group: THREE.Group
  terrain2d: TerrainImage
  heightAt: (x: number, y: number) => number
  update: (t: number, camX: number, camY: number) => void
}

/** Bộ lấy mẫu "độ tường" 0..1 nội suy từ lưới pathing 32 đơn vị. */
function wallSampler(info: MapInfo) {
  const m = info.m
  const p = m.pathing
  const b = m.bounds
  const PC = p.cols + 2
  const mask = new Float32Array(PC * (p.rows + 2))
  for (let cy = -1; cy <= p.rows; cy++) {
    for (let cx = -1; cx <= p.cols; cx++) {
      let v = 1
      if (cx >= 0 && cy >= 0 && cx < p.cols && cy < p.rows) {
        const x = p.originX + (cx + 0.5) * p.cellSize
        const y = p.originY + (cy + 0.5) * p.cellSize
        const inside = x >= b.minX && x <= b.maxX && y >= b.minY && y <= b.maxY
        v = inside && info.walk[cy * p.cols + cx] ? 0 : 1
      }
      mask[(cy + 1) * PC + cx + 1] = v
    }
  }
  // bản làm mờ để biết "sâu trong vách" bao nhiêu (đồi núi ở vùng vách rộng)
  const blur = new Float32Array(mask.length)
  const R = 5
  for (let y = 0; y < p.rows + 2; y++) {
    for (let x = 0; x < PC; x++) {
      let s = 0
      let n = 0
      for (let dy = -R; dy <= R; dy++) {
        for (let dx = -R; dx <= R; dx++) {
          const xx = Math.min(PC - 1, Math.max(0, x + dx))
          const yy = Math.min(p.rows + 1, Math.max(0, y + dy))
          s += mask[yy * PC + xx]
          n++
        }
      }
      blur[y * PC + x] = s / n
    }
  }
  const sample = (arr: Float32Array, wx: number, wy: number) => {
    const fx = (wx - p.originX) / p.cellSize - 0.5 + 1
    const fy = (wy - p.originY) / p.cellSize - 0.5 + 1
    const ix = Math.floor(fx)
    const iy = Math.floor(fy)
    if (ix < 0 || iy < 0 || ix >= PC - 1 || iy >= p.rows + 1) return 1
    const tx = fx - ix
    const ty = fy - iy
    const a = arr[iy * PC + ix]
    const bb = arr[iy * PC + ix + 1]
    const c = arr[(iy + 1) * PC + ix]
    const d = arr[(iy + 1) * PC + ix + 1]
    return a + (bb - a) * tx + (c - a) * ty + (a - bb - c + d) * tx * ty
  }
  return { wall: (x: number, y: number) => sample(mask, x, y), deep: (x: number, y: number) => sample(blur, x, y) }
}

export function buildWorld(info: MapInfo, pro: ProAssets, qs: QualitySettings): World {
  const SEG = qs.terrainSeg
  const m = info.m
  const b = m.bounds
  const group = new THREE.Group()
  const ws = wallSampler(info)

  // ---------------------------------------------------------------- độ cao
  const heightAt = (x: number, y: number) => {
    const w = ws.wall(x, y)
    const n = fbm(x / 160, y / 160)
    const e = smooth(0.42, 0.58, w + (n - 0.5) * 0.25)
    if (e <= 0) return 0
    const deep = smooth(0.55, 1, ws.deep(x, y))
    const rock = (fbm(x / 70 + 9, y / 70) - 0.5) * 40
    return e * (34 + rock * 0.4 + deep * (150 + fbm(x / 400, y / 400) * 240))
  }

  // ---------------------------------------------------------------- địa hình
  const minX = b.minX - TERRAIN_MARGIN
  const maxX = b.maxX + TERRAIN_MARGIN
  const minY = b.minY - TERRAIN_MARGIN
  const maxY = b.maxY + TERRAIN_MARGIN
  const W = maxX - minX
  const H = maxY - minY
  const sx = Math.round(W / SEG)
  const sy = Math.round(H / SEG)
  const geo = new THREE.PlaneGeometry(W, H, sx, sy)
  geo.translate(minX + W / 2, minY + H / 2, 0)
  const pos = geo.getAttribute('position')
  for (let i = 0; i < pos.count; i++) pos.setZ(i, heightAt(pos.getX(i), pos.getY(i)))
  geo.computeVertexNormals()

  // ảnh 2D chỉ dùng cho minimap; mặt đất 3D dùng texture ảnh thật
  const terrain2d = renderTerrain(info, 0.5, true)

  // bản đồ trộn: R = băng, G = đá lát (vùng an toàn), B = tuyết / còn lại
  const SPL = 1024
  const scv = document.createElement('canvas')
  scv.width = scv.height = SPL
  const sctx = scv.getContext('2d')!
  const simg = sctx.createImageData(SPL, SPL)
  for (let py = 0; py < SPL; py++) {
    for (let px = 0; px < SPL; px++) {
      const x = minX + ((px + 0.5) / SPL) * W
      const y = maxY - ((py + 0.5) / SPL) * H
      const tile = info.tileAt(x, y)
      const o = (py * SPL + px) * 4
      simg.data[o] = tile === 'Nice' ? 255 : 0
      simg.data[o + 1] = tile === 'Xblm' ? 255 : 0
      simg.data[o + 2] = tile !== 'Nice' && tile !== 'Xblm' ? 255 : 0
      simg.data[o + 3] = 255
    }
  }
  sctx.putImageData(simg, 0, 0)
  // làm mềm biên giữa các loại nền
  const blurCv = document.createElement('canvas')
  blurCv.width = blurCv.height = SPL
  const bctx = blurCv.getContext('2d')!
  bctx.filter = 'blur(2px)'
  bctx.drawImage(scv, 0, 0)
  const splatTex = new THREE.CanvasTexture(blurCv)

  const iceTex = new THREE.CanvasTexture(terrainTextures().Nice.canvas)
  iceTex.wrapS = iceTex.wrapT = THREE.RepeatWrapping
  iceTex.colorSpace = THREE.SRGBColorSpace

  const mat = new THREE.MeshStandardMaterial({
    map: pro.snow.map, // để three bật USE_MAP; màu thật được trộn trong shader
    normalMap: pro.snow.nor,
    normalScale: new THREE.Vector2(1, 1),
    roughness: 1,
    metalness: 0,
    envMapIntensity: 1,
  })
  mat.onBeforeCompile = (sh) => {
    Object.assign(sh.uniforms, {
      splatMap: { value: splatTex },
      iceMap: { value: iceTex },
      snowMap: { value: pro.snow.map },
      snowNor: { value: pro.snow.nor },
      snowRough: { value: pro.snow.rough },
      rockMap: { value: pro.rock.map },
      rockNor: { value: pro.rock.nor },
      tileMap: { value: pro.tile.map },
      tileNor: { value: pro.tile.nor },
      tileRough: { value: pro.tile.rough },
      splatRect: { value: new THREE.Vector4(minX, minY, W, H) },
    })
    sh.vertexShader = sh.vertexShader
      .replace('#include <common>', '#include <common>\nvarying vec3 vWPos;\nvarying float vSlope;')
      .replace('#include <begin_vertex>', '#include <begin_vertex>\nvWPos = position;\nvSlope = normal.z;')
    sh.fragmentShader = sh.fragmentShader
      .replace(
        '#include <common>',
        `#include <common>
        varying vec3 vWPos;
        varying float vSlope;
        uniform sampler2D splatMap, iceMap, snowMap, snowNor, snowRough, rockMap, rockNor, tileMap, tileNor, tileRough;
        uniform vec4 splatRect;
        vec4 gWeights;
        vec2 uvSnow, uvRockA, uvRockB, uvTile, uvIce;`,
      )
      .replace(
        '#include <map_fragment>',
        `vec2 suv = vec2((vWPos.x - splatRect.x) / splatRect.z, (vWPos.y - splatRect.y) / splatRect.w);
        vec3 spl = texture2D(splatMap, suv).rgb;
        float steep = (1.0 - smoothstep(0.18, 0.42, vSlope)) * (1.0 - smoothstep(0.55, 0.75, texture2D(snowMap, vWPos.xy / 230.0).g) * 0.6);
        float high = smoothstep(8.0, 30.0, vWPos.z);
        // đỉnh vách (cao) là tuyết, mặt dốc là đá
        float wIce = spl.r * (1.0 - high);
        float wTile = spl.g * (1.0 - high);
        float wSnow = max(spl.b, high);
        float tot = wIce + wTile + wSnow + 1e-4;
        wIce /= tot; wTile /= tot; wSnow /= tot;
        wIce *= 1.0 - steep; wTile *= 1.0 - steep; wSnow *= 1.0 - steep;
        float wRock = steep;
        gWeights = vec4(wIce, wTile, wSnow, wRock);
        uvSnow = vWPos.xy / 420.0;
        uvTile = vWPos.xy / 384.0;
        uvIce = vWPos.xy / 1024.0;
        uvRockA = vec2(vWPos.x + vWPos.y * 0.3, vWPos.z) / 300.0;
        uvRockB = vec2(vWPos.y - vWPos.x * 0.3, vWPos.z) / 300.0;
        vec3 cIce = texture2D(iceMap, uvIce).rgb * vec3(0.38, 0.6, 0.88);
        vec3 cSnow = texture2D(snowMap, uvSnow).rgb * vec3(0.95, 0.98, 1.04);
        vec3 tRaw = texture2D(tileMap, uvTile).rgb;
        vec3 cTile = mix(vec3(dot(tRaw, vec3(0.299, 0.587, 0.114))), tRaw, 0.05) * vec3(0.92, 0.97, 1.05) * 1.45;
        cTile = mix(cTile, cSnow, smoothstep(0.6, 0.85, texture2D(snowMap, vWPos.xy / 300.0).r) * 0.35);
        vec3 rRaw = mix(texture2D(rockMap, uvRockA).rgb, texture2D(rockMap, uvRockB).rgb, 0.5);
        vec3 cRock = mix(vec3(dot(rRaw, vec3(0.299, 0.587, 0.114))), rRaw, 0.15) * vec3(0.82, 0.9, 1.02) * 1.1;
        // tuyết đọng trên gờ đá
        cRock = mix(cRock, cSnow, smoothstep(0.45, 0.75, texture2D(snowMap, vWPos.xy / 160.0).r) * 0.65);
        diffuseColor.rgb = cIce * wIce + cTile * wTile + cSnow * wSnow + cRock * wRock;
        // viền băng lượn sóng ở chân gờ tuyết (như tileset Northrend của WC3)
        float wave = sin((vWPos.x + vWPos.y) * 0.045) * 3.0 + sin(vWPos.x * 0.11 - vWPos.y * 0.07) * 2.0;
        float rim = smoothstep(1.5, 4.0, vWPos.z) * (1.0 - smoothstep(13.0 + wave, 17.0 + wave, vWPos.z));
        diffuseColor.rgb = mix(diffuseColor.rgb, vec3(0.45, 0.78, 0.98), rim * 0.85);
        gWeights.x = max(gWeights.x, rim);`,
      )
      .replace(
        '#include <roughnessmap_fragment>',
        `float roughnessFactor = roughness;
        roughnessFactor = gWeights.x * 0.16 + gWeights.y * mix(0.25, 0.7, texture2D(tileRough, uvTile).g)
          + gWeights.z * mix(0.6, 1.0, texture2D(snowRough, uvSnow).g) + gWeights.w * 0.92;`,
      )
      .replace(
        '#include <normal_fragment_maps>',
        `#ifdef USE_NORMALMAP_TANGENTSPACE
        vec3 nS = texture2D(snowNor, uvSnow).xyz * 2.0 - 1.0;
        vec3 nT = texture2D(tileNor, uvTile).xyz * 2.0 - 1.0;
        vec3 nR = texture2D(rockNor, uvRockA).xyz * 2.0 - 1.0;
        vec3 nI = mix(vec3(0.0, 0.0, 1.0), nS, 0.12);
        vec3 mapN = normalize(nI * gWeights.x + nT * gWeights.y + nS * gWeights.z + nR * gWeights.w);
        mapN.xy *= normalScale;
        normal = normalize(tbn * mapN);
        #endif`,
      )
  }
  // chia lưới địa hình thành các ô: camera chỉ thấy vài ô, phần còn lại bị
  // frustum culling bỏ qua (pháp tuyến đã tính trên lưới liền nên không lộ mép)
  const CH = 8
  const nAttr = geo.getAttribute('normal')
  const uvAttr = geo.getAttribute('uv')
  for (let cy = 0; cy < CH; cy++) {
    for (let cx = 0; cx < CH; cx++) {
      const c0 = Math.floor((cx * sx) / CH)
      const c1 = Math.floor(((cx + 1) * sx) / CH)
      const r0 = Math.floor((cy * sy) / CH)
      const r1 = Math.floor(((cy + 1) * sy) / CH)
      const cw = c1 - c0 + 1
      const chh = r1 - r0 + 1
      const P = new Float32Array(cw * chh * 3)
      const N = new Float32Array(cw * chh * 3)
      const U = new Float32Array(cw * chh * 2)
      let k = 0
      for (let r = r0; r <= r1; r++) {
        for (let c = c0; c <= c1; c++, k++) {
          const i = r * (sx + 1) + c
          P[k * 3] = pos.getX(i)
          P[k * 3 + 1] = pos.getY(i)
          P[k * 3 + 2] = pos.getZ(i)
          N[k * 3] = nAttr.getX(i)
          N[k * 3 + 1] = nAttr.getY(i)
          N[k * 3 + 2] = nAttr.getZ(i)
          U[k * 2] = uvAttr.getX(i)
          U[k * 2 + 1] = uvAttr.getY(i)
        }
      }
      const idx: number[] = []
      for (let r = 0; r < chh - 1; r++) {
        for (let c = 0; c < cw - 1; c++) {
          const a = r * cw + c
          const b2 = a + cw
          idx.push(a, b2, a + 1, b2, b2 + 1, a + 1)
        }
      }
      const g = new THREE.BufferGeometry()
      g.setAttribute('position', new THREE.BufferAttribute(P, 3))
      g.setAttribute('normal', new THREE.BufferAttribute(N, 3))
      g.setAttribute('uv', new THREE.BufferAttribute(U, 2))
      g.setIndex(idx)
      g.computeBoundingSphere()
      g.computeBoundingBox()
      const chunk = new THREE.Mesh(g, mat)
      chunk.receiveShadow = true
      group.add(chunk)
    }
  }
  geo.dispose()

  // ---------------------------------------------------------------- rừng thông (model thật)
  const rand = (() => {
    let sd = 4242
    return () => ((sd = (sd * 1664525 + 1013904223) >>> 0) / 4294967296)
  })()
  const spots: [number, number, number][] = []
  for (let k = 0; k < 6000 && spots.length < qs.treeLimit; k++) {
    const x = minX + rand() * W
    const y = minY + rand() * H
    const sc = 0.75 + rand() * 0.7
    const rr = 80 * sc
    if (ws.wall(x, y) < 1 || ws.wall(x - rr, y) < 1 || ws.wall(x + rr, y) < 1 || ws.wall(x, y + rr) < 1 || ws.wall(x, y - rr) < 1) continue
    if (spots.some(([tx, ty]) => Math.hypot(tx - x, ty - y) < 150 * sc)) continue
    spots.push([x, y, sc])
  }
  const treeMats = spots.map(([x, y, sc]) =>
    new THREE.Matrix4().compose(
      new THREE.Vector3(x, y, heightAt(x, y) - 8),
      new THREE.Quaternion().setFromEuler(new THREE.Euler((rand() - 0.5) * 0.06, (rand() - 0.5) * 0.06, rand() * Math.PI * 2)),
      new THREE.Vector3(sc, sc, sc * (0.9 + rand() * 0.25)),
    ),
  )
  group.add(pineForest(treeMats, qs.shadows))

  // tảng đá phủ tuyết dọc vách
  const rocks: THREE.Matrix4[] = []
  for (let k = 0; k < 4000 && rocks.length < 60; k++) {
    const x = minX + rand() * W
    const y = minY + rand() * H
    const w = ws.wall(x, y)
    if (w < 0.85 || ws.deep(x, y) > 0.75) continue
    const sc = 0.6 + rand() * 0.9
    rocks.push(
      new THREE.Matrix4().compose(
        new THREE.Vector3(x, y, heightAt(x, y) - 10),
        new THREE.Quaternion().setFromEuler(new THREE.Euler(rand() * 0.4, rand() * 0.4, rand() * Math.PI * 2)),
        new THREE.Vector3(sc * (0.8 + rand() * 0.6), sc, sc * (0.6 + rand() * 0.5)),
      ),
    )
  }
  group.add(instanceModel(pro.boulder, rocks, 70, true))

  // ---------------------------------------------------------------- doodad gốc
  const cMat = crystalMaterial()
  const glowTex = radialTexture('rgba(140,210,255,0.9)', 'rgba(140,210,255,0)')
  const fireTex = radialTexture('rgba(255,190,90,1)', 'rgba(255,120,30,0)')
  // nguồn sáng điểm: mỗi đèn three.js bị tính cho mọi pixel trên màn hình, nên
  // chỉ dùng một đèn và dời nó tới nguồn gần camera nhất
  const fires: { x: number; y: number; z: number; color: number; base: number; flicker: boolean }[] = []
  const flames: THREE.Sprite[] = []
  // pha lê: gộp hết vào một geometry -> 1 lệnh vẽ thay vì ~130
  const crystalParts: THREE.BufferGeometry[] = []
  const crystalShadowParts: THREE.BufferGeometry[] = []
  const crystal = (seed: number, shards: number, x: number, y: number, z: number, s: THREE.Vector3, shadow: boolean) => {
    const g = crystalGeometry(seed, shards)
    g.applyMatrix4(new THREE.Matrix4().compose(new THREE.Vector3(x, y, z), new THREE.Quaternion(), s))
    ;(shadow ? crystalShadowParts : crystalParts).push(g)
  }
  for (const d of m.doodads ?? []) {
    const z = heightAt(d.x, d.y)
    const sc = d.scale || 1
    const add = (o: THREE.Object3D) => {
      o.position.set(d.x, d.y, z)
      group.add(o)
      return o
    }
    switch (d.type) {
      case 'IOst': {
        crystal(Math.round(d.x + d.y), 4, d.x, d.y, z, new THREE.Vector3(120 * sc, 120 * sc, 150 * sc), true)
        break
      }
      case 'IWbg': {
        crystal(Math.round(d.y), 2, d.x, d.y, z, new THREE.Vector3(40 * sc, 40 * sc, 45 * sc), false)
        break
      }
      case 'NRic': {
        crystal(Math.round(d.x), 5, d.x, d.y, z, new THREE.Vector3(70 * sc, 70 * sc, 80 * sc), true)
        break
      }
      case 'IOob': {
        const pillar = new THREE.Mesh(
          new THREE.CylinderGeometry(14, 18, 120, 6).rotateX(Math.PI / 2).translate(0, 0, 60),
          new THREE.MeshStandardMaterial({ color: 0x4a5670, roughness: 0.7, emissive: 0x1a5a9a, emissiveIntensity: 0.35 }),
        )
        pillar.castShadow = true
        add(pillar)
        const glow = new THREE.Sprite(new THREE.SpriteMaterial({ map: glowTex, blending: THREE.AdditiveBlending, depthWrite: false }))
        glow.scale.set(90, 90, 1)
        glow.position.set(d.x, d.y, z + 130)
        group.add(glow)
        break
      }
      case 'YOfb': {
        const bowl = new THREE.Mesh(
          new THREE.CylinderGeometry(26, 14, 26, 10).rotateX(Math.PI / 2).translate(0, 0, 13),
          new THREE.MeshStandardMaterial({ color: 0x2c2622, roughness: 0.6, metalness: 0.5 }),
        )
        add(bowl)
        const fl = new THREE.Sprite(new THREE.SpriteMaterial({ map: fireTex, blending: THREE.AdditiveBlending, depthWrite: false }))
        fl.scale.set(70, 110, 1)
        fl.position.set(d.x, d.y, z + 60)
        group.add(fl)
        flames.push(fl)
        fires.push({ x: d.x, y: d.y, z: z + 70, color: 0xff9a40, base: 4, flicker: true })
        break
      }
      case 'YOr2': {
        const ring = new THREE.Mesh(
          new THREE.RingGeometry(36, 44, 40),
          new THREE.MeshBasicMaterial({ color: 0x8fd8ff, transparent: true, opacity: 0.7, blending: THREE.AdditiveBlending, depthWrite: false }),
        )
        ring.position.set(d.x, d.y, z + 1)
        group.add(ring)
        break
      }
      default: {
        crystal(Math.round(d.x * 3), 3, d.x, d.y, z, new THREE.Vector3(60 * sc, 60 * sc, 70 * sc), false)
      }
    }
  }
  for (const [parts, shadow] of [
    [crystalParts, false],
    [crystalShadowParts, true],
  ] as const) {
    if (!parts.length) continue
    const mesh = new THREE.Mesh(mergeGeometries(parts)!, cMat)
    mesh.castShadow = shadow
    group.add(mesh)
    parts.forEach((g) => g.dispose())
  }

  // ---------------------------------------------------------------- đích + xuất phát
  const fin = m.regions['Next_Round']
  let beam: THREE.Mesh | null = null
  if (fin) {
    const cx = (fin.minX + fin.maxX) / 2
    const cy = (fin.minY + fin.maxY) / 2
    beam = lightBeam(0xffd060, 2600, 34)
    beam.position.set(cx, cy, 0)
    group.add(beam)
    fires.push({ x: cx, y: cy, z: 160, color: 0xffcf70, base: 6, flicker: false })
  }
  const lamp = new THREE.PointLight(0xff9a40, 0, 900, 1.5)
  group.add(lamp)

  const update = (t: number, camX: number, camY: number) => {
    let best = null as (typeof fires)[number] | null
    let bd = Infinity
    fires.forEach((f) => {
      const d = Math.hypot(f.x - camX, f.y - camY)
      if (d < bd) {
        bd = d
        best = f
      }
    })
    if (best) {
      const f = best as (typeof fires)[number]
      lamp.position.set(f.x, f.y, f.z)
      lamp.color.setHex(f.color)
      lamp.distance = f.flicker ? 700 : 900
      lamp.intensity = bd > 2200 ? 0 : f.flicker ? f.base * 0.9 + Math.sin(t * 13) * 0.6 + Math.sin(t * 29) * 0.4 : f.base
    }
    flames.forEach((f, i) => f.scale.set(64 + Math.sin(t * 11 + i) * 8, 100 + Math.sin(t * 17 + i * 3) * 14, 1))
    if (beam) (beam.material as THREE.MeshBasicMaterial).opacity = 0.35 + Math.sin(t * 2) * 0.1
  }

  return { group, terrain2d, heightAt, update }
}
