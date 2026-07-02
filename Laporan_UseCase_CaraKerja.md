# 📋 Laporan Use Case & Cara Kerja
## Sistem Identitas Penduduk Digital (DigitalID Smart Contract)

---

## A. USE CASE DIAGRAM (Tekstual)

```
╔══════════════════════════════════════════════════════════════════╗
║              SISTEM IDENTITAS PENDUDUK DIGITAL                   ║
║                      «DigitalID»                                 ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║   👤 ADMIN / OPERATOR              👤 PENGGUNA / VERIFIKATOR     ║
║   ─────────────────                ─────────────────────────     ║
║                                                                  ║
║   ┌─────────────────────────────────────────────────────────┐   ║
║   │                                                         │   ║
║   │  [Admin] ──────────►  (UC-01) Daftarkan Identitas       │   ║
║   │                            register(address,nik,nama)   │   ║
║   │                                                         │   ║
║   │  [Pengguna] ───────►  (UC-02) Verifikasi Identitas      │   ║
║   │                            verify(address,nik,nama)     │   ║
║   │                                                         │   ║
║   │  [Pengguna] ───────►  (UC-03) Cek Status Pendaftaran    │   ║
║   │                            isRegistered(address)        │   ║
║   │                                                         │   ║
║   │  [Pengguna] ───────►  (UC-04) Cari Nama dari NIK        │   ║
║   │                            nikToName(nik)               │   ║
║   │                                                         │   ║
║   │  [Pengguna] ───────►  (UC-05) Cari NIK dari Nama        │   ║
║   │                            nameToNik(nama)              │   ║
║   │                                                         │   ║
║   │  [Pengguna] ───────►  (UC-06) Lihat Data Identitas      │   ║
║   │                            identities(address)          │   ║
║   │                                                         │   ║
║   └─────────────────────────────────────────────────────────┘   ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## B. DESKRIPSI USE CASE

### UC-01 — Daftarkan Identitas
| Field | Keterangan |
|---|---|
| **Nama Use Case** | Daftarkan Identitas Penduduk |
| **Aktor** | Admin / Operator Pemerintah |
| **Fungsi** | `register(address user, string nik, string nama)` |
| **Pra-kondisi** | Aktor memiliki akses ke kontrak |
| **Alur Normal** | 1. Admin memasukkan address wallet, NIK, dan Nama penduduk → 2. Sistem menyimpan data ke blockchain |
| **Pasca-kondisi** | Data identitas tersimpan permanen di blockchain |
| **Pengecualian** | Data lama akan tertimpa jika address sudah terdaftar |

---

### UC-02 — Verifikasi Identitas
| Field | Keterangan |
|---|---|
| **Nama Use Case** | Verifikasi Identitas Penduduk |
| **Aktor** | Pengguna / Lembaga Verifikator |
| **Fungsi** | `verify(address user, string nik, string nama)` |
| **Pra-kondisi** | Identitas sudah terdaftar via UC-01 |
| **Alur Normal** | 1. Masukkan address, NIK, Nama → 2. Sistem membandingkan hash data → 3. Kembalikan hasil boolean |
| **Pasca-kondisi** | Mengembalikan `true` jika valid, `false` jika tidak |
| **Pengecualian** | Jika belum terdaftar, selalu mengembalikan `false` |

---

### UC-03 — Cek Status Pendaftaran
| Field | Keterangan |
|---|---|
| **Nama Use Case** | Cek Status Pendaftaran |
| **Aktor** | Pengguna / Sistem |
| **Fungsi** | `isRegistered(address user)` |
| **Pra-kondisi** | - |
| **Alur Normal** | 1. Masukkan address → 2. Sistem cek NIK di mapping → 3. Kembalikan boolean |
| **Pasca-kondisi** | `true` = terdaftar, `false` = belum terdaftar |

---

### UC-04 — Cari Nama dari NIK
| Field | Keterangan |
|---|---|
| **Nama Use Case** | Pencarian Nama Berdasarkan NIK |
| **Aktor** | Pengguna / Verifikator |
| **Fungsi** | `nikToName(string nik)` |
| **Pra-kondisi** | NIK sudah terdaftar |
| **Alur Normal** | 1. Masukkan NIK → 2. Sistem kembalikan Nama yang terdaftar |
| **Pasca-kondisi** | Menampilkan nama penduduk |

---

### UC-05 — Cari NIK dari Nama
| Field | Keterangan |
|---|---|
| **Nama Use Case** | Pencarian NIK Berdasarkan Nama |
| **Aktor** | Pengguna / Verifikator |
| **Fungsi** | `nameToNik(string nama)` |
| **Pra-kondisi** | Nama sudah terdaftar |
| **Alur Normal** | 1. Masukkan Nama → 2. Sistem kembalikan NIK yang terdaftar |
| **Pasca-kondisi** | Menampilkan NIK penduduk |

---

### UC-06 — Lihat Data Identitas
| Field | Keterangan |
|---|---|
| **Nama Use Case** | Lihat Data Identitas Lengkap |
| **Aktor** | Pengguna |
| **Fungsi** | `identities(address user)` |
| **Pra-kondisi** | Identitas sudah terdaftar |
| **Alur Normal** | 1. Masukkan address → 2. Sistem kembalikan struct {nik, nama} |
| **Pasca-kondisi** | Menampilkan NIK dan Nama penduduk |

---

## C. CARA KERJA SISTEM

### ⚙️ 1. Cara Kerja Pendaftaran (`register`)

```
ADMIN                    SMART CONTRACT                  BLOCKCHAIN
  │                            │                              │
  │── register(addr,nik,nama) ─►│                              │
  │                            │                              │
  │                    ┌───────┴──────────────────────┐       │
  │                    │ identities[addr] = {nik,nama} │       │
  │                    │ nikToName[nik]   = nama       │       │
  │                    │ nameToNik[nama]  = nik        │       │
  │                    └───────┬──────────────────────┘       │
  │                            │── Tulis state ke storage ───►│
  │                            │                              │
  │◄── Transaction Hash ───────│                              │
  │                            │                              │
