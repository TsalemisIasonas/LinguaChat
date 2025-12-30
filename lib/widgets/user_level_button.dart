import 'package:flutter/material.dart';

import 'package:lingua_chat/constants/types.dart';
import 'package:lingua_chat/services/sound_service.dart';

/// This button takes tree parameters.
/// The label it displays.
/// A variable that indicated the selected button of the group.
/// The onTap function.
Widget levelButton({
  required UserLevel label,
  required UserLevel selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: () {
      AppSound.click.play();
      onTap;
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: selected == label
            ? const Color(0xFF464559)
            : const Color(0xFFE4DFF9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: Colors.black,
          ),
        ],
      ),
      child: Text(
        label.name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: selected == label ? Colors.white : const Color(0xFF464559),
        ),
      ),
    ),
  );
}
