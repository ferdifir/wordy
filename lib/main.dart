import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Word Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RandomWordScreen(),
    );
  }
}

class RandomWordScreen extends StatefulWidget {
  const RandomWordScreen({super.key});

  @override
  _RandomWordScreenState createState() => _RandomWordScreenState();
}

class _RandomWordScreenState extends State<RandomWordScreen> {
  String randomWord = '';

  String generateRandomWord() {
    String characters = 'abcdefghijklmnopqrstuvwxyz=-+*#[]{}/\\!@%^&*()_+<>?~';
    Random random = Random();

    String word = '';
    for (int i = 0; i < 20; i++) {
      int randomIndex = random.nextInt(characters.length);
      word += characters[randomIndex];
    }

    return word;
  }

  void generateWord() {
    setState(() {
      randomWord = generateRandomWord();
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: randomWord));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Teks disalin ke clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Word Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              randomWord,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateWord,
              child: const Text('Generate'),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: copyToClipboard,
              child: const Text(
                'Salin Teks',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
