# Catatan Pertemuan 2 — Flutter Fundamental

## Materi

Pada pertemuan ini mempelajari layout, menampilkan data dalam bentuk daftar, membuat model data, serta melakukan navigasi antar halaman pada Flutter.

## Hal yang Dipelajari

### 1. Layout Flutter

Beberapa widget yang digunakan untuk mengatur tampilan:

- **Container** → digunakan sebagai wadah untuk mengatur ukuran, warna, border, radius, padding, dan margin.
- **Padding** → memberikan jarak di sekitar widget.
- **Row** → menyusun widget secara horizontal.
- **Column** → menyusun widget secara vertikal.
- **Expanded** → membuat widget mengisi ruang yang tersedia pada `Row` atau `Column`.

Pada `Row`, sumbu utama adalah horizontal, sedangkan pada `Column` sumbu utamanya adalah vertikal. Pengaturan posisi dapat dilakukan menggunakan `mainAxisAlignment` dan `crossAxisAlignment`.

`Expanded` juga membantu membuat widget di dalam `Row` menyesuaikan ruang yang tersedia sehingga teks panjang tidak menyebabkan tampilan keluar dari batas layar.

### 2. ListView

`ListView` digunakan untuk menampilkan beberapa data dalam bentuk daftar yang dapat di-scroll.

`ListView.builder` digunakan untuk membuat daftar berdasarkan data yang tersedia dan cocok digunakan ketika jumlah data cukup banyak.

`Card` dan `ListTile` dapat digunakan untuk membuat tampilan setiap item agar lebih rapi, misalnya dengan ikon, judul, subjudul, dan ikon di bagian akhir.

### 3. Model Data

Model data digunakan untuk menyimpan informasi dengan struktur yang lebih teratur. Data dapat dibuat menggunakan `class` Dart.

Contohnya:

```dart
class Makanan {
  final String nama;
  final int harga;

  const Makanan(this.nama, this.harga);
}
```
### 4. Navigasi Antar Halaman

Navigasi digunakan untuk berpindah dari halaman daftar ke halaman detail. Data dari item yang dipilih dapat diteruskan ke halaman detail sehingga informasi yang ditampilkan sesuai dengan pilihan pengguna.

- **Navigator.push()** → membuka halaman baru.
- **Navigator.pop()** → kembali ke halaman sebelumnya.

### 5. Kesimpulan

Pertemuan ini memberikan pemahaman tentang cara mengatur layout, menampilkan data dalam bentuk daftar, serta membuat navigasi antar halaman pada Flutter. Materi tersebut kemudian diterapkan melalui aplikasi daftar menu dan daftar kontak.