import 'package:flutter/material.dart';

// Define your app's standard text styles here
class AppTextStyles {
  static const String fontFamily = 'Montserrat';

  static const TextStyle heading1 = TextStyle(
    fontSize: 50,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.2,
    letterSpacing: 3,
  );

  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle messageTextStyle = TextStyle(color: Colors.white);

  static const TextStyle carouselTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    shadows: [
      Shadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.black45),
    ],
  );

  static const TextStyle levelButtonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
