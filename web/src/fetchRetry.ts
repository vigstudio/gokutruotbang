// Tải lại khi lỗi mạng tạm thời (máy chủ đang khởi động lại sau deploy,
// Cloudflare đóng kết nối...) thay vì báo lỗi ngay.

const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms))

/** Chạy `fn`, thử lại tối đa `tries` lần với thời gian chờ tăng dần. */
export async function retry<T>(fn: () => Promise<T>, tries = 5, firstDelay = 500): Promise<T> {
  let delay = firstDelay
  for (let i = 1; ; i++) {
    try {
      return await fn()
    } catch (e) {
      if (i >= tries) throw e
      await sleep(delay)
      delay = Math.min(delay * 2, 4000)
    }
  }
}

/** fetch có thử lại khi lỗi mạng hoặc lỗi 5xx (404 thì trả về luôn). */
export function fetchRetry(url: string, init?: RequestInit): Promise<Response> {
  return retry(async () => {
    const r = await fetch(url, init)
    if (r.status >= 500) throw new Error(`${url}: ${r.status}`)
    return r
  })
}
