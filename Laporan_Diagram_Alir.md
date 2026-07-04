# 📊 Laporan Diagram Alir
## Sistem Identitas Penduduk Digital (DigitalID Smart Contract)

---

## KETERANGAN SIMBOL DIAGRAM ALIR (Standar ISO 5807)

```
  ( )        = Terminal / Terminator  → Mulai / Selesai
 /   /       = Parallelogram          → Input / Output
[     ]      = Persegi Panjang        → Proses
  < >        = Belah Ketupat          → Keputusan / Decision
   ↓         = Anak Panah             → Arah Aliran
```

---

## 1. FUNGSI: `register(address user, string nik, string nama)`

```
                    ╭─────────╮
                    │  MULAI  │
                    ╰────┬────╯
                         │
                         ▼
               ╔═════════════════════╗
               ║  INPUT:             ║
               ║  - address user     ║
               ║  - string nik       ║
               ║  - string nama      ║
               ╚═════════╤═══════════╝
                         │
                         ▼
               ┌─────────────────────┐
               │ Simpan data ke      │
               │ identities[user]    │
               │ = Identity{nik,nama}│
               └─────────┬───────────┘
                         │
                         ▼
               ┌─────────────────────┐
               │ Simpan              │
               │ nikToName[nik]=nama │
               └─────────┬───────────┘
                         │
                         ▼
               ┌─────────────────────┐
               │ Simpan              │
               │ nameToNik[nama]=nik │
               └─────────┬───────────┘
                         │
                         ▼
               ╔═════════════════════╗
               ║  OUTPUT:            ║
               ║  Data identitas     ║
               ║  tersimpan di       ║
               ║  blockchain         ║
               ╚═════════╤═══════════╝
                         │
                         ▼
                    ╭─────────╮
                    │ SELESAI │
                    ╰─────────╯
```

---

## 2. FUNGSI: `verify(address user, string nik, string nama)`

```
                    ╭─────────╮
                    │  MULAI  │
                    ╰────┬────╯
                         │
                         ▼
               ╔═════════════════════╗
               ║  INPUT:             ║
               ║  - address user     ║
               ║  - string nik       ║
               ║  - string nama      ║
               ╚═════════╤═══════════╝
                         │
                         ▼
               ┌─────────────────────┐
               │ Ambil data dari     │
               │ identities[user]    │
               │ (baca blockchain)   │
               └─────────┬───────────┘
                         │
                         ▼
               ┌─────────────────────┐
               │ Hitung:             │
               │ H1 = keccak256      │
               │ (nik + nama) INPUT  │
               └─────────┬───────────┘
                         │
                         ▼
               ┌─────────────────────┐
               │ Hitung:             │
               │ H2 = keccak256      │
               │ (nik + nama) STORED │
               └─────────┬───────────┘
                         │
                         ▼
                  ◇─────────────────◇
                 ◇   H1  ==  H2 ?    ◇
                  ◇─────────────────◇
                  /                  \
                YA                   TIDAK
                 │                     │
                 ▼                     ▼
       ╔══════════════╗      ╔══════════════════╗
       ║ OUTPUT:      ║      ║ OUTPUT:          ║
       ║ return true  ║      ║ return false     ║
       ║ (VALID)      ║      ║ (TIDAK VALID)    ║
       ╚══════╤═══════╝      ╚════════╤═════════╝
              │                       │
              └──────────┬────────────┘
                         │
                         ▼
                    ╭─────────╮
                    │ SELESAI │
                    ╰─────────╯
```

---

## 3. FUNGSI: `isRegistered(address user)`

```
                    ╭─────────╮
                    │  MULAI  │
                    ╰────┬────╯
                         │
                         ▼
               ╔═════════════════════╗
               ║  INPUT:             ║
               ║  - address user     ║
               ╚═════════╤═══════════╝
                         │
                         ▼
               ┌─────────────────────┐
               │ Ambil               │
               │ identities[user].nik│
               │ dari blockchain     │
               └─────────┬───────────┘
                         │
                         ▼
               ┌─────────────────────┐
               │ Konversi nik        │
               │ ke tipe bytes       │
               └─────────┬───────────┘
                         │
                         ▼
                  ◇─────────────────◇
                 ◇  bytes(nik).      ◇
                 ◇  length != 0 ?    ◇
                  ◇─────────────────◇
                  /                  \
                YA                   TIDAK
                 │                     │
                 ▼                     ▼
       ╔══════════════╗      ╔══════════════════╗
       ║ OUTPUT:      ║      ║ OUTPUT:          ║
       ║ return true  ║      ║ return false     ║
       ║ (TERDAFTAR)  ║      ║ (BLM TERDAFTAR)  ║
       ╚══════╤═══════╝      ╚════════╤═════════╝
              │                       │
              └──────────┬────────────┘
                         │
                         ▼
                    ╭─────────╮
                    │ SELESAI │
                    ╰─────────╯
```

---

## 4. DIAGRAM ALIR SISTEM KESELURUHAN

```
                    ╭─────────╮
                    │  MULAI  │
                    ╰────┬────╯
                         │
                         ▼
               ╔═════════════════════╗
               ║  INPUT:             ║
               ║  - address user     ║
               ║  - string nik       ║
               ║  - string nama      ║
               ╚═════════╤═══════════╝
                         │
                         ▼
                  ◇─────────────────◇
                 ◇  isRegistered     ◇
                 ◇    (user) ?       ◇
                  ◇─────────────────◇
                  /                  \
               TIDAK                 YA
                 │                    │
                 ▼                    ▼
       ┌──────────────────┐  ┌──────────────────┐
       │ Panggil          │  │ Panggil          │
       │ register(user,   │  │ verify(user,     │
       │  nik, nama)      │  │  nik, nama)      │
       └────────┬─────────┘  └────────┬─────────┘
                │                     │
                ▼                     ▼
       ┌──────────────────┐    ◇─────────────◇
       │ Data identitas   │   ◇  Hasil verify ◇
       │ tersimpan di     │   ◇  == true ?    ◇
       │ blockchain       │    ◇─────────────◇
       └────────┬─────────┘    /             \
                │            YA              TIDAK
                │             │               │
                │             ▼               ▼
                │   ╔═══════════════╗ ╔═══════════════╗
                │   ║ OUTPUT:       ║ ║ OUTPUT:       ║
                │   ║ Identitas     ║ ║ Identitas     ║
                │   ║ VALID ✓       ║ ║ TIDAK VALID ✗ ║
                │   ╚═══════╤═══════╝ ╚═══════╤═══════╝
                │           │                 │
                └─────┬─────┘                 │
                      └──────────┬────────────┘
                                 │
                                 ▼
                            ╭─────────╮
                            │ SELESAI │
                            ╰─────────╯
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
