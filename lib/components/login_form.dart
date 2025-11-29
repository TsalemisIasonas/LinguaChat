import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar area (e.g. back, title, avatar)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const Text(
                    'Lingua Chat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F1828),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFFE5E7EB),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Main content area – replace with exact Figma layout
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // TODO: add exact widgets (text, cards, list items, etc.)
                      Text(
                        'Screen from Figma node 212-33096',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F1828),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Replace this placeholder content with the components you see in the Figma frame (titles, descriptions, chat items, inputs, etc.).',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF707991),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom area (e.g. button or input bar)
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF246BFD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // TODO: hook to next screen/interaction from Figma
                  },
                  child: const Text(
                    'Primary action',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}