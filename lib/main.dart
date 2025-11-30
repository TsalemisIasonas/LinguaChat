import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lingua_chat/firebase_options.dart';

import 'package:lingua_chat/screens/log_in_screen.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      home: const LoginScreen(),
    );
  }
}
