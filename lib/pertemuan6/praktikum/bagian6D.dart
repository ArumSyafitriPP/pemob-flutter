import 'package:flutter/material.dart';

// ======================================================
// BAGIAN A: TEMA
// ======================================================

final themeMode = ValueNotifier<ThemeMode>(ThemeMode.light);
final seedColor = ValueNotifier<Color>(Colors.indigo);

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

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

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([themeMode, seedColor]),
      builder: (context, child) {
        return MaterialApp(
          title: 'Praktikum Flutter',
          debugShowCheckedModeBanner: false,

          theme: buatTema(seedColor.value, Brightness.light),
          darkTheme: buatTema(seedColor.value, Brightness.dark),
          themeMode: themeMode.value,

          initialRoute: '/',
          routes: {
            '/': (_) => const ShellPage(),
          },

          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final item = settings.arguments as Item;

              return MaterialPageRoute(
                builder: (_) => DetailPage(item: item),
                settings: settings,
              );
            }

            return null;
          },
        );
      },
    );
  }
}

// ======================================================
// BAGIAN B: MODEL ITEM
// ======================================================

class Item {
  final String nama;
  final IconData ikon;
  final Color warna;

  const Item(this.nama, this.ikon, this.warna);
}

const daftarItem = [
  Item('Flutter', Icons.flutter_dash, Colors.blue),
  Item('Musik', Icons.music_note, Colors.pink),
  Item('Kamera', Icons.camera_alt, Colors.orange),
  Item('Peta', Icons.map, Colors.green),
];

// ======================================================
// BAGIAN B: BERANDA
// ======================================================

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) {
        final item = daftarItem[index];

        return ListTile(
          leading: Hero(
            tag: 'ikon-${item.nama}',
            child: CircleAvatar(
              backgroundColor: item.warna,
              child: Icon(
                item.ikon,
                color: Colors.white,
              ),
            ),
          ),
          title: Text(item.nama),
          subtitle: const Text('Ketuk untuk melihat detail'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(
              context,
              '/detail',
              arguments: item,
            );
          },
        );
      },
    );
  }
}

// ======================================================
// BAGIAN B: HALAMAN DETAIL
// ======================================================

class DetailPage extends StatelessWidget {
  final Item item;

  const DetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.nama),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'ikon-${item.nama}',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: item.warna,
                child: Icon(
                  item.ikon,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.nama,
              style: tema.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Ini adalah halaman detail ${item.nama}.',
              style: tema.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// BAGIAN C: ANIMASI
// ======================================================

class AnimasiTab extends StatefulWidget {
  const AnimasiTab({super.key});

  @override
  State<AnimasiTab> createState() => _AnimasiTabState();
}

class _AnimasiTabState extends State<AnimasiTab>
    with SingleTickerProviderStateMixin {
  bool _besar = false;
  int _hitung = 0;

  late final AnimationController _putar;

  @override
  void initState() {
    super.initState();

    _putar = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
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
        // 1. AnimatedContainer

        Text(
          '1. AnimatedContainer',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),

        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: _besar ? 220 : 120,
            height: _besar ? 220 : 120,
            decoration: BoxDecoration(
              color: _besar
                  ? tema.colorScheme.primary
                  : tema.colorScheme.secondary,
              borderRadius: BorderRadius.circular(
                _besar ? 40 : 12,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.flutter_dash,
                size: _besar ? 90 : 60,
                color: tema.colorScheme.onPrimary,
              ),
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
          child: const Text('Ubah Ukuran'),
        ),

        const SizedBox(height: 32),

        // 2. AnimatedSwitcher

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
              key: ValueKey(_hitung),
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
          child: const Text('Tambah'),
        ),

        const SizedBox(height: 32),

        // 3. AnimationController

        Text(
          '3. RotationTransition',
          style: tema.textTheme.titleLarge,
        ),
        const SizedBox(height: 24),

        Center(
          child: RotationTransition(
            turns: _putar,
            child: Icon(
              Icons.settings,
              size: 100,
              color: tema.colorScheme.primary,
            ),
          ),
        ),

        const SizedBox(height: 24),

        FilledButton(
          onPressed: () {
            if (_putar.isAnimating) {
              _putar.stop();
            } else {
              _putar.repeat();
            }

            setState(() {});
          },
          child: Text(
            _putar.isAnimating ? 'Berhenti' : 'Putar Lagi',
          ),
        ),
      ],
    );
  }
}

// ======================================================
// BAGIAN D: SHELL PAGE
// ======================================================

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int _index = 0;

  static const _halaman = [
    BerandaTab(),
    AnimasiTab(),
    PengaturanTab(),
  ];

  static const _judul = [
    'Beranda',
    'Animasi',
    'Pengaturan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_judul[_index]),
      ),

      body: IndexedStack(
        index: _index,
        children: _halaman,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) {
          setState(() {
            _index = i;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.animation),
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

// ======================================================
// BAGIAN D: PENGATURAN
// ======================================================

class PengaturanTab extends StatelessWidget {
  const PengaturanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Pengaturan Tampilan',
          style: tema.textTheme.titleLarge,
        ),

        const SizedBox(height: 16),

        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Mode Gelap'),
          subtitle: const Text(
            'Aktifkan atau matikan tema gelap',
          ),
          value: themeMode.value == ThemeMode.dark,
          onChanged: (aktif) {
            themeMode.value = aktif
                ? ThemeMode.dark
                : ThemeMode.light;
          },
        ),

        const Divider(height: 32),

        Text(
          'Warna Tema',
          style: tema.textTheme.titleMedium,
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: pilihanWarna.map((warna) {
            final terpilih = seedColor.value == warna;

            return InkWell(
              onTap: () {
                seedColor.value = warna;
              },
              borderRadius: BorderRadius.circular(30),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: warna,
                child: terpilih
                    ? const Icon(
                  Icons.check,
                  color: Colors.white,
                )
                    : null,
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        Text(
          'Pilih salah satu warna untuk mengubah '
              'tampilan seluruh aplikasi.',
          style: tema.textTheme.bodyMedium,
        ),
      ],
    );
  }
}