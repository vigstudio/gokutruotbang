# ---- 1. build client Vue ----
FROM node:20-alpine AS web
WORKDIR /web
COPY web/package.json web/package-lock.json ./
RUN npm ci --no-audit --no-fund
COPY web/ ./
RUN npm run build

# ---- 2. build server Go ----
FROM golang:1.26-alpine AS server
WORKDIR /src
COPY server/go.mod server/go.sum ./
RUN go mod download
COPY server/ ./
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/goku-server ./cmd/server

# ---- 3. image chạy ----
FROM alpine:3.20
RUN apk add --no-cache ca-certificates tzdata wget && adduser -D -H -u 10001 goku
WORKDIR /app
COPY --from=server /out/goku-server /app/goku-server
COPY --from=web /web/dist /app/web
ENV ADDR=:8080 STATIC_DIR=/app/web TZ=Asia/Ho_Chi_Minh
USER goku
EXPOSE 8080
HEALTHCHECK --interval=15s --timeout=3s --retries=3 CMD wget -qO- http://127.0.0.1:8080/healthz || exit 1
ENTRYPOINT ["/app/goku-server"]
