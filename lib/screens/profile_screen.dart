import 'package:flutter/material.dart';

import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/app_bar.dart';
import 'package:lingua_chat/widgets/floating_action_button.dart';
import 'package:lingua_chat/widgets/navigation_bar.dart';
import 'package:lingua_chat/screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ProfileScreen());

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.deepOrangeAccent,
    foregroundColor: Colors.white,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 80,
          height: 80,
          child: LinguaFloatingActionButton(),
        ),

        appBar: linguaAppBar(title_: "Profile"),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Settings button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, SettingsScreen.route());
                },
                style: _buttonStyle,
                child: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const LinguaNavigationBar(),
      ),
    );
  }
}
