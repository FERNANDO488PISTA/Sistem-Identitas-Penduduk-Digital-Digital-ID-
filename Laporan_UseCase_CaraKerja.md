# 📋 Laporan Use Case & Cara Kerja
## Sistem Identitas Penduduk Digital (DigitalID Smart Contract)

---

## A. KETERANGAN SIMBOL USE CASE DIAGRAM (Standar UML)

```
  O
 /|\       = Aktor            → Pengguna / pihak yang berinteraksi dengan sistem
 / \

(       )  = Ellipse / Oval   → Use Case (fungsionalitas sistem)

┌─────┐
│     │    = Persegi Panjang  → System Boundary (batas sistem)
└─────┘

──────►    = Asosiasi         → Hubungan aktor dengan use case

- - -►     = «include»        → Use case yang selalu dipanggil use case lain
_ _ _►     = «extend»         → Use case opsional yang memperluas use case lain
──────△    = Generalisasi     → Pewarisan antar aktor atau antar use case
```

---

## B. USE CASE DIAGRAM

```
                  SISTEM IDENTITAS PENDUDUK DIGITAL
        ╔══════════════════════════════════════════════════════╗
        ║                                                      ║
   O    ║    ╭─────────────────────────────╮                   ║
  /|\───╫───►│  UC-01: Daftarkan Identitas │                   ║
  / \   ║    ╰─────────────────────────────╯                   ║
        ║                    │                                  ║
 ADMIN  ║              «include»                               ║
        ║                    │                                  ║
        ║                    ▼                                  ║
        ║    ╭─────────────────────────────╮                   ║
        ║    │  UC-03: Cek Status          │                   ║
        ║    │         Pendaftaran         │                   ║
        ║    ╰─────────────────────────────╯                   ║
        ║                                                      ║
        ╠══════════════════════════════════════════════════════╣
        ║                                                      ║
   O    ║    ╭─────────────────────────────╮                   ║
  /|\───╫───►│  UC-02: Verifikasi          │                   ║
  / \   ║    │         Identitas           │                   ║
        ║    ╰─────────────────────────────╯                   ║
        ║                    │                                  ║
 VERI-  ║              «include»                               ║
FIKATOR ║                    │                                  ║
        ║                    ▼                                  ║
   O    ║    ╭─────────────────────────────╮                   ║
  /|\───╫───►│  UC-03: Cek Status          │                   ║
  / \   ║    │         Pendaftaran         │                   ║
        ║    ╰─────────────────────────────╯                   ║
        ║                                                      ║
PENG-   ║    ╭─────────────────────────────╮                   ║
GUNA    ║    │  UC-04: Cari Nama dari NIK  │◄───╫───/|\  O    ║
        ║    ╰─────────────────────────────╯    ║    / \      ║
        ║                                       ║             ║
        ║    ╭─────────────────────────────╮    ║  PENGGUNA   ║
        ║    │  UC-05: Cari NIK dari Nama  │◄───╫─────────    ║
        ║    ╰─────────────────────────────╯    ║             ║
        ║                                       ║             ║
        ║    ╭─────────────────────────────╮    ║             ║
        ║    │  UC-06: Lihat Data          │◄───╫─────────    ║
        ║    │         Identitas           │    ║             ║
        ║    ╰─────────────────────────────╯    ║             ║
        ║                                       ║             ║
        ╚══════════════════════════════════════════════════════╝
```

### Diagram Use Case (Tampilan Bersih)

