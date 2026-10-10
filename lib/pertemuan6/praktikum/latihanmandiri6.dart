import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ==========================================
// 1. PENGATURAN TEMA GLOBAL
// ==========================================

final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
final seedColor = ValueNotifier<Color>(Colors.indigo);

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

// Membuat tema terang dan gelap
ThemeData buatTema(Color seed, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: brightness,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
    ),
  );
}

// ==========================================
// 2. MAIN DAN PENYIMPANAN PREFERENSI
// ==========================================

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Membaca pengaturan yang tersimpan
  final prefs = await SharedPreferences.getInstance();

  final modeGelap = prefs.getBool('modeGelap') ?? false;
  final indeksWarna = prefs.getInt('indeksWarna') ?? 0;

  // Memastikan indeks warna tetap valid
  final indeksAman = indeksWarna >= 0 &&
      indeksWarna < pilihanWarna.length
      ? indeksWarna
      : 0;

  themeMode.value =
  modeGelap ? ThemeMode.dark : ThemeMode.light;

  seedColor.value = pilihanWarna[indeksAman];

  runApp(const MyApp());
}

// ==========================================
// 3. APLIKASI UTAMA DAN ROUTING
// ==========================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        themeMode,
        seedColor,
      ]),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Praktikum Flutter',

          theme: buatTema(
            seedColor.value,
            Brightness.light,
          ),

          darkTheme: buatTema(
            seedColor.value,
            Brightness.dark,
          ),

          themeMode: themeMode.value,

          initialRoute: '/',

          // Halaman utama
          routes: {
            '/': (context) => const ShellPage(),
          },

          // Halaman detail menggunakan FadeTransition
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final item = settings.arguments as Item;

              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    ) {
                  return DetailPage(item: item);
                },
                transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                    ) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration:
                const Duration(milliseconds: 500),
              );
            }

            return null;
          },

          // Halaman untuk rute yang tidak dikenal
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const NotFoundPage(),
            );
          },
        );
      },
    );
  }
}

// ==========================================
// 4. MODEL DATA ITEM
// ==========================================

class Item {
  final String judul;
  final String deskripsi;
  final IconData ikon;
  final Color warna;

  const Item({
    required this.judul,
    required this.deskripsi,
    required this.ikon,
    required this.warna,
  });
}

final List<Item> daftarItem = [
  Item(
    judul: 'Flutter',
    deskripsi: 'Belajar membuat aplikasi dengan Flutter.',
    ikon: Icons.flutter_dash,
    warna: Colors.blue,
  ),
  Item(
    judul: 'Musik',
    deskripsi: 'Musik untuk menemani aktivitas sehari-hari.',
    ikon: Icons.music_note,
    warna: Colors.purple,
  ),
  Item(
    judul: 'Kamera',
    deskripsi: 'Mengabadikan momen melalui foto.',
    ikon: Icons.camera_alt,
    warna: Colors.orange,
  ),
  Item(
    judul: 'Peta',
    deskripsi: 'Membantu menemukan lokasi tujuan.',
    ikon: Icons.map,
    warna: Colors.green,
  ),
];

// ==========================================
// 5. HALAMAN SHELL DAN DRAWER
// ==========================================

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  final List<Widget> _halaman = const [
    BerandaTab(),
    AnimasiTab(),
    PengaturanTab(),
  ];

  final List<String> _judul = const [
    'Beranda',
    'Animasi',
    'Pengaturan',
  ];

  // Mengganti tab dari Drawer
  void _pilihHalaman(int index) {
    setState(() {
      _index = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_index]),
      ),

      // Drawer untuk berpindah halaman
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Menu Praktikum Flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              selected: _index == 0,
              onTap: () => _pilihHalaman(0),
            ),

            ListTile(
              leading: const Icon(Icons.animation),
              title: const Text('Animasi'),
              selected: _index == 1,
              onTap: () => _pilihHalaman(1),
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              selected: _index == 2,
              onTap: () => _pilihHalaman(2),
            ),
          ],
        ),
      ),

      // Menampilkan halaman sesuai tab yang dipilih
      body: IndexedStack(
        index: _index,
        children: _halaman,
      ),

      // Navigasi bawah
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) {
          setState(() {
            _index = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.animation_outlined),
            selectedIcon: Icon(Icons.animation),
            label: 'Animasi',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. TAB BERANDA
// ==========================================

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Selamat Datang!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        const Text(
          'Pilih salah satu item untuk melihat halaman detail.',
        ),
        const SizedBox(height: 16),

        ...daftarItem.map((item) {
          return Card(
            child: ListTile(
              leading: Hero(
                tag: item.judul,
                child: CircleAvatar(
                  backgroundColor: item.warna,
                  child: Icon(
                    item.ikon,
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(item.judul),
              subtitle: Text(item.deskripsi),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: item,
                );
              },
            ),
          );
        }),
      ],
    );
  }
}

