// Render model MDX gốc của map (Goku, rồng) trực tiếp trong context WebGL
// của three.js. Hệ toạ độ dùng y như WC3 (Z hướng lên) nên không cần đổi trục.
import { ModelRenderer, decodeBLP, getBLPImageData, parseMDX } from 'war3-model'
import { mat4 } from 'gl-matrix'
import { fetchRetry } from '../fetchRetry'

const ASSET = (p: string) => '/assets/' + p.replace(/\\/g, '/')

async function fetchBuf(url: string) {
  const r = await fetchRetry(url)
  if (!r.ok) throw new Error(`${url}: ${r.status}`)
  return r.arrayBuffer()
}

const blpCache = new Map<string, Promise<ImageData[]>>()
export function blpLevels(path: string): Promise<ImageData[]> {
  let p = blpCache.get(path)
  if (!p) {
    p = fetchBuf(ASSET(path)).then((buf) => {
      const blp = decodeBLP(buf)
      const out: ImageData[] = []
      for (let i = 0; i < blp.mipmaps.length; i++) {
        const d = getBLPImageData(blp, i)
        out.push(new ImageData(new Uint8ClampedArray(d.data), d.width, d.height))
      }
      return out
    })
    blpCache.set(path, p)
  }
  return p
}

export class W3Model {
  private renderer: ModelRenderer
  private model: ReturnType<typeof parseMDX>
  private seqIdx = new Map<string, number>()
  private lastPose = ''
  private mv = mat4.create()

  private constructor(model: ReturnType<typeof parseMDX>, renderer: ModelRenderer) {
    this.model = model
    this.renderer = renderer
    model.Sequences.forEach((s, i) => this.seqIdx.set(s.Name.toLowerCase(), i))
  }

  static async load(gl: WebGL2RenderingContext | WebGLRenderingContext, path: string): Promise<W3Model> {
    const model = parseMDX(await fetchBuf(ASSET(path)))
    // ẩn quầng "team glow" (texture thay thế id 2) - không có texture gốc
    for (const g of model.Geosets) {
      const mat = model.Materials[g.MaterialID]
      if (mat?.Layers.some((l) => typeof l.TextureID === 'number' && model.Textures[l.TextureID]?.ReplaceableId === 2)) g.Vertices.fill(0)
    }
    // tải hết texture trước, rồi upload liền một mạch (không có await chen giữa,
    // tránh vòng render của three.js đổi trạng thái pixelStore trong lúc upload)
    const images = [...new Set(model.Textures.map((t) => t.Image).filter((x): x is string => !!x))]
    const levels = await Promise.all(images.map((p) => blpLevels(p)))
    // trong lúc tải, trang có thể đã chuyển cảnh và huỷ context WebGL này
    if (gl.isContextLost()) throw new Error('WebGL context đã bị huỷ')
    const renderer = new ModelRenderer(model)
    renderer.initGL(gl)
    // three.js để lại trạng thái lật ảnh / nhân alpha khi upload texture trong
    // context dùng chung -> texture model WC3 bị lật, tóc lấy nhầm vùng da.
    gl.pixelStorei(gl.UNPACK_FLIP_Y_WEBGL, false)
    gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, false)
    gl.pixelStorei(gl.UNPACK_COLORSPACE_CONVERSION_WEBGL, gl.BROWSER_DEFAULT_WEBGL)
    gl.pixelStorei(gl.UNPACK_ALIGNMENT, 4)
    images.forEach((img, i) => renderer.setTextureImageData(img, levels[i]))
    renderer.setLightColor([1, 1, 1])
    return new W3Model(model, renderer)
  }

  hasSeq(name: string) {
    return this.seqIdx.has(name.toLowerCase())
  }

  seqLength(name: string) {
    const i = this.seqIdx.get(name.toLowerCase())
    if (i === undefined) return 1000
    const [a, b] = this.model.Sequences[i].Interval
    return b - a
  }

  /**
   * Đặt tư thế theo animation + thời gian. Thời gian được làm tròn theo
   * `buckets` pha để nhiều unit dùng chung một lần tính xương.
   */
  pose(seqName: string, timeMs: number, buckets = 12) {
    const i = this.seqIdx.get(seqName.toLowerCase()) ?? 0
    const [a, b] = this.model.Sequences[i].Interval
    const len = b - a
    const phase = Math.floor((((timeMs % len) + len) % len) / len * buckets)
    const key = i + ':' + phase
    if (key === this.lastPose) return
    this.lastPose = key
    this.renderer.setSequence(i)
    this.renderer.setFrame(a + (len * phase) / buckets)
    this.renderer.update(0)
  }

  /** Vẽ model tại (x, y, z) quay `facingDeg` với tỉ lệ `scale`. */
  draw(view: Float32Array | number[], proj: Float32Array | number[], x: number, y: number, z: number, facingDeg: number, scale: number) {
    const mv = this.mv
    mat4.copy(mv, view as unknown as mat4)
    mat4.translate(mv, mv, [x, y, z])
    mat4.rotateZ(mv, mv, (facingDeg * Math.PI) / 180)
    mat4.scale(mv, mv, [scale, scale, scale])
    this.renderer.render(mv, proj as unknown as mat4, { wireframe: false })
  }

  setLight(pos: [number, number, number]) {
    this.renderer.setLightPosition(pos)
  }
}
