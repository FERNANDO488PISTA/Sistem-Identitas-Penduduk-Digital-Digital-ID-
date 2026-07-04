# 📊 Laporan Diagram Alir
## Sistem Identitas Penduduk Digital (DigitalID Smart Contract)

---

## KETERANGAN SIMBOL

```
  /‾‾‾‾‾‾‾‾‾‾\
 /   MULAI    \     = Oval / Kapsul   → Titik Awal atau Akhir (Start/End)
 \____________/

 ┌────────────┐
 │   PROSES   │     = Persegi Panjang → Proses, tindakan, atau perhitungan
 └────────────┘

 ╱            ╲
╱   INPUT /    ╲    = Jajargenjang    → Input (masukan) atau Output (keluaran)
╲   OUTPUT     ╱
 ╲            ╱

    /‾‾‾‾‾\
   / KONDISI\        = Belah Ketupat  → Keputusan / percabangan (Ya / Tidak)
   \        /
    \_______/

      ↓  →           = Tanda Panah    → Arah aliran proses
```

---

## 1. FUNGSI: `register(address user, string nik, string nama)`

```
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (     MULAI      )
                   \_____________/
                          │
                          ▼
                ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
               ╱  INPUT:                ╲
              ╱   - address user         ╲
              ╲   - string nik           ╱
               ╲  - string nama        ╱
                ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                          │
                          ▼
                ┌─────────────────────┐
                │ Simpan ke           │
                │ identities[user]    │
                │ = Identity{nik,nama}│
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Simpan              │
                │ nikToName[nik]=nama │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Simpan              │
                │ nameToNik[nama]=nik │
                └──────────┬──────────┘
                           │
                           ▼
                ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
               ╱  OUTPUT:               ╲
              ╱   Data identitas         ╲
              ╲   tersimpan permanen     ╱
               ╲  di blockchain        ╱
                ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                          │
                          ▼
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (    SELESAI     )
                   \_____________/
```

---

## 2. FUNGSI: `verify(address user, string nik, string nama)`

```
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (     MULAI      )
                   \_____________/
                          │
                          ▼
                ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
               ╱  INPUT:                ╲
              ╱   - address user         ╲
              ╲   - string nik           ╱
               ╲  - string nama        ╱
                ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                          │
                          ▼
                ┌─────────────────────┐
                │ Ambil data dari     │
                │ identities[user]    │
                │ (baca blockchain)   │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ H1 = keccak256      │
                │ (nik + nama)        │
                │ dari INPUT          │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ H2 = keccak256      │
                │ (nik + nama)        │
                │ dari BLOCKCHAIN     │
                └──────────┬──────────┘
                           │
                           ▼
                       /‾‾‾‾‾‾‾‾‾\
                      /  H1 == H2  \
                     /      ?       \
                     \             /
                      \           /
                       \‾‾‾‾‾‾‾‾‾/
                       /          \
                     YA           TIDAK
                     │               │
                     ▼               ▼
             ╱‾‾‾‾‾‾‾‾‾‾‾╲   ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
            ╱  OUTPUT:    ╲ ╱  OUTPUT:        ╲
           ╱   return      ╲  return           ╲
           ╲   true (VALID) ╱  false            ╱
            ╲             ╱ ╲  (TIDAK VALID)   ╱
             ╲‾‾‾‾‾‾‾‾‾‾‾╱   ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                     │               │
                     └───────┬───────┘
                             │
                             ▼
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (    SELESAI     )
                   \_____________/
```

---

## 3. FUNGSI: `isRegistered(address user)`

