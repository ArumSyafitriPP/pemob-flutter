# Catatan Belajar Flutter — Pertemuan 5
## Penyimpanan Lokal (SharedPreferences dan SQLite)

## 1. Gambaran Umum

Di pertemuan 5, saya belajar bagaimana aplikasi Flutter menyimpan data di perangkat, sehingga data tidak langsung hilang ketika aplikasi ditutup.

Ada dua cara penyimpanan yang dipelajari:

- **SharedPreferences** untuk menyimpan data sederhana, seperti nama pengguna, tema aplikasi, dan pilihan pengaturan.
- **SQLite** untuk menyimpan data yang lebih terstruktur, seperti catatan dan pengeluaran.

Gampangnya, SharedPreferences cocok untuk menyimpan pilihan pengguna, sedangkan SQLite cocok untuk menyimpan banyak data yang bisa ditambah, ditampilkan, diubah, dan dihapus.

## 2. Bagian A — SharedPreferences

SharedPreferences digunakan untuk menyimpan data kecil dalam bentuk pasangan kunci dan nilai (*key-value*).

Contohnya:
- Nama pengguna.
- Mode terang atau gelap.
- Jumlah berapa kali aplikasi dibuka.

Data disimpan berdasarkan nama kunci. Misalnya, pengaturan tema disimpan dengan kunci tertentu, lalu dibaca kembali ketika aplikasi dijalankan.

Hal yang perlu diingat:
- `setString()` untuk menyimpan teks.
- `getString()` untuk membaca teks.
- `setBool()` untuk menyimpan nilai benar atau salah.
- `getBool()` untuk membaca nilai benar atau salah.
- `setInt()` dan `getInt()` untuk menyimpan dan membaca angka bulat.

**Intinya:** SharedPreferences cocok untuk pengaturan, bukan untuk menyimpan daftar