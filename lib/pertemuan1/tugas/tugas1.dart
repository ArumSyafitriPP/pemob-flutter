import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text(
            'Kartu Perkenalan',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle,
                size: 110,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 15),

              const Text(
                'Arum Syafitri P.P',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 20),

              const Icon(
                Icons.badge_outlined,
                size: 25,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 5),

              const Text(
                'NIM: 20240801010',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              const Icon(
                Icons.school_outlined,
                size: 25,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 5),

              const Text(
                'Teknik Informatika',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              const Icon(
                Icons.movie_outlined,
                size: 25,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 5),

              const Text(
                'Hobi: Menonton Film',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}