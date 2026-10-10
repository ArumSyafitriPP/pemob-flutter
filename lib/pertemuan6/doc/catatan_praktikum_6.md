# Catatan Belajar Flutter — Pertemuan 6
## Tema, Routing dan Navigasi, serta Animasi

## 1. Gambaran Umum

Pada pertemuan ini, saya belajar membuat aplikasi Flutter yang tampilannya bisa disesuaikan, memiliki beberapa halaman, dan dilengkapi animasi agar lebih interaktif.

Materi yang dipelajari meliputi:
- Pengaturan tema terang, gelap, dan warna aplikasi.
- Perpindahan halaman menggunakan named routes.
- Pengiriman data ke halaman detail.
- Penerapan animasi pada aplikasi.
- Navigasi tab bawah.
- Penyimpanan pengaturan menggunakan SharedPreferences.

## 2. Tema Terang, Gelap, dan Warna Aplikasi

Tema digunakan untuk mengatur tampilan aplikasi, seperti warna latar belakang, teks, tombol, dan AppBar. Dengan sistem tema, tampilan aplikasi dapat berubah secara bersamaan tanpa harus mengatur warna setiap bagian secara manual.

Beberapa hal yang perlu dipahami:
- **ThemeData:** digunakan untuk menentukan pengaturan tema aplikasi.
- **Theme.of(context):** digunakan untuk mengambil tema yang sedang aktif.
- **ValueNotifier:** menyimpan nilai yang dapat berubah dan memberi tahu bagian aplikasi yang mengamatinya.
- **ListenableBuilder:** membantu memperbarui tampilan ketika nilai yang diamati berubah.

Pada praktikum, saya mencoba mengganti mode terang dan gelap serta memilih warna tema. Perubahan tersebut dapat langsung terlihat pada tampilan aplikasi.

**Intinya:** penggunaan sistem tema membuat tampilan lebih konsisten dan mempermudah penggantian warna aplikasi.

## 3. Named Routes, Argumen, dan Hero

### Named Routes

Named routes adalah cara berpindah halaman menggunakan nama rute yang telah ditentukan. Cara ini membantu pengelolaan navigasi ketika aplikasi memiliki beberapa halaman.

### Argumen

Argumen digunakan untuk mengirim data dari satu halaman ke halaman lain. Contohnya, ketika pengguna memilih sebuah item, informasi item tersebut dikirim ke halaman detail agar halaman tujuan dapat menampilkan informasi yang sesuai.

### Hero

Hero adalah fitur animasi yang menghubungkan elemen pada halaman asal dengan elemen pada halaman tujuan. Misalnya, ikon pada daftar terlihat bergerak dan membesar ketika pengguna membuka halaman detail.

Hal penting yang perlu diingat:
- Elemen Hero pada kedua halaman harus memiliki tag yang sama agar dapat dihubungkan.
- Tag Hero harus unik untuk setiap elemen Hero dalam satu halaman.
- Penggunaan tag yang sama pada beberapa Hero dalam satu halaman dapat menyebabkan error.

**Intinya:** named routes mengatur perpindahan halaman, argumen membawa data, sedangkan Hero membuat perpindahan elemen terlihat lebih halus.

## 4. Jenis-Jenis Animasi

Animasi membuat perubahan tampilan aplikasi terasa lebih menarik dan tidak kaku. Pada praktikum ini, saya mempelajari animasi implisit, animasi eksplisit, dan beberapa jenis transisi.

### A. Animasi Implisit

Animasi implisit cocok untuk perubahan tampilan sederhana karena Flutter mengatur proses animasinya secara otomatis ketika nilai tampilan berubah.

Contohnya:
- **AnimatedContainer:** memberikan animasi pada perubahan ukuran, warna, atau bentuk.
- **AnimatedSwitcher:** memberikan transisi ketika widget yang ditampilkan berganti.
- **AnimatedOpacity:** membuat widget perlahan terlihat atau memudar.

### B. Animasi Eksplisit

Animasi eksplisit digunakan ketika pengembang membutuhkan kontrol lebih besar terhadap jalannya animasi, misalnya untuk memulai, menghentikan, atau mengulang animasi.

Pada praktikum, animasi ini diterapkan pada ikon roda gigi yang berputar secara terus-menerus dan dapat dikontrol melalui tombol.

Salah satu hal penting adalah pengendali animasi harus dibersihkan ketika widget tidak lagi digunakan. Tujuannya agar sumber daya yang dipakai tidak terus berjalan ketika sudah tidak diperlukan.

### C. FadeTransition

FadeTransition digunakan untuk memberikan efek perubahan transparansi saat suatu widget muncul atau berpindah tampilan. Efek ini dapat membuat perpindahan halaman terasa lebih lembut.

