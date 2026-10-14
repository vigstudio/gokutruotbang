// Asset ảnh thật (CC0, Poly Haven): texture tuyết/đá/đá lát, HDRI trời đông,
// model cây thông và tảng đá (đã giảm lưới cho web). Xem web/public/assets/pro.
import * as THREE from 'three'
import { clusterMatrices } from './cluster'
import { RGBELoader } from 'three/examples/jsm/loaders/RGBELoader.js'
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js'
import { MeshoptDecoder } from 'three/examples/jsm/libs/meshopt_decoder.module.js'
import { retry } from '../fetchRetry'

const BASE = '/assets/pro/'

export interface ProAssets {
  snow: { map: THREE.Texture; nor: THREE.Texture; rough: THREE.Texture }
  rock: { map: THREE.Texture; nor: THREE.Texture; rough: THREE.Texture }
  tile: { map: THREE.Texture; nor: THREE.Texture; rough: THREE.Texture }
  env: THREE.Texture
  fir: THREE.Group
  boulder: THREE.Group
}

type Raw = Omit<ProAssets, 'env'> & { hdr: THREE.DataTexture }
let cache: Promise<Raw> | null = null

/** Tải asset (dùng chung giữa các renderer); env map PMREM tạo riêng cho từng renderer. */
export async function loadProAssets(renderer: THREE.WebGLRenderer): Promise<ProAssets> {
  const raw = await loadRaw(renderer)
  const pmrem = new THREE.PMREMGenerator(renderer)
  const env = pmrem.fromEquirectangular(raw.hdr).texture
  pmrem.dispose()
  return { snow: raw.snow, rock: raw.rock, tile: raw.tile, fir: raw.fir, boulder: raw.boulder, env }
}

function loadRaw(renderer: THREE.WebGLRenderer): Promise<Raw> {
  cache ??= (async () => {
    const tl = new THREE.TextureLoader()
    const tex = (name: string, color: boolean) =>
      retry(() => tl.loadAsync(BASE + name)).then((t) => {
        t.wrapS = t.wrapT = THREE.RepeatWrapping
        t.anisotropy = renderer.capabilities.getMaxAnisotropy()
        if (color) t.colorSpace = THREE.SRGBColorSpace
        return t
      })
    const set = (id: string) =>
      Promise.all([tex(`${id}_diff.jpg`, true), tex(`${id}_nor.jpg`, false), tex(`${id}_rough.jpg`, false)]).then(([map, nor, rough]) => ({ map, nor, rough }))
    const gltf = new GLTFLoader().setMeshoptDecoder(MeshoptDecoder)
    const [snow, rock, tile, hdr, fir, boulder] = await Promise.all([
      set('snow_02'),
      set('rock_face_03'),
      set('granite_tile_02'),
      retry(() => new RGBELoader().loadAsync(BASE + 'snowy_field_1k.hdr')),
      retry(() => gltf.loadAsync(BASE + 'fir.glb')),
      retry(() => gltf.loadAsync(BASE + 'boulder.glb')),
    ])
    hdr.mapping = THREE.EquirectangularReflectionMapping
    return { snow, rock, tile, hdr, fir: fir.scene, boulder: boulder.scene }
  })()
  cache.catch(() => (cache = null))
  return cache
}

/**
 * Tách một model glTF (Y lên) thành các InstancedMesh đặt theo danh sách
 * ma trận (Z lên). `height` = chiều cao mong muốn (đơn vị thế giới) khi scale 1.
 */
export function instanceModel(model: THREE.Group, matrices: THREE.Matrix4[], height: number, snowy = false): THREE.Group {
  const out = new THREE.Group()
  model.updateMatrixWorld(true)
  const box = new THREE.Box3().setFromObject(model)
  const size = box.getSize(new THREE.Vector3())
  const k = height / Math.max(size.y, 1e-3)
  // Y-up -> Z-up, đặt gốc ở chân, chuẩn hoá chiều cao
  const fix = new THREE.Matrix4()
    .makeRotationX(Math.PI / 2)
    .multiply(new THREE.Matrix4().makeScale(k, k, k))
    .multiply(new THREE.Matrix4().makeTranslation(-(box.min.x + box.max.x) / 2, -box.min.y, -(box.min.z + box.max.z) / 2))
  model.traverse((o) => {
    const mesh = o as THREE.Mesh
    if (!mesh.isMesh) return
    const base = new THREE.Matrix4().multiplyMatrices(fix, mesh.matrixWorld)
    const mat = (mesh.material as THREE.MeshStandardMaterial).clone()
    mat.side = THREE.DoubleSide
    // lá thông: màu xanh thẫm đặc (texture atlas bị lẫn vùng vỏ nâu sau khi giảm lưới)
    if (/twig|leaf|needle/i.test(mat.name)) {
      mat.map = null
      mat.color.set(0x1d3a2c)
      mat.roughness = 0.95
    }
    if (snowy) addSnowCover(mat)
    const tmp = new THREE.Matrix4()
    for (const part of clusterMatrices(matrices)) {
      const inst = new THREE.InstancedMesh(mesh.geometry, mat, part.length)
      part.forEach((m, i) => inst.setMatrixAt(i, tmp.multiplyMatrices(m, base)))
      inst.castShadow = true
      inst.receiveShadow = true
      inst.computeBoundingSphere()
      out.add(inst)
    }
  })
  return out
}

/** Tuyết bám mặt trên tán lá / đá (theo pháp tuyến hướng lên trong không gian model). */
function addSnowCover(mat: THREE.MeshStandardMaterial) {
  mat.onBeforeCompile = (sh) => {
    sh.vertexShader = sh.vertexShader
      .replace('#include <common>', '#include <common>\nvarying float vSnowUp;\nvarying vec3 vSnowPos;')
      .replace('#include <begin_vertex>', '#include <begin_vertex>\nvSnowUp = objectNormal.y;\nvSnowPos = position;')
    sh.fragmentShader = sh.fragmentShader
      .replace('#include <common>', '#include <common>\nvarying float vSnowUp;\nvarying vec3 vSnowPos;')
      .replace(
        '#include <map_fragment>',
        `#include <map_fragment>
        float sn = smoothstep(0.15, 0.75, vSnowUp) * (0.55 + 0.45 * fract(sin(dot(floor(vSnowPos * 3.0), vec3(12.9, 78.2, 37.7))) * 43758.5));
        diffuseColor.rgb = mix(diffuseColor.rgb, vec3(0.88, 0.92, 0.97), clamp(sn, 0.0, 0.85));`,
      )
  }
}
