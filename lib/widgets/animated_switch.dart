import 'package:flutter/material.dart';

import 'package:lingua_chat/services/sound_service.dart';

Widget animatedSwitch({
  required String label,
  required bool value,
  required ValueChanged<bool> onChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Switch(
          key: ValueKey(value),
          value: value,
          onChanged: (newValue) {
            AppSound.switchSound.play();
            onChanged(newValue);
          },
        ),
      ),
    ],
  );
}
