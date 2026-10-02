import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Belanja {
  String nama;
  int jumlah;
  String kategori;
  bool sudahDibeli;

  Belanja(
      this.nama,
      this.jumlah,
      this.kategori, {
        this.sudahDibeli = false,
      });
}

class BelanjaModel extends ChangeNotifier {
  final List<Belanja> _items = [];

  List<Belanja> get items => List.unmodifiable(_items);

  int get jumlahBelumDibeli =>
      _items.where((item) => !item.sudahDibeli).length;

  void tambah(
      String nama,
      int jumlah,
      String kategori,
      ) {
    _items.add(
      Belanja(
        nama,
        jumlah,
        kategori,
      ),
    );

    notifyListeners();
  }

  void toggle(int index) {
    _items[index].sudahDibeli =
    !_items[index].sudahDibeli;

    notifyListeners();
  }

  void hapus(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Belanja',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const DaftarBelanjaPage(),
    );
  }
}

class DaftarBelanjaPage extends StatelessWidget {
  const DaftarBelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Belanja (${model.jumlahBelumDibeli} belum dibeli)',
        ),
      ),
      body: model.items.isEmpty
          ? const Center(
        child: Text(
          'Belum ada barang',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, i) {
          final item = model.items[i];

          return ListTile(
            leading: Checkbox(
              value: item.sudahDibeli,
              onChanged: (_) {
                context
                    .read<BelanjaModel>()
                    .toggle(i);
              },
            ),
            title: Text(
              item.nama,
              style: TextStyle(
                decoration: item.sudahDibeli
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Text(
              '${item.jumlah} • ${item.kategori}',
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context
                    .read<BelanjaModel>()
                    .hapus(i);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahBelanjaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahBelanjaPage extends StatefulWidget {
  const TambahBelanjaPage({super.key});

  @override
  State<TambahBelanjaPage> createState() =>
      _TambahBelanjaPageState();
}

class _TambahBelanjaPageState
    extends State<TambahBelanjaPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();

  String? _kategori;

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _tambahBarang() {
    if (!_formKey.currentState!.validate()) return;

    final nama = _namaController.text.trim();
    final jumlah = int.parse(_jumlahController.text);
    final kategori = _kategori!;

    context.read<BelanjaModel>().tambah(
      nama,
      jumlah,
      kategori,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Belanja'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama barang',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Nama barang wajib diisi';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Jumlah wajib diisi';
                }

                final jumlah = int.tryParse(value);

                if (jumlah == null || jumlah <= 0) {
                  return 'Jumlah harus lebih dari 0';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Makanan',
                  child: Text('Makanan'),
                ),
                DropdownMenuItem(
                  value: 'Minuman',
                  child: Text('Minuman'),
                ),
                DropdownMenuItem(
                  value: 'Kebutuhan Rumah',
                  child: Text('Kebutuhan Rumah'),
                ),
                DropdownMenuItem(
                  value: 'Lainnya',
                  child: Text('Lainnya'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _kategori = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Kategori wajib dipilih';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _tambahBarang,
              child: const Text('Tambah'),
            ),
          ],
        ),
      ),
    );
  }
}