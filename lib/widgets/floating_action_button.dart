import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';

class LinguaFloatingActionButton extends StatelessWidget {
  const LinguaFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.home, color: Colors.black, size: 35),
      );
  }
}