# Catatan Belajar Praktikum Flutter Pertemuan 4
## Mengambil Data dari REST API

## 1. Gambaran Umum

Di pertemuan 4 ini, saya belajar cara mengambil data dari internet dan menampilkannya di aplikasi Flutter.

Sebelumnya, data yang ditampilkan biasanya sudah ditulis langsung di dalam kode. Sekarang, data bisa diambil dari server menggunakan REST API.

Alur sederhananya:

**Aplikasi → Meminta data ke API → Menerima JSON → Mengolah data → Menampilkan ke layar**

Ada beberapa hal penting yang perlu dipahami, yaitu `Future`, `FutureBuilder`, HTTP, JSON, dan class model.

## 2. Catatan Materi

### Future dan FutureBuilder

`Future` digunakan untuk proses yang hasilnya baru tersedia setelah beberapa waktu, misalnya mengambil data dari internet.

`FutureBuilder` membantu mengatur tampilan selama proses tersebut berlangsung.

Yang perlu diingat:
- **Loading:** data masih diproses.
- **Berhasil:** data sudah diterima dan bisa ditampilkan.
- **Error:** proses gagal dan perlu ditangani.

Pada Bagian A, konsep ini dicoba tanpa internet menggunakan `Future.delayed()` selama dua detik.

### HTTP dan REST API

Paket `http` digunakan untuk mengirim permintaan ke server. Di praktikum ini, saya menggunakan `http.get()` untuk mengambil data.

Sebelum itu, paket HTTP harus ditambahkan dan izin internet perlu diatur di `AndroidManifest.xml`.

API yang digunakan adalah JSONPlaceholder:
- `/users` untuk mengambil daftar pengguna.
- `/posts` untuk mengambil daftar postingan.
- `/posts/{id}/comments` untuk mengambil komentar dari postingan tertentu.

### JSON dan Model

Data dari API biasanya diterima dalam format JSON. Supaya lebih mudah digunakan di Flutter, data tersebut diubah menjadi objek menggunakan class model.

Contohnya:
- `Pengguna` menyimpan nama, email, nomor telepon, dan website.
- `Post` menyimpan judul dan isi postingan.
- `Komentar` menyimpan nama, email, dan isi komentar.

Fungsi `fromJson()` bertugas mengubah data JSON menjadi objek yang sesuai dengan modelnya.

**Intinya:** model membuat data lebih teratur dan lebih mudah diakses di dalam kode.

## 3. Ringkasan Bagian Praktikum

| Bagian | Yang saya pelajari |
|---|---|
| A | Mengenal Future dan FutureBuilder menggunakan jeda dua detik. |
| B | Menambahkan paket HTTP dan izin akses internet. |
| C | Membuat model Pengguna dan fungsi untuk mengambil data API. |
| D | Menampilkan daftar pengguna, loading, dan pesan error. |
| E | Membuka halaman detail dari pengguna yang dipilih. |
| F | Mencoba menangani error endpoint dan koneksi internet. |
| Latihan mandiri | Menambahkan username, kota, jumlah pengguna, dan fitur tarik untuk refresh. |
| Tugas | Membuat daftar postingan beserta detail dan komentarnya. |

## 4. Hal Penting dari Kode

### `initState()`

Digunakan untuk menjalankan pengambilan data saat halaman pertama kali dibuat.

Future disimpan dalam variabel agar tidak terus-menerus membuat permintaan baru setiap kali `build()` dipanggil.

### `snapshot.hasError`

Digunakan untuk mengetahui apakah Future mengalami error.

Jika terjadi error, aplikasi bisa menampilkan pesan kesalahan dan tombol **Coba lagi**.

### `response.statusCode`

Digunakan untuk memeriksa hasil respons dari server.

- `200` = permintaan berhasil.
- `404` = data atau endpoint tidak ditemukan.
- `500` = terjadi masalah pada server.

