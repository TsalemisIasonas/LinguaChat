import 'package:flutter/material.dart';

import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/repositories/user_repository.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/app_bar.dart';
import 'package:lingua_chat/widgets/profile_banner.dart';
import 'package:lingua_chat/widgets/progress_card.dart';
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
    backgroundColor: Colors.deepPurple,
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

        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 60),

                  ProfileBanner(
                    username: currentUser.username,
                    userLevel: currentUser.level.name,
                    avatarPath: currentUser.profilePicturePath,
                    onNameChanged: (newName) {
                      setState(() {});
                      currentUser.username = newName;
                      UserRepository().addOrUpdateUser(currentUser);
                    },
                    onAvatarChanged: (newAvatar) {
                      setState(() {
                        currentUser.profilePicturePath = newAvatar;
                        UserRepository().addOrUpdateUser(currentUser);
                      });
                    },
                  ),

                  const SizedBox(height: 40),

                  progressCard(
                    title: "Progress",
                    xp: "12850",
                    lessons: "48",
                    rank: "#1",
                  ),

                  const SizedBox(height: 24),

                  progressCard(
                    title: "More Stats",
                    xp: "12850",
                    lessons: "48",
                    rank: "#1",
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, SettingsScreen.route());
                },
                style: _buttonStyle,
                icon: const Icon(Icons.settings, size: 22),
                label: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),

        bottomNavigationBar: const LinguaNavigationBar(),
      ),
    );
  }
}
