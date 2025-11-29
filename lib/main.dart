import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';

void main() {
  runApp(const LinguaChatApp());
}

class LinguaChatApp extends StatelessWidget {
  const LinguaChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lingua Chat',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF246BFD),
          secondary: Color(0xFF00C48C),
          background: Color(0xFFF5F7FB),
          surface: Colors.white,
          onPrimary: Colors.white,
          onBackground: Color(0xFF0F1828),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        fontFamily: 'SF Pro Display',
      ),
      home: const HomeScreen(),
    );
  }
}