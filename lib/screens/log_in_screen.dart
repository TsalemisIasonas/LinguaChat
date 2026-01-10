import 'package:flutter/material.dart';

import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/banner.dart';
import 'package:lingua_chat/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (context) => const LoginScreen());

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SingleChildScrollView(
        child: Stack(
          children: [
            const LinguaBanner(),
            Padding(
              padding: const EdgeInsets.only(top: 260.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: const LoginForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
