import 'package:flutter/material.dart';

void main() {
  runApp(const TabungKuApp());
}

// Widget utama aplikasi.
class TabungKuApp extends StatelessWidget {
  const TabungKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TabungKu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF557CA8),
        scaffoldBackgroundColor: const Color(0xFFF6F9FD),
        cardColor: Colors.white,
        useMaterial3: true,
      ),
      home: const RingkasanPage(),
    );
  }
}

// Halaman ringkasan tabungan.
class RingkasanPage extends StatelessWidget {
  const RingkasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar menampilkan judul halaman.
      appBar: AppBar(
        title: const Text(
          'Ringkasan Tabungan',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF557CA8),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ListView membuat halaman bisa digulir pada layar kecil.
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Container membatasi lebar konten agar rapi di tablet.
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kartu informasi saldo dan target tabungan.
                  Card(
                    elevation: 0,
                    color: const Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(
                        color: Color(0xFFE4EBF4),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tabungan Impian',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF24364B),
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Text(
                            'Saldo Saat Ini',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF8292A5),
                            ),
                          ),
                          const SizedBox(height: 7),
                          const Text(
                            'Rp 2.500.000',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                              color: Color(0xFF557CA8),
                            ),
                          ),
                          const SizedBox(height: 22),
                          const Divider(
                            color: Color(0xFFE8EEF5),
                            thickness: 1,
                          ),
                          const SizedBox(height: 7),

                          // Row menempatkan label dan target bersebelahan.
                          const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Target Tabungan',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF8292A5),
                                  ),
                                ),
                              ),
                              Text(
                                'Rp 5.000.000',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF24364B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 26),

                  // Tiga penanda kategori dalam satu baris.
                  Row(
                    children: [
                      Expanded(
                        child: kategori(
                          Icons.savings_outlined,
                          'Menabung',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: kategori(
                          Icons.arrow_upward,
                          'Tarik',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: kategori(
                          Icons.history,
                          'Riwayat',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Judul daftar transaksi.
                  const Text(
                    'Transaksi Terakhir',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24364B),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Daftar transaksi menggunakan data statis.
                  transaksi(
                    'Menabung Mingguan',
                    '10 November 2026',
                    '+ Rp 200.000',
                    const Color(0xFF557CA8),
                  ),
                  transaksi(
                    'Menabung Rutin',
                    '7 November 2026',
                    '+ Rp 150.000',
                    const Color(0xFF557CA8),
                  ),
                  transaksi(
                    'Penarikan Tabungan',
                    '3 November 2026',
                    '- Rp 100.000',
                    const Color(0xFFCA7777),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan ikon dan nama kategori.
  Widget kategori(IconData ikon, String nama) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFDDE9F6),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            ikon,
            size: 27,
            color: const Color(0xFF557CA8),
          ),
          const SizedBox(height: 10),
          Text(
            nama,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF405A78),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan judul, tanggal, dan nominal transaksi.
  Widget transaksi(
      String judul,
      String tanggal,
      String nominal,
      Color warna,
      ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFFE4EBF4),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF24364B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    tanggal,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8292A5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              nominal,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: warna,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
