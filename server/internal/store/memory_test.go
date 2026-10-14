package store

import (
	"context"
	"testing"
)

func TestAccounts(t *testing.T) {
	ctx := context.Background()
	m := NewMemory()
	if _, _, err := m.Register(ctx, "a", "123456"); err == nil {
		t.Fatal("tên quá ngắn mà vẫn đăng ký được")
	}
	if _, _, err := m.Register(ctx, "kakalot", "123"); err == nil {
		t.Fatal("mật khẩu quá ngắn mà vẫn đăng ký được")
	}
	p, tok, err := m.Register(ctx, "Kakalot", "supersaiyan")
	if err != nil || tok == "" {
		t.Fatalf("đăng ký: %v", err)
	}
	if _, _, err := m.Register(ctx, "kakalot", "khac123"); err != ErrTaken {
		t.Fatalf("trùng tên (khác hoa thường) phải báo ErrTaken, được %v", err)
	}
	if _, _, err := m.Login(ctx, "kakalot", "sai-mat-khau"); err != ErrBadLogin {
		t.Fatalf("sai mật khẩu phải báo ErrBadLogin, được %v", err)
	}
	p2, tok2, err := m.Login(ctx, "KAKALOT", "supersaiyan")
	if err != nil || p2.ID != p.ID {
		t.Fatalf("đăng nhập: %v", err)
	}
	if _, err := m.Resume(ctx, tok); err != ErrBadSession {
		t.Fatal("phiên cũ phải hết hiệu lực sau khi đăng nhập lại")
	}
	if r, err := m.Resume(ctx, tok2); err != nil || r.ID != p.ID {
		t.Fatalf("khôi phục phiên: %v", err)
	}
}

func TestReservedAndShortUsernames(t *testing.T) {
	bad := []string{"admin", "Administrator", "ad_min", "4dm1n", "xX_admin_Xx", "admin123", "root_", "Moderator", "sysadmin", "qu4ntri", "gok", "abcd", "server"}
	for _, u := range bad {
		if CheckCredentials(u, "secret123") == nil {
			t.Errorf("%q phải bị từ chối", u)
		}
	}
	good := []string{"goku_ss3", "Vegeta99", "trantam", "kakarot"}
	for _, u := range good {
		if err := CheckCredentials(u, "secret123"); err != nil {
			t.Errorf("%q bị từ chối nhầm: %v", u, err)
		}
	}
}
