import 'package:flutter/material.dart';
import 'package:lingua_chat/components/banner.dart';
import 'package:lingua_chat/components/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const LinguaBanner(
            title: 'Welcome to Lingua Chat!',
            subtitle: 'Your journey to mastering languages starts here.',
            leadingIcon: Icons.language_rounded,
            actionLabel: 'Get Started',
          )
        ],
        

      ),
      bottomNavigationBar: LinguaBottomNavBar(
        currentIndex: 0,
        onItemSelected: (index) {
          // Handle navigation logic here
        },
      ),
    );
  }
}