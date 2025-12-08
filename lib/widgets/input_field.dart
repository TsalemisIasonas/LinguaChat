import 'package:flutter/material.dart';

/// User Input text fields, with an option for obscured text for passwords
Widget inputField(
  String name_,
  TextEditingController controller_, {
  bool obscureText_ = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // label
      Text(
        name_,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 8),

      // Email input
      TextField(
        obscureText: obscureText_,
        controller: controller_,
        decoration: InputDecoration(
          hintText: name_,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF246BFD), width: 2),
          ),
        ),
      ),
    ],
  );
}
