import 'package:flutter/material.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/banner.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Stack(
        children: [
          const LinguaBanner(),
        ],
      ),
      
    );
  }
}