**Perbedaan sederhananya:** animasi implisit cocok untuk perubahan sederhana, sedangkan animasi eksplisit cocok ketika jalannya animasi perlu dikontrol lebih lanjut.

## 5. Navigasi Tab Bawah

NavigationBar digunakan untuk membuat menu navigasi di bagian bawah aplikasi. Pada praktikum, beberapa halaman digabungkan menjadi satu aplikasi dengan tiga tab utama:

1. **Beranda:** menampilkan daftar item dan akses ke halaman detail.
2. **Animasi:** menampilkan berbagai contoh animasi.
3. **Pengaturan:** digunakan untuk mengubah mode terang atau gelap dan warna tema.

Aplikasi menggunakan IndexedStack untuk menampilkan halaman sesuai tab yang dipilih. Widget ini juga membantu mempertahankan kondisi halaman yang tidak sedang terlihat, sehingga pengguna dapat berpindah tab tanpa harus selalu memulai halaman dari awal.

Perbedaan yang perlu dipahami:
- **NavigationBar:** menyediakan menu untuk berpindah tab.
- **IndexedStack:** menampilkan halaman berdasarkan tab yang dipilih dan membantu mempertahankan kondisinya.
- **Navigator:** digunakan untuk membuka halaman lain, seperti halaman detail.

## 6. Menyimpan Pengaturan dengan SharedPreferences

Pengaturan yang hanya disimpan dalam variabel biasa dapat kembali ke nilai awal ketika aplikasi dijalankan ulang. Untuk mengatasi hal tersebut, SharedPreferences dapat digunakan untuk menyimpan data sederhana secara lokal di perangkat.

Contoh data yang dapat disimpan:
- Pilihan mode terang atau gelap.
- Warna tema yang dipilih pengguna.
- Preferensi sederhana lainnya.

Pada praktikum, SharedPreferences digunakan agar pilihan tema tidak hilang ketika aplikasi ditutup dan dibuka kembali.

Untuk menyimpan pilihan warna, warna perlu diubah menjadi bentuk nilai sederhana sebelum disimpan, kemudian dikembalikan menjadi warna ketika aplikasi membaca pengaturan tersebut.

**Intinya:** SharedPreferences cocok untuk menyimpan pengaturan sederhana, tetapi bukan untuk menyimpan data dalam jumlah besar atau data terstruktur seperti daftar transaksi.

## 7. Pengembangan pada Latihan Mandiri

Pada latihan mandiri, aplikasi dikembangkan dengan menambahkan beberapa fitur, yaitu:

- Menyimpan pilihan mode gelap dan warna tema menggunakan SharedPreferences.
- Menambahkan Drawer sebagai menu samping.
- Menggunakan FadeTransition untuk memberikan efek transisi pada halaman detail.
- Menangani rute yang tidak dikenal dengan halaman 404.
- Menambahkan AnimatedOpacity sebagai demo animasi tambahan.

Latihan ini membantu saya memahami cara menggabungkan tema, navigasi, animasi, dan penyimpanan lokal dalam satu aplikasi.

## 8. Penerapan pada Tugas Profil Diri Interaktif

Pada tugas akhir, materi yang telah dipelajari diterapkan dalam aplikasi profil diri interaktif. Aplikasi memiliki tiga tab menggunakan NavigationBar, halaman detail yang dibuka melalui named routes, animasi Hero, serta animasi implisit dan eksplisit.

Selain itu, aplikasi dilengkapi pengaturan mode terang dan gelap serta pilihan warna tema yang disimpan menggunakan SharedPreferences. Sistem tema digunakan agar tampilan berbagai bagian aplikasi tetap mengikuti pilihan pengguna.

Melalui tugas ini, saya belajar bahwa beberapa fitur Flutter dapat digabungkan untuk menghasilkan aplikasi yang lebih menarik, interaktif, dan nyaman digunakan.

## 9. Hal Penting yang Perlu Diingat

- Tema membantu menjaga tampilan aplikasi tetap konsisten.
- Named routes mempermudah perpindahan halaman berdasarkan nama rute.
- Argumen digunakan untuk mengirim data ke halaman tujuan.
- Hero memberikan animasi perpindahan elemen ant halaman.
- AnimatedContainer, AnimatedSwitcher, dan AnimatedOpacity cocok untuk berbagai perubahan tampilan.
- Animasi eksplisit memberikan kontrol lebih besar terhadap jalannya animasi.
- NavigationBar digunakan untuk membuat navigasi tab bawah.
- IndexedStack membantu mempertahankan kondisi halaman saat berpindah tab.
- SharedPreferences digunakan untuk menyimpan pengaturan sederhana.
- Pengendali animasi perlu dibersihkan ketika sudah tidak digunakan.