Kalau koneksi internet bermasalah, permintaan juga bisa gagal tanpa menghasilkan respons HTTP yang normal.

### `setState()`

Digunakan untuk memberi tahu Flutter bahwa tampilan perlu diperbarui. Pada tombol refresh, `setState()` digunakan untuk mengganti Future dengan permintaan data yang baru.

### `Navigator.push()`

Digunakan untuk berpindah dari halaman daftar ke halaman detail sambil mengirim data yang dipilih.

## 5. Catatan Percobaan Error

**Percobaan pertama — URL salah**

URL `/users` diubah menjadi `/userz`.

Hasil yang diharapkan adalah error dengan kode `404`. Setelah URL dikembalikan menjadi `/users`, tombol Coba lagi ditekan dan daftar pengguna muncul kembali.

**Percobaan kedua — Internet mati**

Koneksi internet emulator dimatikan, lalu tombol refresh ditekan.

Permintaan gagal karena aplikasi tidak bisa terhubung ke server. Pesan yang muncul bisa berupa error jaringan atau timeout.

Setelah internet dinyalakan kembali, tombol Coba lagi digunakan untuk mengambil data ulang.

**Yang saya pahami:** error tidak selalu berarti kode program salah. Bisa saja alamat API tidak tersedia atau koneksi internet sedang bermasalah.

## 6. Latihan Mandiri dan Tugas

Pada latihan mandiri, saya menambahkan:
- Username pada data pengguna.
- Kota yang diambil dari `address.city`.
- Jumlah pengguna pada AppBar.
- `RefreshIndicator` agar daftar bisa dimuat ulang dengan menarik layar.
- Pesan `Tidak ada data` jika daftar kosong.

Pada tugas Daftar Postingan, konsep yang sama digunakan untuk data postingan dan komentar.

Perbedaannya, aplikasi mengambil data dari dua endpoint:
- `/posts` untuk daftar postingan.
- `/posts/{id}/comments` untuk komentar postingan yang dipilih.

Halaman utama menampilkan judul dan potongan isi. Ketika postingan dipilih, halaman detail menampilkan isi lengkap dan daftar komentar.

Supaya kode lebih rapi, model, layanan pengambilan data, dan halaman UI sebaiknya dipisahkan ke file masing-masing.

## 7. Jawaban Refleksi

**1. Apa yang terjadi jika Future dibuat di dalam `build()`?**

Permintaan data bisa dijalankan berulang kali setiap kali widget mengalami rebuild. Karena itu, Future sebaiknya disimpan di `initState()` untuk pengambilan data awal.

**2. Apa perbedaan `snapshot.hasError` dan `response.statusCode`?**

`response.statusCode` memeriksa respons HTTP dari server, sedangkan `snapshot.hasError` memeriksa apakah proses Future mengalami error. Keduanya membantu menangani kegagalan dari sisi server maupun proses pengambilan data.

**3. Mengapa JSON diubah menjadi class model?**

Supaya struktur data lebih jelas, atribut lebih mudah diakses, dan kode lebih teratur.

**4. Mengapa perlu loading dan error?**

Agar pengguna tahu apakah data sedang dimuat atau terjadi masalah, bukan mengira aplikasi macet.

## 8. Kesimpulan Pribadi

Dari praktikum ini, saya belajar bahwa mengambil data dari internet membutuhkan beberapa proses yang saling berhubungan. Data diminta menggunakan HTTP, diterima dalam bentuk JSON, diubah menjadi objek model, lalu ditampilkan menggunakan widget Flutter.

Saya juga memahami pentingnya loading, penanganan error, dan tombol Coba lagi agar aplikasi tetap mudah digunakan ketika jaringan bermasalah.

Hal yang perlu saya ingat adalah **Future mengurus proses yang belum selesai, FutureBuilder mengatur tampilan berdasarkan proses tersebut, dan model membantu mengelola data agar lebih rapi.**
