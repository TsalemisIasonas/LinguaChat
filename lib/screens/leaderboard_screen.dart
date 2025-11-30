import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/floating_action_button.dart';
import 'package:lingua_chat/widgets/navigation_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Top Learners in your region'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
        ],
      ),

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