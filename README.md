# MINI PROJECT 2 PAB

# 🍽 Samarinda Food List App

## 📌 Deskripsi Aplikasi

Samarinda Food List App adalah aplikasi berbasis Flutter yang digunakan untuk mengelola data tempat makan di Kota Samarinda.  
Aplikasi ini terintegrasi dengan database Supabase sehingga seluruh data disimpan dan diambil langsung dari cloud database (bukan dari list lokal).

Setiap user yang telah login dapat menambahkan, melihat, mengedit, dan menghapus data tempat makan miliknya sendiri.

Aplikasi ini juga telah dilengkapi dengan sistem autentikasi (Login & Register), serta fitur Light Mode dan Dark Mode.

---

## 🚀 Fitur Aplikasi

### ✅ Fitur Wajib
- **Create** → Menambahkan data tempat makan ke Supabase
- **Read** → Menampilkan daftar tempat makan dari Supabase
- **Update** → Mengedit data tempat makan
- **Delete** → Menghapus data tempat makan
- Navigasi antar halaman:
  - Halaman List Data
  - Halaman Form Tambah / Edit
- Minimal 3 field input dalam form:
  - Nama Tempat
  - Alamat
  - Kategori
  - Rating
- Data tersimpan di database Supabase (bukan list lokal)

---

### ⭐ Nilai Tambah
- Login dan Register menggunakan Supabase Authentication
- Logout
- Dark Mode & Light Mode (toggle manual)
- Penggunaan file `.env` untuk menyimpan SUPABASE_URL dan SUPABASE_ANON_KEY
- Data ditampilkan berdasarkan user yang sedang login

---

## 🧱 Struktur Aplikasi
