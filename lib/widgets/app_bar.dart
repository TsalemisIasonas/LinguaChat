import 'package:flutter/material.dart';

import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/services/sound_service.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/styles/text_styles.dart';

AppBar linguaAppBar({required String title_, required BuildContext context}) {
  final iconShadows = [
    Shadow(
      color: Colors.black.withValues(alpha: 0.3),
      offset: const Offset(2, 2),
      blurRadius: 6,
    ),
  ];

  return AppBar(
    backgroundColor: gradientColorStart,
    centerTitle: true,
    title: Text(
      title_,
      style: AppTextStyles.appBarTextStyle,
      textAlign: TextAlign.center,
    ),
    leading: IconButton(
      icon: Icon(Icons.arrow_back, shadows: iconShadows),
      onPressed: () {
        AppSound.click.play();
        if (context.mounted) Navigator.of(context).pop();
      },
    ),
    elevation: 4,
    actions: [
      IconButton(
        icon: Icon(Icons.home, size: 30, shadows: iconShadows),
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
