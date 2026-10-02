# Penjelasan Pertemuan 3 — Flutter Fundamental

## Materi

Pada pertemuan ini mempelajari Form Input dan State Management pada Flutter. Materi meliputi penggunaan TextField, TextEditingController, Form, TextFormField, validasi, serta pengelolaan state menggunakan ChangeNotifier dan Provider.

## Hal yang Dipelajari

### 1. Input dengan TextField

`TextField` digunakan untuk menerima input berupa teks dari pengguna. Nilai yang dimasukkan dapat diambil menggunakan `TextEditingController`.

`TextEditingController` digunakan untuk membaca dan mengatur isi dari input. Controller perlu di-dispose ketika halaman sudah tidak digunakan agar penggunaan memori dapat dibersihkan.

### 2. Form dan Validasi

`Form` digunakan untuk mengelompokkan beberapa input yang membutuhkan validasi. Validasi dilakukan menggunakan `TextFormField` dan fungsi `validator`.

Validator dapat memberikan pesan error jika data yang dimasukkan belum sesuai dengan ketentuan. Jika data valid, validator mengembalikan nilai `null`.

Beberapa komponen yang digunakan dalam form antara lain:

- `TextFormField` untuk input teks.
- `DropdownButtonFormField` untuk memilih salah satu pilihan.
- `CheckboxListTile` untuk pilihan persetujuan.
- `GlobalKey<FormState>` untuk mengelola dan menjalankan validasi form.

### 3. State Management

State merupakan data yang dapat berubah dan memengaruhi tampilan aplikasi.

Untuk state yang hanya digunakan pada satu halaman, `setState()` dapat digunakan. Namun, jika data perlu digunakan oleh beberapa widget atau halaman, diperlukan pengelolaan state yang lebih teratur.

Salah satu cara yang digunakan adalah `Provider` dengan `ChangeNotifier`. Data disimpan dalam satu objek bersama sehingga dapat digunakan oleh beberapa halaman.

### 4. ChangeNotifier dan Provider

`ChangeNotifier` digunakan sebagai tempat untuk menyimpan dan mengatur perubahan data. Setelah data berubah, `notifyListeners()` dipanggil agar widget yang menggunakan data tersebut dapat memperbarui tampilannya.

`Provider` digunakan untuk membagikan objek state kepada widget yang membutuhkan.

### 5. context.watch dan context.read

`context.watch<T>()` digunakan untuk membaca data sekaligus memantau perubahan data. Jika data berubah, widget akan diperbarui kembali.

`context.read<T>()` digunakan untuk mengakses data tanpa ikut memantau perubahan. Biasanya digunakan ketika ingin menjalankan fungsi dalam callback seperti `onPressed` atau `onChanged`.

## Praktikum

### Bagian A: Input Dasar dengan TextField

Pada bagian ini dibuat halaman input sederhana menggunakan `TextField` dan `TextEditingController`. Pengguna dapat memasukkan nama, kemudian menekan tombol Sapa untuk menampilkan pesan sapaan berdasarkan nama yang dimasukkan.

### Bagian B: Form dengan Validasi

Pada bagian ini dibuat form pendaftaran yang memiliki beberapa input, yaitu nama, email, jurusan, dan persetujuan. Setiap input diberikan validasi agar data yang dimasukkan sesuai dengan ketentuan. Jika data valid dan pengguna menyetujui ketentuan, aplikasi menampilkan informasi pendaftaran melalui `SnackBar`.

### Bagian C: Mengapa Butuh State Management?

Pada bagian ini dipelajari keterbatasan `setState()` ketika data digunakan oleh beberapa halaman. Pada aplikasi Daftar Tugas, halaman daftar dan halaman tambah membutuhkan data yang sama. Jika data terus dikirim melalui constructor dan callback antar halaman, pengelolaannya dapat menjadi lebih rumit. Oleh karena itu, data dapat disimpan dalam satu objek bersama yang dapat diakses oleh beberapa halaman menggunakan Provider.

### Bagian D: Aplikasi Daftar Tugas dengan Provider

Pada bagian ini dibuat aplikasi Daftar Tugas menggunakan `Provider` dan `ChangeNotifier`. Aplikasi dapat menambahkan tugas, menandai tugas sebagai selesai, dan menghapus tugas.

Data tugas disimpan dalam `TugasModel`. Perubahan data diberitahukan menggunakan `notifyListeners()` sehingga tampilan dapat diperbarui secara otomatis.

## Latihan Mandiri

Pada latihan mandiri, aplikasi Daftar Tugas dikembangkan dengan beberapa fitur tambahan:

1. Menambahkan validasi judul minimal 3 karakter menggunakan `Form` dan `TextFormField`.
2. Menambahkan `hapusSelesai()` untuk menghapus semua tugas yang sudah selesai.
3. Menampilkan `SnackBar` dengan pesan "Tugas ditambahkan" setelah tugas berhasil disimpan.
4. Menampilkan teks "Belum ada tugas" di tengah halaman ketika daftar tugas masih kosong.

## Tugas Daftar Belanja

Pada tugas ini dibuat aplikasi Daftar Belanja dengan dua halaman utama, yaitu halaman form tambah dan halaman daftar.

Halaman form digunakan untuk memasukkan nama barang, jumlah, dan kategori. Setiap input memiliki validasi, seperti nama wajib diisi, jumlah harus berupa angka lebih dari 0, dan kategori wajib dipilih.

Halaman daftar menampilkan seluruh barang yang telah ditambahkan. Pengguna dapat menandai barang sebagai sudah dibeli menggunakan checkbox dan menghapus barang dari daftar.

State aplikasi disimpan dalam satu `ChangeNotifier` dan dibagikan menggunakan `Provider`. AppBar menampilkan jumlah barang yang belum dibeli.

## Kesimpulan

Pertemuan ini memberikan pemahaman mengenai cara menerima input, melakukan validasi form, dan mengelola state dalam aplikasi Flutter. Penggunaan `Provider` dan `ChangeNotifier` membantu mengelola data yang digunakan oleh beberapa halaman sehingga perubahan data dapat ditampilkan dengan baik. Materi kemudian diterapkan melalui aplikasi Daftar Tugas dan Daftar Belanja dengan berbagai fitur seperti validasi, penambahan, perubahan status, dan penghapusan data.