```

**Penjelasan:**
1. Admin mengirim transaksi dengan 3 parameter: `address`, `NIK`, `Nama`
2. Kontrak menyimpan data ke **3 mapping** sekaligus:
   - `identities[address]` → struct lengkap {nik, nama}
   - `nikToName[nik]` → nama (pencarian by NIK)
   - `nameToNik[nama]` → nik (pencarian by Nama)
3. Data tersimpan **permanen** di storage blockchain
4. Transaksi menghasilkan **Transaction Hash** sebagai bukti

---

### ⚙️ 2. Cara Kerja Verifikasi (`verify`)

```
VERIFIKATOR              SMART CONTRACT                  BLOCKCHAIN
  │                            │                              │
  │── verify(addr,nik,nama) ──►│                              │
  │                            │◄── Baca identities[addr] ───│
  │                            │                              │
  │                    ┌───────┴──────────────────────────┐   │
  │                    │ HASH_INPUT  = keccak256(nik+nama) │   │
  │                    │ HASH_STORED = keccak256(nik+nama) │   │
  │                    │         dari blockchain           │   │
  │                    │                                   │   │
  │                    │  HASH_INPUT == HASH_STORED ?      │   │
  │                    │  ┌────────┬─────────┐             │   │
  │                    │  │  YA    │  TIDAK  │             │   │
  │                    │  │ true   │  false  │             │   │
  │                    │  └────────┴─────────┘             │   │
  │                    └───────┬──────────────────────────┘   │
  │◄── bool (true/false) ──────│                              │
  │                            │                              │
