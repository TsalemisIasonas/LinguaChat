import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';

import 'screens/home.dart';

void main() {
  runApp(const LinguaChatApp());
}

class LinguaChatApp extends StatelessWidget {
  const LinguaChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lingua Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}