// ==========================================
// 7. HALAMAN DETAIL
// ==========================================

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.judul),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: item.judul,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: item.warna,
                  child: Icon(
                    item.ikon,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                item.judul,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                item.deskripsi,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 8. TAB ANIMASI
// ==========================================

class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;
  bool _tampil = true;
  int _hitung = 0;

  late AnimationController _putar;

  @override
  void initState() {
    super.initState();

    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _putar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Animasi 1: AnimatedContainer
        Text(
          '1. AnimatedContainer',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _besar ? 200 : 100,
            height: _besar ? 100 : 200,
            decoration: BoxDecoration(
              color: _besar ? Colors.teal : Colors.indigo,
              borderRadius: BorderRadius.circular(
                _besar ? 24 : 8,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.star,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),

        const SizedBox(height: 12),

        FilledButton(
          onPressed: () {
            setState(() {
              _besar = !_besar;
            });
          },
          child: const Text('Ubah Bentuk'),
        ),

        const Divider(height: 40),

        // Animasi 2: AnimatedSwitcher
        Text(
          '2. AnimatedSwitcher',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: Text(
              '$_hitung',
              key: ValueKey<int>(_hitung),
              style: tema.textTheme.displayLarge,
            ),
          ),
        ),

        const SizedBox(height: 12),

        FilledButton(
          onPressed: () {
            setState(() {
              _hitung++;
            });
          },
          child: const Text('Tambah Angka'),
        ),

        const Divider(height: 40),

        // Animasi 3: RotationTransition
        Text(
          '3. RotationTransition',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        Center(
          child: RotationTransition(
            turns: _putar,
            child: const Icon(
              Icons.refresh,
              size: 100,
              color: Colors.deepOrange,
            ),
          ),
        ),

        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                if (_putar.isAnimating) {
                  _putar.stop();
                } else {
                  _putar.repeat();
                }
                setState(() {});
              },
              child: const Text('Putar / Berhenti'),
            ),
          ],
        ),

        const Divider(height: 40),

        // Animasi 4: AnimatedOpacity
        Text(
          '4. AnimatedOpacity',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        Center(
          child: AnimatedOpacity(
            opacity: _tampil ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Card(
              child: SizedBox(
                width: 220,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.pink,
                    ),
                    SizedBox(height: 8),
                    Text('Kartu Animasi'),
                  ],
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        FilledButton(
          onPressed: () {
            setState(() {
              _tampil = !_tampil;
            });
          },
          child: Text(
            _tampil
                ? 'Sembunyikan Kartu'
                : 'Tampilkan Kartu',
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}

// ==========================================
// 9. TAB PENGATURAN
// ==========================================

class PengaturanTab extends StatelessWidget {
  const PengaturanTab({super.key});

  // Menyimpan mode terang atau gelap
  Future<void> simpanModeGelap(bool aktif) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('modeGelap', aktif);

    themeMode.value =
    aktif ? ThemeMode.dark : ThemeMode.light;
  }

  // Menyimpan warna tema
  Future<void> simpanWarna(Color warna) async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < pilihanWarna.length; i++) {
      if (pilihanWarna[i] == warna) {
        await prefs.setInt('indeksWarna', i);
        seedColor.value = warna;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Pengaturan Tampilan',
          style: Theme.of(context).textTheme.headlineSmall,
        ),

        const SizedBox(height: 16),

        // Pilihan mode terang atau gelap
        ValueListenableBuilder<ThemeMode>(
          valueListenable: themeMode,
          builder: (context, mode, child) {
            return SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Mode Gelap'),
              subtitle: const Text(
                'Aktifkan tampilan gelap',
              ),
              value: mode == ThemeMode.dark,
              onChanged: simpanModeGelap,
            );
          },
        ),

        const Divider(),

        // Pilihan warna tema
        ListTile(
          leading: const Icon(Icons.palette),
          title: const Text('Warna Tema'),
          subtitle: const Text(
            'Pilih warna aplikasi',
          ),
        ),

        ValueListenableBuilder<Color>(
          valueListenable: seedColor,
          builder: (context, warnaTerpilih, child) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 12,
              children: pilihanWarna.map((warna) {
                final terpilih = warna == warnaTerpilih;

                return InkWell(
                  onTap: () {
                    simpanWarna(warna);
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: warna,
                      shape: BoxShape.circle,
                      border: terpilih
                          ? Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        width: 3,
                      )
                          : null,
                    ),
                    child: terpilih
                        ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                        : null,
                  ),
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 24),

        const Divider(),

        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Tentang Aplikasi'),
          subtitle: Text(
            'Praktikum Flutter Pertemuan 6',
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 10. HALAMAN 404
// ==========================================

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Halaman Tidak Ditemukan',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 90,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                '404',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'Halaman yang kamu cari tidak ditemukan.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}