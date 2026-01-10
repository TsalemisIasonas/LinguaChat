import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/services/sound_service.dart';
import 'package:lingua_chat/styles/text_styles.dart';

AppBar linguaAppBar({required String title_, required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title_,
      style: AppTextStyles.appBarTextStyle,
      textAlign: TextAlign.center,
    ),
    elevation: 4,
    actions: [
      IconButton(
        icon: Icon(Icons.home, size: 30,),
        onPressed: () {
          AppSound.click.play();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        },
      ),
    ],
  );
}
