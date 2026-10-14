// Đọc texture BLP và "nướng" chân dung động kiểu WC3 từ model MDX gốc của
// map (dùng camera chân dung có sẵn trong model).
import { ModelRenderer, decodeBLP, getBLPImageData, parseMDX } from 'war3-model'
import { mat4, vec3 } from 'gl-matrix'
import { fetchRetry } from '../fetchRetry'

const ASSET = (p: string) => '/assets/' + p.replace(/\\/g, '/')

async function fetchBuf(url: string) {
  const r = await fetchRetry(url)
  if (!r.ok) throw new Error(`${url}: ${r.status}`)
  return r.arrayBuffer()
}

interface Rig {
  model: ReturnType<typeof parseMDX>
  renderer: ModelRenderer
  gl: HTMLCanvasElement
  ctx: WebGL2RenderingContext | WebGLRenderingContext
}

async function blpImageData(path: string): Promise<ImageData[]> {
  const blp = decodeBLP(await fetchBuf(ASSET(path)))
  const levels: ImageData[] = []
  for (let i = 0; i < blp.mipmaps.length; i++) {
    const d = getBLPImageData(blp, i)
    levels.push(new ImageData(new Uint8ClampedArray(d.data), d.width, d.height))
  }
  return levels
}

/** Đọc một ảnh BLP (vd war3mapMap.blp) thành canvas. */
export async function loadBlpCanvas(path: string): Promise<HTMLCanvasElement> {
  const [img] = await blpImageData(path)
  const cv = document.createElement('canvas')
  cv.width = img.width
  cv.height = img.height
  cv.getContext('2d')!.putImageData(img, 0, 0)
  return cv
}

async function createRig(modelPath: string, w: number, h: number): Promise<Rig> {
  const model = parseMDX(await fetchBuf(ASSET(modelPath)))
  // Ẩn geoset dùng texture thay thế "team glow" (ReplaceableId 2): trong
  // WC3 nó là quầng màu người chơi dưới chân, ở đây không có texture nên
  // thành ô vuông đen. Thu các đỉnh về một điểm để nó không được vẽ.
  for (const g of model.Geosets) {
    const mat = model.Materials[g.MaterialID]
    const glow = mat?.Layers.some((l) => typeof l.TextureID === 'number' && model.Textures[l.TextureID]?.ReplaceableId === 2)
    if (glow) g.Vertices.fill(0)
  }
  const gl = document.createElement('canvas')
  gl.width = w
  gl.height = h
  const opts = { alpha: true, premultipliedAlpha: false, preserveDrawingBuffer: true, antialias: true }
  const ctx = (gl.getContext('webgl2', opts) ?? gl.getContext('webgl', opts)) as WebGL2RenderingContext | WebGLRenderingContext | null
  if (!ctx) throw new Error('Trình duyệt không hỗ trợ WebGL')
  const renderer = new ModelRenderer(model)
  renderer.initGL(ctx)
  const done = new Set<string>()
  for (const tex of model.Textures) {
    if (!tex.Image || done.has(tex.Image)) continue
    done.add(tex.Image)
    renderer.setTextureImageData(tex.Image, await blpImageData(tex.Image))
  }
  return { model, renderer, gl, ctx }
}

function drawFrame(rig: Rig, frame: number, mv: mat4, proj: mat4) {
  const { ctx, renderer, gl } = rig
  renderer.setFrame(frame)
  renderer.update(0)
  ctx.viewport(0, 0, gl.width, gl.height)
  ctx.clearColor(0, 0, 0, 0)
  ctx.clear(ctx.COLOR_BUFFER_BIT | ctx.DEPTH_BUFFER_BIT)
  ctx.enable(ctx.DEPTH_TEST)
  ctx.depthFunc(ctx.LEQUAL)
  renderer.render(mv, proj, { wireframe: false })
}

function release(rig: Rig) {
  // renderer.destroy() của thư viện lỗi với WebGL thường; bỏ luôn context.
  rig.ctx.getExtension('WEBGL_lose_context')?.loseContext()
}

export interface Portrait {
  canvas: HTMLCanvasElement
  w: number
  h: number
  frames: number
  ms: number
}

/** Chân dung động kiểu WC3, dùng camera có sẵn trong model. */
export async function bakePortrait(modelPath: string, seqName: string, frames = 24, w = 120, h = 140): Promise<Portrait> {
  const rig = await createRig(modelPath, w, h)
  const cam = rig.model.Cameras[0]
  if (!cam) throw new Error('Model không có camera chân dung')
  const seq = rig.model.Sequences.find((s) => s.Name.toLowerCase() === seqName.toLowerCase()) ?? rig.model.Sequences[0]
  const [start, end] = seq.Interval
  const view = mat4.lookAt(mat4.create(), cam.Position as unknown as vec3, cam.TargetPosition as unknown as vec3, [0, 0, 1])
  const proj = mat4.perspective(mat4.create(), cam.FieldOfView * 0.75, w / h, cam.NearClip, cam.FarClip)
  const sheet = document.createElement('canvas')
  sheet.width = w * frames
  sheet.height = h
  const out = sheet.getContext('2d')!
  for (let f = 0; f < frames; f++) {
    drawFrame(rig, start + ((end - start) * f) / frames, view, proj)
    out.drawImage(rig.gl, f * w, 0)
  }
  release(rig)
  return { canvas: sheet, w, h, frames, ms: end - start }
}
