import * as THREE from 'three'

/**
 * Chia danh sách ma trận đặt vật theo lưới ô vuông. Mỗi ô thành một
 * InstancedMesh riêng có bounding sphere nhỏ, nhờ đó three.js bỏ qua (frustum
 * culling) những cụm nằm ngoài màn hình thay vì vẽ cả bản đồ mỗi khung hình.
 */
export function clusterMatrices(matrices: THREE.Matrix4[], cell = 900): THREE.Matrix4[][] {
  const groups = new Map<string, THREE.Matrix4[]>()
  for (const m of matrices) {
    const e = m.elements
    const key = Math.floor(e[12] / cell) + ',' + Math.floor(e[13] / cell)
    let g = groups.get(key)
    if (!g) groups.set(key, (g = []))
    g.push(m)
  }
  return [...groups.values()]
}
