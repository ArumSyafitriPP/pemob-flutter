import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Kontak {
  final String nama;
  final String nomor;
  final String email;

  const Kontak(
      this.nama,
      this.nomor,
      this.email,
      );
}

// Daftar kontak
const daftarKontak = [
  Kontak(
    'Arum Syafitri',
    '081234567890',
    'arum@gmail.com',
  ),
  Kontak(
    'Jono',
    '082345678901',
    'adelia@gmail.com',
  ),
  Kontak(
    'Fira',
    '083456789012',
    'fira@gmail.com',
  ),
  Kontak(
    'Putri',
    '084567890123',
    'septiara@gmail.com',
  ),
  Kontak(
    'Rizqi',
    '085678901234',
    'rizqi@gmail.com',
  ),
  Kontak(
    'Nadia',
    '086789012345',
    'nadia@gmail.com',
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const KontakPage(),
    );
  }
}

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),

      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              // Avatar berisi huruf pertama nama
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  kontak.nama[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                kontak.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              subtitle: Text(kontak.nomor),

              trailing: const Icon(
                Icons.chevron_right,
              ),

              // Navigasi ke halaman detail
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      kontak: kontak,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Kontak kontak;

  const DetailPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kontak.nama),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar besar
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Text(
                  kontak.nama[0],
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Nama
              Text(
                kontak.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Nomor telepon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    kontak.nomor,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Email
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    kontak.email,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Tombol kembali
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}