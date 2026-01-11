import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/leaderboard_screen.dart';
import 'package:lingua_chat/screens/profile_screen.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/services/sound_service.dart';

class LinguaNavigationBar extends StatefulWidget {
  final String currentScreen;
  
  const LinguaNavigationBar({super.key, required this.currentScreen});

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
        padding: EdgeInsets.only(
          left: 40,
          right: 40,
        ),
        height: 85,
        shape: const CircularNotchedRectangle(),
        color: navbarColor,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                AppSound.click.play();
                if (widget.currentScreen != 'profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                }
              },
              icon: Icon(
                Icons.account_circle_outlined,
                size: 45,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                AppSound.click.play();
                if (widget.currentScreen != 'leaderboard') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                  );
                }
              },
              icon: Icon(Icons.list, size: 45, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
