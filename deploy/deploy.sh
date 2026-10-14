#!/usr/bin/env bash
# Đẩy mã nguồn lên máy chủ rồi build và khởi động lại bằng docker compose.
#
#   HOST=root@your-server bash deploy/deploy.sh
#   HOST=root@your-server DIR=/opt/goku-truot-bang bash deploy/deploy.sh
#
# Lần đầu: script tạo .env từ .env.example với mật khẩu Postgres ngẫu nhiên.
set -euo pipefail
: "${HOST:?Đặt biến HOST, ví dụ HOST=root@your-server}"
DIR="${DIR:-/opt/goku-truot-bang}"
cd "$(dirname "$0")/.."

PKG="$(mktemp -t goku-deploy.XXXXXX).tgz"
trap 'rm -f "$PKG"' EXIT

echo "==> Đóng gói mã nguồn"
tar --exclude='web/node_modules' --exclude='web/dist' --exclude='*.exe' \
    -czf "$PKG" Dockerfile docker-compose.yml .env.example .dockerignore server web

echo "==> Tải lên $HOST:$DIR"
ssh "$HOST" "mkdir -p $DIR"
scp -q "$PKG" "$HOST:/tmp/goku-deploy.tgz"

echo "==> Build và khởi động"
ssh "$HOST" bash -s <<REMOTE
set -euo pipefail
cd $DIR
# xoá mã nguồn cũ để file đã bị xoá ở bản mới không còn sót lại
rm -rf server web
tar -xzf /tmp/goku-deploy.tgz && rm -f /tmp/goku-deploy.tgz
if [ ! -f .env ]; then
  cp .env.example .env
  sed -i "s/^POSTGRES_PASSWORD=.*/POSTGRES_PASSWORD=\$(openssl rand -hex 24)/" .env
fi
docker compose up -d --build
docker image prune -f >/dev/null
docker compose ps
REMOTE
echo "==> Xong"