```
        ┌──────────────────────────────────────────────────────────────┐
        │           SISTEM IDENTITAS PENDUDUK DIGITAL                  │
        │                                                              │
  O     │                  ╭──────────────────────────╮               │
 /|\────┼─────────────────►│  UC-01                   │               │
 / \    │                  │  Daftarkan Identitas      │               │
        │                  ╰──────────────┬───────────╯               │
ADMIN   │                                 │ «include»                  │
        │                                 ▼                            │
        │                  ╭──────────────────────────╮               │
  O     │        ┌─────────►  UC-03                   │               │
 /|\────┼─────┐  │         │  Cek Status Pendaftaran  │               │
 / \    │     │  │         ╰──────────────────────────╯               │
        │     │  │                                                     │
VERIFI- │     │  │         ╭──────────────────────────╮               │
KATOR   │     └──┼─────────►  UC-02                   │               │
        │        │         │  Verifikasi Identitas    │               │
  O     │        │         ╰──────────────────────────╯               │
 /|\────┼────────┤                                                     │
 / \    │        │         ╭──────────────────────────╮               │
        │        ├─────────►  UC-04                   │               │
PENG-   │        │         │  Cari Nama dari NIK      │               │
GUNA    │        │         ╰──────────────────────────╯               │
        │        │                                                     │
        │        │         ╭──────────────────────────╮               │
        │        ├─────────►  UC-05                   │               │
        │        │         │  Cari NIK dari Nama      │               │
        │        │         ╰──────────────────────────╯               │
        │        │                                                     │
        │        │         ╭──────────────────────────╮               │
        │        └─────────►  UC-06                   │               │
        │                  │  Lihat Data Identitas    │               │
        │                  ╰──────────────────────────╯               │
        │                                                              │
        └──────────────────────────────────────────────────────────────┘
```

---

## C. RELASI ANTAR USE CASE

```
UC-01 Daftarkan Identitas
  └──«include»──► UC-03 Cek Status Pendaftaran
        (sebelum mendaftar, sistem mengecek apakah sudah terdaftar)

UC-02 Verifikasi Identitas
  └──«include»──► UC-03 Cek Status Pendaftaran
        (verifikasi hanya bermakna jika data sudah terdaftar)

UC-04, UC-05, UC-06
  └──«extend»───► UC-02 Verifikasi Identitas
        (pencarian data merupakan perluasan dari verifikasi)
```

---

## D. DESKRIPSI USE CASE

### UC-01 — Daftarkan Identitas
| Field | Keterangan |
|---|---|
| **ID** | UC-01 |
| **Nama Use Case** | Daftarkan Identitas Penduduk |
| **Aktor** | Admin / Operator Pemerintah |
| **Fungsi Kontrak** | `register(address user, string nik, string nama)` |
| **Pra-kondisi** | Aktor memiliki akses ke kontrak |
| **Alur Normal** | 1. Admin memasukkan address, NIK, dan Nama → 2. Sistem menyimpan ke 3 mapping di blockchain |
| **Pasca-kondisi** | Data identitas tersimpan permanen di blockchain |
| **Relasi** | «include» UC-03 |
| **Pengecualian** | Data lama tertimpa jika address sudah terdaftar |

---

### UC-02 — Verifikasi Identitas
| Field | Keterangan |
|---|---|
| **ID** | UC-02 |
| **Nama Use Case** | Verifikasi Identitas Penduduk |
| **Aktor** | Verifikator / Lembaga |
| **Fungsi Kontrak** | `verify(address user, string nik, string nama)` |
| **Pra-kondisi** | Identitas sudah terdaftar (UC-01) |
| **Alur Normal** | 1. Masukkan address, NIK, Nama → 2. Hash & bandingkan → 3. Kembalikan boolean |
| **Pasca-kondisi** | `true` = valid, `false` = tidak valid |
| **Relasi** | «include» UC-03 |
| **Pengecualian** | Jika belum terdaftar, selalu `false` |

---

### UC-03 — Cek Status Pendaftaran
| Field | Keterangan |
|---|---|
| **ID** | UC-03 |
| **Nama Use Case** | Cek Status Pendaftaran |
| **Aktor** | Pengguna / Sistem (dipanggil otomatis) |
| **Fungsi Kontrak** | `isRegistered(address user)` |
| **Pra-kondisi** | - |
| **Alur Normal** | 1. Masukkan address → 2. Cek panjang bytes NIK → 3. Kembalikan boolean |
| **Pasca-kondisi** | `true` = terdaftar, `false` = belum |
| **Relasi** | Di-«include» oleh UC-01 dan UC-02 |

