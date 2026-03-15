# Mini Project 2 PAB

- Nama : Christian Amsal Asimaro Lumban Tobing
- NIM  : 2409116053

# Deskripsi Aplikasi
Aplikasi Data Tempat Makan di Samarinda merupakan aplikasi berbasis Flutter yang terintegrasi dengan database Supabase untuk mengelola data tempat makan secara online.

Aplikasi ini memungkinkan setiap user untuk melakukan registrasi dan login terlebih dahulu sebelum dapat mengakses data. Setelah login, user dapat menambahkan, melihat, mengedit, dan menghapus data tempat makan miliknya sendiri.

Data yang dikelola meliputi nama tempat makan, alamat, kategori makanan, dan rating. Seluruh data disimpan secara cloud menggunakan Supabase sehingga tidak menggunakan list lokal.

Aplikasi ini juga telah dilengkapi dengan fitur Light Mode dan Dark Mode serta sistem autentikasi berbasis Supabase Auth.

# Fitur Aplikasi

## 1. Menampilkan Daftar Tempat Makan (Read)
- Menampilkan data tempat makan dalam bentuk list.
- Data diambil langsung dari database Supabase.
- Data yang tampil hanya milik user yang sedang login.

## 2. Menambahkan Data Tempat Makan (Create)
- User dapat menekan tombol tambah (FloatingActionButton).
- Akan diarahkan ke halaman form input.
- Data yang disimpan akan langsung tersimpan ke database Supabase.
- Setelah berhasil, daftar akan otomatis diperbarui.

## 3. Mengedit Data Tempat Makan (Update)
- User dapat memilih salah satu item pada daftar.
- Akan diarahkan ke halaman edit.
- Setelah disimpan, data akan diperbarui di database Supabase.

## 4. Menghapus Data Tempat Makan (Delete)
- User dapat menghapus data dengan menekan ikon tempat sampah.
- Terdapat konfirmasi sebelum penghapusan.
- Data akan langsung terhapus dari database dan daftar diperbarui.

## 5. Login dan Register (Nilai Tambah)
- User wajib login sebelum mengakses aplikasi.
- Mendukung Register akun baru menggunakan email & password.
- Autentikasi menggunakan Supabase Auth.
- Logout tersedia pada AppBar.

## 6. Dark Mode & Light Mode (Nilai Tambah)
- User dapat mengganti tema aplikasi secara manual.
- Mendukung tampilan terang (Light Mode) dan gelap (Dark Mode).

## 7. Validasi Input
- Form memiliki validasi agar tidak ada field yang kosong.
- Rating dibatasi antara 1 – 5.
- Mencegah penyimpanan data yang tidak valid.

## 8. Penggunaan File .env (Nilai Tambah)
- SUPABASE_URL dan SUPABASE_ANON_KEY disimpan di file `.env`.
- Meningkatkan keamanan karena tidak ditulis langsung di dalam kode.

# Widget yang Digunakan

Berikut adalah beberapa widget utama yang digunakan dalam aplikasi ini:

## 1. MaterialApp
Digunakan sebagai root aplikasi untuk mengatur tema, navigasi, dan mode terang/gelap.

## 2. Scaffold
Sebagai struktur dasar halaman yang menyediakan:
- AppBar
- Body
- FloatingActionButton

## 3. AppBar
Menampilkan judul halaman serta tombol Logout dan Toggle Theme.

## 4. ListView.builder
Digunakan untuk menampilkan daftar tempat makan secara dinamis dari database.

## 5. ListTile
Digunakan untuk menampilkan setiap item data tempat makan.

## 6. Card
Memberikan tampilan yang lebih rapi untuk setiap item daftar.

## 7. FloatingActionButton
Tombol untuk menambahkan data baru.

## 8. Navigator
Digunakan untuk berpindah halaman dari HomePage ke FormPage.

## 9. StreamBuilder (Nilai Tambah)
Digunakan untuk memantau status autentikasi user secara realtime.

## 10. FutureBuilder
Digunakan untuk menampilkan data yang diambil dari Supabase secara asynchronous.

## 11. Form
Digunakan untuk membungkus input dan melakukan validasi.

## 12. TextFormField
Digunakan untuk input data seperti nama dan alamat.

## 13. DropdownButtonFormField
Digunakan untuk memilih kategori makanan.

## 14. TextEditingController
Digunakan untuk mengontrol dan mengambil nilai dari input field.

## 15. ElevatedButton
Digunakan sebagai tombol simpan pada halaman form.

## 16. StatefulWidget
Digunakan pada:
- HomePage (karena data dapat berubah)
- FormPage (karena adanya input dan validasi)
- AuthPage (karena login & register dinamis)

# Database yang Digunakan

Menggunakan Supabase dengan tabel:

### Tabel: tempat_makan
- id (Primary Key)
- nama (Text)
- alamat (Text)
- kategori (Text)
- rating (Float)
- user_id (UUID)

Data difilter berdasarkan user yang sedang login.
