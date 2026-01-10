import 'package:flutter/material.dart';

import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/services/sound_service.dart';

class LinguaFloatingActionButton extends StatelessWidget {
  final String currentScreen;
  
  const LinguaFloatingActionButton({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        AppSound.click.play();
        
        if (currentScreen != 'home') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
      },
      backgroundColor: Colors.white,
      child: const Icon(Icons.home, color: Colors.black, size: 35),
    );
  }
}
