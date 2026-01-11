import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle heading1 = GoogleFonts.manrope(
    fontSize: 50,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.2,
    letterSpacing: 3,
  );

  static TextStyle heading2 = GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static TextStyle appBarTextStyle = GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle messageTextStyle = GoogleFonts.manrope(
    color: Colors.white,
  );

  static TextStyle carouselTextStyle = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    shadows: const [
      Shadow(offset: Offset(0, 2), blurRadius: 4, color: Colors.black45),
    ],
  );

  static TextStyle levelButtonTextStyle = GoogleFonts.manrope(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
}
