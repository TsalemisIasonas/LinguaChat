import 'package:flutter/material.dart';
import 'package:lingua_chat/constants/types.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/repositories/user_repository.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/banner.dart';
import 'package:lingua_chat/widgets/language_dropdown.dart';
import 'package:lingua_chat/widgets/user_level_button.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Language? _selectedLanguage = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SingleChildScrollView(
        child: Stack(
          children: [
            const LinguaBanner(),
            Padding(
              padding: const EdgeInsets.only(top: 270.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
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

                      const SizedBox(height: 22),

                      Image(
                        image: const AssetImage('assets/images/app_logo.png'),
                        height: 100,
                      ),

                      const SizedBox(height: 22),

                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE4DFF9),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const SizedBox.shrink(),
                        label: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'NEXT',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
