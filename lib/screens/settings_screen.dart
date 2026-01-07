import 'package:flutter/material.dart';

import 'package:lingua_chat/constants/types.dart';
import 'package:lingua_chat/services/sound_service.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/repositories/user_repository.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/widgets/app_bar.dart';
import 'package:lingua_chat/widgets/language_dropdown.dart';
import 'package:lingua_chat/widgets/user_level_button.dart';
import 'package:lingua_chat/widgets/logout_button.dart';
import 'package:lingua_chat/widgets/animated_switch.dart';

class SettingsScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => const SettingsScreen());

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Language? _selectedLanguage = currentUser.language;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.transparent,

        appBar: linguaAppBar(title_: "Settings", context: context),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/app_logo.png'),
              const SizedBox(height: 20),

              languageDropdown(
                value: _selectedLanguage,
                onChanged: (valueChosen) {
                  setState(() {
                    _selectedLanguage = valueChosen;

                    if (valueChosen == null) {
                      return;
                    }

                    currentUser.language = valueChosen;
                    UserRepository().addOrUpdateUser(currentUser);
                  });
                },
              ),
              const SizedBox(height: 30),

              levelButton(
                label: UserLevel.beginner,
                selected: currentUser.level,
                onTap: () {
                  setState(() {
                    currentUser.level = UserLevel.beginner;
                    UserRepository().addOrUpdateUser(currentUser);
                  });
                },
              ),
              const SizedBox(height: 12),

              levelButton(
                label: UserLevel.intermediate,
                selected: currentUser.level,
                onTap: () {
                  setState(() {
                    currentUser.level = UserLevel.intermediate;
                    UserRepository().addOrUpdateUser(currentUser);
                  });
                },
              ),
              const SizedBox(height: 12),

              levelButton(
                label: UserLevel.advanced,
                selected: currentUser.level,
                onTap: () {
                  setState(() {
                    currentUser.level = UserLevel.advanced;
                    UserRepository().addOrUpdateUser(currentUser);
                  });
                },
              ),
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    animatedSwitch(
                      label: 'Sound effects',
                      value: SoundService().isEnabled,
                      onChanged: (value) {
                        setState(() {
                          SoundService().setEnabled(value);
                        });
                      },
                    ),
                    animatedSwitch(
                      label: 'Dark theme',
                      value: true,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              logoutButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
