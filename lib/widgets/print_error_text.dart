import 'package:flutter/material.dart';

/// Print the error message given, if any.
Widget printErrorText(String? text) {
  if (text == null) return const SizedBox.shrink();
  return Text(
    text,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Colors.red,
    ),
  );
}