```

**Penjelasan:**
1. Verifikator memasukkan `address`, `NIK`, dan `Nama` yang diklaim
2. Kontrak membaca data tersimpan dari blockchain
3. Sistem melakukan **hashing keccak256** pada kedua pasang data (klaim vs tersimpan)
4. Jika hash **cocok** → `true` (identitas valid)
5. Jika hash **tidak cocok** → `false` (identitas tidak valid)
6. Proses ini adalah `view` — **tidak memerlukan gas / transaksi**

---

### ⚙️ 3. Cara Kerja Cek Terdaftar (`isRegistered`)

```
PENGGUNA                 SMART CONTRACT                  BLOCKCHAIN
  │                            │                              │
  │── isRegistered(addr) ─────►│                              │
  │                            │◄── Baca identities[addr].nik─│
  │                            │                              │
  │                    ┌───────┴──────────────────────┐       │
  │                    │ bytes(nik).length != 0 ?      │       │
  │                    │  ┌──────────┬─────────────┐   │       │
  │                    │  │ length>0 │  length = 0 │   │       │
  │                    │  │  true    │    false    │   │       │
  │                    │  └──────────┴─────────────┘   │       │
  │                    └───────┬──────────────────────┘       │
  │◄── bool (true/false) ──────│                              │
  │                            │                              │
```

**Penjelasan:**
1. Masukkan `address` yang ingin dicek
2. Kontrak membaca field `nik` dari `identities[address]`
3. Jika `nik` kosong (belum diisi) → `bytes("").length == 0` → `false`
4. Jika `nik` ada → `bytes(nik).length > 0` → `true`

---

## D. ALUR KERJA LENGKAP (End-to-End)

```
┌─────────────────────────────────────────────────────────────────┐
│                    SKENARIO LENGKAP                             │
└─────────────────────────────────────────────────────────────────┘

LANGKAH 1 — Pendaftaran
━━━━━━━━━━━━━━━━━━━━━━━
  Admin memanggil:
  register("0xABC...", "3201010101010001", "Budi Santoso")
  
  Hasil di Blockchain:
  ┌─────────────────────────────────────────────────────┐
  │ identities["0xABC..."] = {                          │
  │     nik:  "3201010101010001",                       │
  │     nama: "Budi Santoso"                            │
  │ }                                                   │
  │ nikToName["3201010101010001"] = "Budi Santoso"      │
  │ nameToNik["Budi Santoso"]     = "3201010101010001"  │
  └─────────────────────────────────────────────────────┘

LANGKAH 2 — Cek Terdaftar
━━━━━━━━━━━━━━━━━━━━━━━━━
  isRegistered("0xABC...")  →  true ✅

LANGKAH 3 — Verifikasi
━━━━━━━━━━━━━━━━━━━━━━
  verify("0xABC...", "3201010101010001", "Budi Santoso")
  → true ✅  (data cocok)

  verify("0xABC...", "3201010101010001", "Budi Salah")
  → false ❌  (nama tidak cocok)

LANGKAH 4 — Pencarian
━━━━━━━━━━━━━━━━━━━━━
  nikToName["3201010101010001"]  →  "Budi Santoso"
  nameToNik["Budi Santoso"]      →  "3201010101010001"
```

---

## E. TEKNOLOGI & MEKANISME KEAMANAN

| Mekanisme | Penjelasan |
|---|---|
| **keccak256 Hashing** | Data NIK+Nama di-hash sebelum dibandingkan, mencegah manipulasi string |
| **Blockchain Storage** | Data tersimpan di distributed ledger, tidak bisa dihapus/diubah tanpa transaksi baru |
| **Mapping** | Struktur data O(1) — pencarian instan tanpa iterasi |
| **view Function** | `verify` & `isRegistered` tidak mengubah state → gratis (no gas) |
| **abi.encodePacked** | Encoding deterministik untuk memastikan hash konsisten |

---

*Laporan dibuat berdasarkan kontrak `SistemIdentitasPendudukDigital.sol` — DigitalID Smart Contract*
