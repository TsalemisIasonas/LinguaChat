import 'package:flutter/material.dart';

Widget progressCard({
  required String title,
  required String xp,
  required String lessons,
  required String rank,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(0xFFE3DFFF)),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          blurRadius: 6,
          offset: Offset(0, 4),
          color: Color.fromARGB(60, 0, 0, 0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Color(0xFF444078),
          ),
        ),
        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            stat("XP", xp),
            stat("Lessons", lessons),
            stat("Rank", rank),
          ],
        ),
      ],
    ),
  );
}

Widget stat(String label, String value) {
  return Column(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 13,
          color: Color(0xFF444078),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Color(0xFF444078),
        ),
      ),
    ],
  );
}
