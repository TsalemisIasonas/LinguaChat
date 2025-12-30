import 'package:flutter/material.dart';

import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/banner.dart';
import 'package:lingua_chat/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => const RegisterScreen());
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: Stack(
        children: [
          const LinguaBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: const RegisterForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
