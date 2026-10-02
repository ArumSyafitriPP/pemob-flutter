import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 1',
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counter Saya',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.flutter_dash,
              size: 80,
              color: Colors.pink,
            ),

            const SizedBox(height: 16),

            const Text(
              'Halo, nama saya Arum Syafitri P.P!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),

            const Text(
              'NIM: 20240801010',
            ),

            const SizedBox(height: 24),

            const Text(
              'Nilai Counter:',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 8),

            Text(
              '$_count',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tombol kurang
          FloatingActionButton(
            onPressed: () {
              if (_count > 0) {
                setState(() {
                  _count--;
                });
              }
            },
            child: const Icon(Icons.remove),
          ),

          const SizedBox(width: 12),

          // Tombol reset
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _count = 0;
              });
            },
            child: const Icon(Icons.refresh),
          ),

          const SizedBox(width: 12),

          // Tombol tambah
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}