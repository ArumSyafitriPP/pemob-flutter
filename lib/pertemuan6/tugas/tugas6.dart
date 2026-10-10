import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pilihanWarna = [
  Colors.indigo,
  Colors.teal,
  Colors.deepOrange,
  Colors.pink,
];

const namaWarna = [
  'Indigo',
  'Teal',
  'Deep Orange',
  'Pink',
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    MyApp(
      modeGelap: prefs.getBool('modeGelap') ?? false,
      indeksWarna: prefs.getInt('indeksWarna') ?? 0,
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool modeGelap;
  final int indeksWarna;

  const MyApp({
    super.key,
    required this.modeGelap,
    required this.indeksWarna,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool modeGelap;
  late int indeksWarna;

  @override
  void initState() {
    super.initState();
    modeGelap = widget.modeGelap;
    indeksWarna = widget.indeksWarna;
  }

  Future<void> ubahMode(bool nilai) async {
    setState(() {
      modeGelap = nilai;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modeGelap', nilai);
  }

  Future<void> ubahWarna(int indeks) async {
    setState(() {
      indeksWarna = indeks;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('indeksWarna', indeks);
  }

  @override
  Widget build(BuildContext context) {
    final warna = pilihanWarna[indeksWarna];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Profile',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: warna,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: warna,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: modeGelap ? ThemeMode.dark : ThemeMode.light,

      home: HalamanUtama(
        modeGelap: modeGelap,
        indeksWarna: indeksWarna,
        onUbahMode: ubahMode,
        onUbahWarna: ubahWarna,
      ),

      onGenerateRoute: (settings) {
        if (settings.name == '/detail') {
          final data = settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
            builder: (context) {
              return HalamanDetail(data: data);
            },
          );
        }

        return null;
      },
    );
  }
}

// HALAMAN UTAMA DAN NAVIGATION BAR

class HalamanUtama extends StatefulWidget {
  final bool modeGelap;
  final int indeksWarna;
  final ValueChanged<bool> onUbahMode;
  final ValueChanged<int> onUbahWarna;

  const HalamanUtama({
    super.key,
    required this.modeGelap,
    required this.indeksWarna,
    required this.onUbahMode,
    required this.onUbahWarna,
  });

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int indeksTab = 0;

  void bukaDetail(Map<String, dynamic> data) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    final halaman = [
      BerandaPage(onDetail: bukaDetail),
      TentangPage(onDetail: bukaDetail),
      PengaturanPage(
        modeGelap: widget.modeGelap,
        indeksWarna: widget.indeksWarna,
        onUbahMode: widget.onUbahMode,
        onUbahWarna: widget.onUbahWarna,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),

      body: halaman[indeksTab],

      bottomNavigationBar: NavigationBar(
        selectedIndex: indeksTab,
        onDestinationSelected: (indeks) {
          setState(() {
            indeksTab = indeks;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Tentang Saya',
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

// TAB 1: BERANDA

class BerandaPage extends StatefulWidget {
  final ValueChanged<Map<String, dynamic>> onDetail;

  const BerandaPage({
    super.key,
    required this.onDetail,
  });

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  bool diperbesar = false;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),

        // Animasi implisit menggunakan AnimatedContainer.
        Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: diperbesar ? 160 : 130,
            height: diperbesar ? 160 : 130,
            decoration: BoxDecoration(
              color: warna.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              size: diperbesar ? 100 : 80,
              color: warna.onPrimaryContainer,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Text(
          'Arum Syafitri Puspita Pratiwi',
          textAlign: TextAlign.center,
          style: tema.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'Teknik Informatika',
          textAlign: TextAlign.center,
          style: tema.textTheme.titleMedium?.copyWith(
            color: warna.primary,
          ),
        ),

        const SizedBox(height: 16),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Halo! Selamat datang di profil saya. '
                  'Saya sedang belajar pemrograman dan '
                  'mengembangkan kemampuan di bidang teknologi.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodyLarge,
            ),
          ),
        ),

        const SizedBox(height: 12),

        FilledButton.tonalIcon(
          onPressed: () {
            setState(() {
              diperbesar = !diperbesar;
            });
          },
          icon: const Icon(Icons.animation),
          label: const Text('Ubah Ukuran Profil'),
        ),

        const SizedBox(height: 20),

        Text(
          'Aktivitas',
          style: tema.textTheme.titleLarge,
        ),

        const SizedBox(height: 8),

        const Card(
          child: ListTile(
            leading: Icon(Icons.school),
            title: Text('Belajar'),
            subtitle: Text('Mempelajari hal baru setiap hari'),
          ),
        ),

        const Card(
          child: ListTile(
            leading: Icon(Icons.code),
            title: Text('Pemrograman'),
            subtitle: Text('Membuat aplikasi menggunakan Flutter'),
          ),
        ),

        const SizedBox(height: 12),

        const Center(
          child: IkonBergerak(),
        ),

        const SizedBox(height: 8),

        Text(
          'Terus belajar, terus berkembang!',
          textAlign: TextAlign.center,
          style: tema.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

// ANIMASI EKSPLISIT MENGGUNAKAN AnimationController

class IkonBergerak extends StatefulWidget {
  const IkonBergerak({super.key});

  @override
  State<IkonBergerak> createState() => _IkonBergerakState();
}

class _IkonBergerakState extends State<IkonBergerak>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> gerakan;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    gerakan = Tween<double>(
      begin: -15,
      end: 15,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: gerakan,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(gerakan.value, 0),
          child: Icon(
            Icons.waving_hand,
            size: 36,
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }
}

// TAB 2: TENTANG SAYA

class TentangPage extends StatelessWidget {
  final ValueChanged<Map<String, dynamic>> onDetail;

  const TentangPage({
    super.key,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    final daftar = [
      {
        'judul': 'Pendidikan',
        'deskripsi':
        'Saya menempuh pendidikan S1 Teknik Informatika.',
        'icon': Icons.school,
        'tag': 'pendidikan',
      },
      {
        'judul': 'Keahlian',
        'deskripsi':
        'Saya sedang mempelajari pemrograman, Flutter, dan pengembangan aplikasi.',
        'icon': Icons.code,
        'tag': 'keahlian',
      },
      {
        'judul': 'Hobi',
        'deskripsi':
        'Saya senang belajar hal baru dan mencoba kegiatan yang bermanfaat.',
        'icon': Icons.favorite,
        'tag': 'hobi',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Tentang Saya',
          style: tema.textTheme.headlineSmall,
        ),

        const SizedBox(height: 8),

        Text(
          'Pilih salah satu kartu untuk melihat detail.',
          style: tema.textTheme.bodyMedium,
        ),

        const SizedBox(height: 12),

        ...daftar.map((data) {
          return Card(
            child: ListTile(
              leading: Hero(
                tag: data['tag'] as String,
                child: Icon(
                  data['icon'] as IconData,
                  size: 36,
                  color: tema.colorScheme.primary,
                ),
              ),
              title: Text(data['judul'] as String),
              subtitle: const Text(
                'Ketuk untuk melihat detail',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => onDetail(data),
            ),
          );
        }),
      ],
    );
  }
}

// HALAMAN DETAIL: NAMED ROUTE, ARGUMEN, DAN HERO

class HalamanDetail extends StatelessWidget {
  final Map<String, dynamic> data;

  const HalamanDetail({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final warna = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['judul'] as String),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: data['tag'] as String,
                child: Icon(
                  data['icon'] as IconData,
                  size: 100,
                  color: warna.primary,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                data['judul'] as String,
                style: tema.textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    data['deskripsi'] as String,
                    style: tema.textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TAB 3: PENGATURAN

class PengaturanPage extends StatelessWidget {
  final bool modeGelap;
  final int indeksWarna;
  final ValueChanged<bool> onUbahMode;
  final ValueChanged<int> onUbahWarna;

  const PengaturanPage({
    super.key,
    required this.modeGelap,
    required this.indeksWarna,
    required this.onUbahMode,
    required this.onUbahWarna,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Pengaturan Tampilan',
          style: tema.textTheme.headlineSmall,
        ),

        const SizedBox(height: 12),

        Card(
          child: SwitchListTile(
            title: const Text('Mode Gelap'),
            subtitle: const Text(
              'Aktifkan atau matikan tema gelap',
            ),
            secondary: const Icon(Icons.dark_mode),
            value: modeGelap,
            onChanged: onUbahMode,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          'Pilih Warna Tema',
          style: tema.textTheme.titleLarge,
        ),

        const SizedBox(height: 12),

        ...List.generate(pilihanWarna.length, (indeks) {
          return Card(
            child: RadioListTile<int>(
              value: indeks,
              groupValue: indeksWarna,
              onChanged: (nilai) {
                if (nilai != null) {
                  onUbahWarna(nilai);
                }
              },
              title: Text(namaWarna[indeks]),
              secondary: CircleAvatar(
                backgroundColor: pilihanWarna[indeks],
                radius: 14,
              ),
            ),
          );
        }),

        const SizedBox(height: 12),

        Text(
          'Pengaturan tema disimpan otomatis.',
          style: tema.textTheme.bodyMedium,
        ),
      ],
    );
  }
}