```
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (     MULAI      )
                   \_____________/
                          │
                          ▼
                ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
               ╱  INPUT:                ╲
              ╱   - address user         ╲
              ╲                          ╱
               ╲                        ╱
                ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                          │
                          ▼
                ┌─────────────────────┐
                │ Ambil               │
                │ identities[user].nik│
                │ dari blockchain     │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │ Konversi nik        │
                │ ke tipe bytes       │
                └──────────┬──────────┘
                           │
                           ▼
                       /‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
                      / bytes(nik).     \
                     /  length != 0 ?    \
                     \                  /
                      \                /
                       \‾‾‾‾‾‾‾‾‾‾‾‾‾‾/
                       /               \
                     YA               TIDAK
                     │                   │
                     ▼                   ▼
             ╱‾‾‾‾‾‾‾‾‾‾‾‾‾╲     ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
            ╱  OUTPUT:      ╲   ╱  OUTPUT:         ╲
           ╱   return true   ╲ ╱   return false      ╲
           ╲   (TERDAFTAR)   ╱ ╲   (BLM TERDAFTAR)  ╱
            ╲               ╱   ╲                   ╱
             ╲‾‾‾‾‾‾‾‾‾‾‾‾‾╱     ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                     │                   │
                     └─────────┬─────────┘
                               │
                               ▼
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (    SELESAI     )
                   \_____________/
```

---

## 4. DIAGRAM ALIR SISTEM KESELURUHAN

```
                   /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                  (     MULAI      )
                   \_____________/
                          │
                          ▼
                ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
               ╱  INPUT:                ╲
              ╱   - address user         ╲
              ╲   - string nik           ╱
               ╲  - string nama        ╱
                ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                          │
                          ▼
                      /‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
                     / isRegistered    \
                    /    (user) ?       \
                    \                  /
                     \                /
                      \‾‾‾‾‾‾‾‾‾‾‾‾‾‾/
                      /               \
                   TIDAK              YA
                     │                 │
                     ▼                 ▼
            ┌─────────────────┐  ┌─────────────────┐
            │ Panggil         │  │ Panggil         │
            │ register(user,  │  │ verify(user,    │
            │  nik, nama)     │  │  nik, nama)     │
            └────────┬────────┘  └────────┬────────┘
                     │                    │
                     ▼                    ▼
            ┌─────────────────┐       /‾‾‾‾‾‾‾‾‾‾\
            │ Simpan ke 3     │      / Hasil verify \
            │ mapping di      │     /    == true ?   \
            │ blockchain      │     \               /
            └────────┬────────┘      \             /
                     │                \‾‾‾‾‾‾‾‾‾‾/
                     │                /           \
                     │              YA            TIDAK
                     │               │               │
                     │               ▼               ▼
                     │     ╱‾‾‾‾‾‾‾‾‾‾‾‾╲   ╱‾‾‾‾‾‾‾‾‾‾‾‾‾‾╲
                     │    ╱  OUTPUT:     ╲ ╱  OUTPUT:        ╲
                     │   ╱   Identitas    ╲  Identitas         ╲
                     │   ╲   VALID ✓      ╱  TIDAK VALID ✗     ╱
                     │    ╲             ╱ ╲                   ╱
                     │     ╲‾‾‾‾‾‾‾‾‾‾‾╱   ╲‾‾‾‾‾‾‾‾‾‾‾‾‾‾╱
                     │               │               │
                     └───────┬───────┘               │
                             └──────────┬────────────┘
                                        │
                                        ▼
                             /‾‾‾‾‾‾‾‾‾‾‾‾‾\
                            (    SELESAI     )
                             \_____________/
```

---

## 5. RINGKASAN TABEL INPUT → PROSES → OUTPUT

| Fungsi | Masukan | Proses | Keluaran |
|---|---|---|---|
| `register` | address, NIK, Nama | Simpan ke 3 mapping di blockchain | State blockchain terupdate |
| `verify` | address, NIK, Nama | Hash keccak256 & bandingkan | `bool` true / false |
| `isRegistered` | address | Cek panjang bytes NIK | `bool` true / false |
| `identities` | address | Auto-getter mapping | struct {nik, nama} |
| `nikToName` | NIK (string) | Auto-getter mapping | Nama (string) |
| `nameToNik` | Nama (string) | Auto-getter mapping | NIK (string) |

---

*Laporan dibuat berdasarkan kontrak `SistemIdentitasPendudukDigital.sol` — DigitalID Smart Contract*
