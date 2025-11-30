import 'package:flutter/material.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/floating_action_button.dart';
import 'package:lingua_chat/widgets/navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: LinguaFloatingActionButton(),
      ),

      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              gradientColorStart,
              gradientColorEnd,
            ],
            stops: [0.1, 0.3],
          ),
        ),
      ),

      bottomNavigationBar: const LinguaNavigationBar(),
    );
  }
}