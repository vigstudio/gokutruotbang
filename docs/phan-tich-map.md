# Phân tích map gốc: Goku truot bang v2.2

File: `Goku truot bang v2.2.w3x` (1.4 MB) — tác giả **vietnghiavnn**, 11 người chơi + 1 phe máy (rồng).

Map đã được "protect": header MPQ bị ghi giá trị rác, `(listfile)` bị xoá, các file import
(model rồng, model Goku, nhạc Kung Fu Panda…) không còn tên nên không giải nén được. Các file
chính (`war3map.j`, `w3e`, `wpm`, `wts`, `w3u`, `w3a`…) đều đọc được bằng `server/cmd/mapconv`.
Script gốc đã giải nén nằm ở [`docs/original/war3map.j`](original/war3map.j) (~10.000 dòng, sinh từ GUI trigger).

## Bản đồ

- Vùng chơi: x ∈ [-3328, 3328], y ∈ [-3584, 3072]. Địa hình: `Nice` (băng, 2505 ô), `Xblm` (đá hoa — vùng an toàn), `Nsnw` (tuyết bên ngoài).
- Đường đi là **xoắn ốc 14 đoạn**: xuất phát góc trên-trái (`Kitty_Start`), chạy sang phải, xuống, sang trái, lên… dần vào **đích** `Next_Round` ở giữa bản đồ.
- Các góc rẽ là ô đá hoa (an toàn), mỗi góc có một vùng `Lvl1..Lvl14` (mốc thưởng XP).
- `SideGuardTop/Bottom/Left/Right*`: dải mỏng sát mép đường — đi vào thì hướng của Goku bị nắn thẳng theo trục để không kẹt tường.

## Unit

| ID | Tên | Vai trò |
|----|-----|---------|
| `E000` | Goku (base: Priestess of the Moon, model `zMidouz.mdl`) | Hero của người chơi, tốc độ 350 |
| `nwwg` | Rồng (model `ChineseDragon.mdl`) | 115 con, đi lang thang (Awan); chạm vào là chết |
| `n001` | Rồng đại ca (scale 2.0, 1000 HP) | Trang trí, **không** giết người (trigger chỉ xét `nwwg`) |
| `n00D` | Goku Zone | Đánh dấu chỗ Goku chết, đồng đội chạm vào để hồi sinh |
| `n00C` | ItemZone | Hộp vật phẩm vô hình, sinh mỗi 5 giây |
| `ngme` | Krusty Krab | 3 cửa hàng bán item |
| `nech` | Hiệu ứng Frost Nova | Trang trí |

## Cơ chế (trigger → bản web)

| Trigger gốc | Hoạt động | Bản web |
|---|---|---|
| `Master_Slide`, `P1_Slide`…`P11_Slide` | Mỗi 0.01s, nếu đứng trên `Nice` thì dịch `4 × speed/defaultSpeed × REALSPD` theo hướng nhìn (≈ 400 đv/s) | `game.tickHero` |
| `Master_Turn_Point/Unit/Item` | Click trên băng: dừng lệnh, chỉ quay mặt về điểm click | `game.Order` |
| `P1`…`P11` | Rồng `nwwg` trong bán kính 40 (+ va chạm) và Goku đang ở mặt đất → Goku chết, tạo Goku Zone, điểm −1 | `game.collisions/killHero` |
| `P1_Revive`… | Goku sống chạm Goku Zone của người khác → hồi sinh tại chỗ, người cứu +30 vàng +50 XP +1 điểm, người được cứu −15 vàng −20 XP | `game.revive` |
| `Lvl1`…`Lvl14` | Đi qua mốc lần đầu trong vòng: XP = 150 × 1.08^điểm | `game.checkpointsFor` |
| `Trigger_Next_Round`, `Next_Round` | Về đích: +300 XP, +200 vàng, +5 điểm; mọi người +100 vàng; dừng 3s rồi đưa tất cả về vạch xuất phát, hồi sinh hết | `game.roundComplete` |
| `Set_level` | Sau mỗi vòng thêm 11 rồng vào 4 đường ngoài, 3 rồng vào 4 đường trong, 3 rồng đường phải, 2 rồng ở 5 góc | `roundSpawns` |
| `Win` | `Round == 5` (qua 4 vòng) → thắng | `FinalRound = 4` |
| `Game_Over`, `Game_End_Dbl_Chk` | Không còn Goku nào sống → thua | `game.checkGameOver` |
| `Wolf_Area_*` | Rồng rời vùng của mình thì bị ra lệnh quay lại | `pickWander` (giới hạn trong vùng) |
| `Kick2`…`Kick11` | Player 1 gõ `-kich p2`… | Chủ phòng gõ `-kick p2` |
| `Spawn`, `Collect_*` | Mỗi 5s sinh vật phẩm ngẫu nhiên, nhặt bằng cách chạm | *chưa làm* |
| `LeapOfFaith` | Dịch chuyển ngẫu nhiên — bị **disable** trong map gốc | không làm |

## Kỹ năng Goku

| Phím | Ability | Hiệu ứng | Cooldown | Mana |
|---|---|---|---|---|
| Q | A001 + `JUMp` | Bay lên 600 (tốc độ 800), giữ lvl/6 s, hạ về 1, giữ lvl/6 s, hạ cánh — trong lúc bay rồng không giết được | 10/20/30/20 | 75/75/75/70 |
| W | A004 Wind Walk | Tàng hình, +20/40/70% tốc độ (trượt cũng nhanh hơn) | 5 | 75 |
| E | A002 Carrion Swarm | Bầy dơi hình nón, 80/140/250/350 sát thương | 10/10/10/9 | 110–150 |
| R | A003 + `Drift` | `REALSPD += 1.25` trong 1.5 s | 20/18/15 | 80 |
| A | A000 + `Thaw` | Sau 1 s đổi ô mục tiêu thành đá `Nrck` 6/14/29 s | 22/30/45 | 75/100/150 |

Hero tối đa level 14 (`war3mapMisc.txt`), XP theo công thức mặc định WC3 (200, 500, 900, …).

## Những chỗ bản web khác bản gốc

- **Va tường**: WC3 đẩy unit về điểm đi được gần nhất; bản web thử lách sang hai bên rồi trượt dọc tường.
- **Đi bộ** trên đá hoa không có tìm đường A*, chỉ đi thẳng và lách vật cản nhỏ.
- **Mana/HP** của Goku là số ước lượng (map gốc dùng chỉ số mặc định của Priestess of the Moon).
- **Rồng**: tốc độ 300, 500 HP — ước lượng từ unit gốc `nwwg`.
- Chưa có: cửa hàng, vật phẩm, nhạc nền, hiệu ứng model gốc (các file import không còn tên trong archive).