---

### UC-04 — Cari Nama dari NIK
| Field | Keterangan |
|---|---|
| **ID** | UC-04 |
| **Nama Use Case** | Pencarian Nama Berdasarkan NIK |
| **Aktor** | Pengguna |
| **Fungsi Kontrak** | `nikToName(string nik)` |
| **Pra-kondisi** | NIK sudah terdaftar |
| **Alur Normal** | 1. Masukkan NIK → 2. Kembalikan Nama |
| **Pasca-kondisi** | Menampilkan nama penduduk |

---

### UC-05 — Cari NIK dari Nama
| Field | Keterangan |
|---|---|
| **ID** | UC-05 |
| **Nama Use Case** | Pencarian NIK Berdasarkan Nama |
| **Aktor** | Pengguna |
| **Fungsi Kontrak** | `nameToNik(string nama)` |
| **Pra-kondisi** | Nama sudah terdaftar |
| **Alur Normal** | 1. Masukkan Nama → 2. Kembalikan NIK |
| **Pasca-kondisi** | Menampilkan NIK penduduk |

---

### UC-06 — Lihat Data Identitas
| Field | Keterangan |
|---|---|
| **ID** | UC-06 |
| **Nama Use Case** | Lihat Data Identitas Lengkap |
| **Aktor** | Pengguna |
| **Fungsi Kontrak** | `identities(address user)` |
| **Pra-kondisi** | Identitas sudah terdaftar |
| **Alur Normal** | 1. Masukkan address → 2. Kembalikan struct {nik, nama} |
| **Pasca-kondisi** | Menampilkan NIK dan Nama |

---

## E. CARA KERJA SISTEM

### ⚙️ 1. Cara Kerja Pendaftaran (`register`)

```
   ADMIN                SMART CONTRACT              BLOCKCHAIN
     │                        │                          │
     │  register(addr,        │                          │
     │   nik, nama)           │                          │
     │───────────────────────►│                          │
     │                        │                          │
     │              ┌─────────┴──────────────────┐       │
     │              │ [PROSES]                   │       │
     │              │ identities[addr]={nik,nama}│       │
     │              │ nikToName[nik] = nama      │       │
     │              │ nameToNik[nama]= nik       │       │
     │              └─────────┬──────────────────┘       │
     │                        │                          │
     │                        │── Tulis state ──────────►│
     │                        │                          │
     │◄── Transaction Hash ───│                          │
     │                        │                          │
```

**Langkah-langkah:**
1. Admin mengirim transaksi dengan parameter: `address`, `NIK`, `Nama`
2. Kontrak menyimpan data ke **3 mapping** di blockchain:
   - `identities[address]` → struct {nik, nama}
   - `nikToName[nik]` → nama
   - `nameToNik[nama]` → nik
3. Data tersimpan **permanen** di storage blockchain
4. Menghasilkan **Transaction Hash** sebagai bukti transaksi

---

### ⚙️ 2. Cara Kerja Verifikasi (`verify`)

```
  VERIFIKATOR          SMART CONTRACT              BLOCKCHAIN
     │                        │                          │
     │  verify(addr,          │                          │
     │   nik, nama)           │                          │
     │───────────────────────►│                          │
     │                        │── Baca identities[addr]─►│
     │                        │◄─ {nik_stored,nama_stored}│
     │                        │                          │
     │              ┌─────────┴──────────────────────┐   │
     │              │ [PROSES]                       │   │
     │              │ H1 = keccak256(nik + nama)     │   │
     │              │      dari INPUT                │   │
     │              │ H2 = keccak256(nik + nama)     │   │
     │              │      dari BLOCKCHAIN           │   │
     │              │                                │   │
     │              │ Keputusan: H1 == H2 ?          │   │
     │              │  YA  → return true             │   │
     │              │  TIDAK → return false          │   │
     │              └─────────┬──────────────────────┘   │
     │                        │                          │
     │◄── bool true / false ──│                          │
     │                        │                          │
```

