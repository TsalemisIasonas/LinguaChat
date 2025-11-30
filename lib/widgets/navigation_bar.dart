import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/leaderboard_screen.dart';
import 'package:lingua_chat/screens/profile_screen.dart';
import 'package:lingua_chat/styles/colors.dart';

class LinguaNavigationBar extends StatefulWidget {
  const LinguaNavigationBar({super.key});

  @override
  State<LinguaNavigationBar> createState() => _LinguaNavigationBarState();
}

class _LinguaNavigationBarState extends State<LinguaNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BottomAppBar(
        padding: const EdgeInsets.only(left: 40, right: 40),
        height: 100,
        shape: const CircularNotchedRectangle(),
        color: navbarColor,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: Icon(Icons.account_circle_outlined, size: 45, color: Colors.black),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                );
              },
              icon: Icon(Icons.list, size: 45, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
