import 'package:flutter/material.dart';

import 'package:lingua_chat/constants/types.dart';

Widget languageDropdown({
  required Languages? value,
  required ValueChanged<Languages?> onChanged,
}) {
  return Column(
    children: [
      const Text(
        'Select language:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF464559), width: 1),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: Colors.black,
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Languages>(
            value: value,
            hint: const Text(
              'Select language',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF464559),
              ),
            ),
            items: Languages.values
                .map(
                  (lang) => DropdownMenuItem(
                    value: lang,
                    child: Text(
                      lang.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF464559),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    ],
  );
}