**Langkah-langkah:**
1. Verifikator memasukkan `address`, `NIK`, dan `Nama` yang diklaim
2. Kontrak membaca data tersimpan dari blockchain
3. Sistem melakukan **hashing keccak256** pada data klaim dan data tersimpan
4. Hash cocok → `true` (identitas valid)
5. Hash tidak cocok → `false` (identitas tidak valid)
6. Fungsi bertipe `view` — **tidak memerlukan gas**

---

### ⚙️ 3. Cara Kerja Cek Terdaftar (`isRegistered`)

```
  PENGGUNA             SMART CONTRACT              BLOCKCHAIN
     │                        │                          │
     │  isRegistered(addr)    │                          │
     │───────────────────────►│                          │
     │                        │── Baca identities[addr]─►│
     │                        │◄─ {nik, nama}            │
     │                        │                          │
     │              ┌─────────┴──────────────────────┐   │
     │              │ [PROSES]                       │   │
     │              │ Konversi nik → bytes           │   │
     │              │                                │   │
     │              │ Keputusan:                     │   │
     │              │  bytes(nik).length != 0 ?      │   │
     │              │  YA  → return true (terdaftar) │   │
     │              │  TIDAK → return false          │   │
     │              └─────────┬──────────────────────┘   │
     │                        │                          │
     │◄── bool true / false ──│                          │
     │                        │                          │
```

---

### ⚙️ 4. Alur Kerja End-to-End

```
┌────────────────────────────────────────────────────────────┐
│                    SKENARIO LENGKAP                        │
└────────────────────────────────────────────────────────────┘

LANGKAH 1 — Admin mendaftarkan penduduk:
  register("0xABC...", "3201010101010001", "Budi Santoso")

  Hasil tersimpan di blockchain:
  ┌───────────────────────────────────────────────────────┐
  │ identities["0xABC..."] = {                            │
  │     nik  : "3201010101010001",                        │
  │     nama : "Budi Santoso"                             │
  │ }                                                     │
  │ nikToName["3201010101010001"] = "Budi Santoso"        │
  │ nameToNik["Budi Santoso"]     = "3201010101010001"    │
  └───────────────────────────────────────────────────────┘

LANGKAH 2 — Cek status pendaftaran:
  isRegistered("0xABC...")
  → true  ✅ (NIK tidak kosong)

LANGKAH 3 — Verifikasi identitas:
  verify("0xABC...", "3201010101010001", "Budi Santoso")
  → true  ✅ (hash cocok)

  verify("0xABC...", "3201010101010001", "Nama Salah")
  → false ❌ (hash tidak cocok)

LANGKAH 4 — Pencarian data:
  nikToName["3201010101010001"]  →  "Budi Santoso"
  nameToNik["Budi Santoso"]      →  "3201010101010001"
```

---

## F. TEKNOLOGI & MEKANISME KEAMANAN

| Mekanisme | Penjelasan |
|---|---|
| **keccak256 Hashing** | NIK+Nama di-hash sebelum dibandingkan, mencegah manipulasi |
| **Blockchain Storage** | Data tersimpan di distributed ledger, tidak dapat diubah tanpa transaksi |
| **Mapping O(1)** | Pencarian data instan tanpa iterasi |
| **view Function** | `verify` & `isRegistered` tidak ubah state → gratis (no gas fee) |
| **abi.encodePacked** | Encoding deterministik untuk hash yang konsisten |

---

*Laporan dibuat berdasarkan kontrak `SistemIdentitasPendudukDigital.sol` — DigitalID Smart Contract*
