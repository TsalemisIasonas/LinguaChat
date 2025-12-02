import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFFF5F5F5);
const Color navbarColor = Color(0xFF5C5891);

const Color gradientColorStart = Color(0xFF7686EB);
const Color gradientColorEnd = Color(0xFFA060BB);

const BoxDecoration backgroundGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [gradientColorStart, gradientColorEnd],
    stops: [0, 0.9],
  ),
);
