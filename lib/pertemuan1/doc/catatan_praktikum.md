# Doc Tugas - Pertemuan 1: Pengenalan Flutter, Instalasi, dan Aplikasi Pertama

## Pengenalan Flutter

- `Flutter` : UI toolkit dari Google untuk membuat aplikasi mobile, web, dan desktop dari satu basis kode.
- `Dart` : bahasa pemrograman yang digunakan untuk membuat aplikasi Flutter.
- `Widget` : bagian dasar dalam Flutter yang digunakan untuk membangun tampilan aplikasi.
- `StatelessWidget` : widget yang tampilannya tidak berubah.
- `StatefulWidget` : widget yang tampilannya dapat berubah menggunakan `setState()`.
- `Hot Reload` : fitur untuk melihat perubahan kode secara langsung tanpa harus menjalankan ulang aplikasi.

## Perintah Flutter

- `flutter doctor` : mengecek kondisi instalasi Flutter dan perangkat pendukung.
- `flutter doctor --android-licenses` : menerima lisensi Android SDK.
- `flutter create <nama>` : membuat project Flutter baru.
- `flutter run` : menjalankan aplikasi Flutter.
- `flutter devices` : melihat perangkat atau emulator yang terdeteksi.

## Struktur Folder Project

- `lib/main.dart` : tempat kode utama aplikasi.
- `pubspec.yaml` : berisi konfigurasi project, dependensi, dan aset.
- `android/` dan `ios/` : berisi bagian project untuk platform Android dan iOS.
- `test/` : tempat berkas pengujian.

## Widget Dasar

- `MaterialApp` : pembungkus utama aplikasi Flutter.
- `Scaffold` : menyediakan struktur dasar halaman aplikasi.
- `AppBar` : bagian bar di atas halaman yang biasanya berisi judul.
- `Center` : menempatkan widget di bagian tengah.
- `Column` : menyusun beberapa widget secara vertikal.
- `Text` : menampilkan tulisan.
- `Icon` : menampilkan ikon.
- `SizedBox` : memberikan jarak antar-widget.
- `FloatingActionButton` : tombol berbentuk lingkaran yang dapat digunakan untuk menjalankan suatu aksi.

## Praktikum Bagian D - Hello Flutter

Pada bagian ini dibuat aplikasi sederhana yang menampilkan tulisan
"Halo, nama saya [NAMA]!" pada halaman aplikasi.

### Widget Tree

`MaterialApp` → `Scaffold` → `AppBar` + `Center` → `Text`

## Praktikum Bagian E - Widget Layout Dasar

Pada bagian ini tampilan dikembangkan dengan menambahkan ikon,
nama, dan NIM yang disusun secara vertikal di tengah layar.

### Widget Tree

`MaterialApp` → `Scaffold` → `AppBar` + `Center` → `Column` → `Icon` / `SizedBox` / `Text`

## Praktikum Bagian F - Widget Interaktif

Pada bagian ini aplikasi dibuat agar angka dapat berubah saat tombol
`+` ditekan. Angka akan bertambah secara langsung pada tampilan.

## Latihan Mandiri

Pada latihan mandiri, aplikasi dikembangkan dengan mengubah warna
AppBar dan teks, menambahkan tombol untuk mengurangi dan mereset
angka, serta mencegah angka menjadi negatif.

## Tugas - Kartu Perkenalan

Pada tugas ini dibuat sebuah aplikasi Kartu Perkenalan yang berisi
informasi singkat tentang diri sendiri, seperti foto atau ikon, nama,
NIM, jurusan, dan hobi. Aplikasi dibuat dalam satu halaman dengan
tampilan yang sederhana dan mudah dibaca.

## Pertanyaan Refleksi

### 1. Apa perbedaan StatelessWidget dan StatefulWidget?

`StatelessWidget` adalah widget yang tampilannya tidak berubah,
sedangkan `StatefulWidget` adalah widget yang tampilannya bisa
berubah ketika ada perubahan data atau aksi dari pengguna.

### 2. Mengapa perubahan variabel `_count` perlu dibungkus `setState()`?

Karena `setState()` memberi tahu Flutter bahwa ada perubahan data,
sehingga tampilan dapat diperbarui dan menampilkan angka terbaru.

### 3. Apa keuntungan hot reload dibanding rebuild penuh?

Hot reload membuat perubahan kode langsung terlihat tanpa harus
menjalankan ulang aplikasi dari awal, sehingga proses mencoba dan
memperbaiki kode menjadi lebih cepat.

## Kesimpulan

Pada praktikum Pertemuan 1, saya mempelajari dasar-dasar Flutter,
mulai dari struktur project dan penggunaan widget hingga membuat
tampilan sederhana dan aplikasi yang dapat merespons aksi pengguna.