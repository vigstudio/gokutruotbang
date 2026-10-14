// Server game Goku trượt băng.
//
//	go run ./cmd/server -addr :8080 -static ../web/dist
//
// Biến môi trường (dùng trong docker-compose):
//
//	DATABASE_URL     postgres://user:pass@host:5432/db  (trống = lưu trong bộ nhớ)
//	REDIS_URL        redis://host:6379/0
//	ALLOWED_ORIGINS  goku.nghiane.com,localhost:8080   (trống = cho phép tất cả)
package main

import (
	"context"
	"flag"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	"gokutruotbang/internal/mapdata"
	"gokutruotbang/internal/netserver"
	"gokutruotbang/internal/store"
)

func main() {
	addr := flag.String("addr", env("ADDR", ":8080"), "địa chỉ lắng nghe")
	static := flag.String("static", env("STATIC_DIR", "../web/dist"), "thư mục client đã build")
	flag.Parse()

	m, err := mapdata.Load()
	if err != nil {
		log.Fatal("đọc map:", err)
	}

	ctx := context.Background()
	var st store.Store
	if dsn := os.Getenv("DATABASE_URL"); dsn != "" {
		pg, err := store.NewPostgres(ctx, dsn, os.Getenv("REDIS_URL"))
		if err != nil {
			log.Fatal(err)
		}
		st = pg
		log.Println("Lưu trữ: Postgres", map[bool]string{true: "+ Redis", false: ""}[os.Getenv("REDIS_URL") != ""])
	} else {
		st = store.NewMemory()
		log.Println("Lưu trữ: bộ nhớ (không có DATABASE_URL)")
	}
	defer st.Close()

	var origins []string
	for _, o := range strings.Split(os.Getenv("ALLOWED_ORIGINS"), ",") {
		if o = strings.TrimSpace(o); o != "" {
			origins = append(origins, o)
		}
	}
	srv := netserver.New(m, st, netserver.Config{AllowedOrigins: origins, StaticDir: *static})
	httpSrv := &http.Server{Addr: *addr, Handler: srv.Handler(), ReadHeaderTimeout: 10 * time.Second}

	go func() {
		sig := make(chan os.Signal, 1)
		signal.Notify(sig, syscall.SIGINT, syscall.SIGTERM)
		<-sig
		c, cancel := context.WithTimeout(ctx, 5*time.Second)
		defer cancel()
		httpSrv.Shutdown(c)
	}()

	log.Printf("Map %q của %s - %d region, %d unit", m.Name, m.Author, len(m.Regions), len(m.Units))
	log.Printf("Server chạy tại http://localhost%s", *addr)
	if err := httpSrv.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		log.Fatal(err)
	}
}

func env(k, def string) string {
	if v := os.Getenv(k); v != "" {
		return v
	}
	return def
}
