import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/widgets/input_field.dart';
import 'package:lingua_chat/widgets/print_error_text.dart';
import 'package:lingua_chat/repositories/user_repository.dart';
import 'package:lingua_chat/services/sound_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordVerifyController = TextEditingController();
  String? _registerErrorMessage;

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2B2B2B),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
  );

  Future<void> registerUserWithEmailAndPassword() async {
    try {
      String newUserEmail = _emailController.text.trim();

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newUserEmail,
        password: _passwordController.text.trim(),
      );

      UserRepository().createDefaultUser(newUserEmail);
      if (!mounted) return;

      AppSound.intro.play();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _registerErrorMessage = e.message;
        AppSound.error.play();
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordVerifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          printErrorText(_registerErrorMessage),
          const SizedBox(height: 10),

          inputField("Email", _emailController),
          const SizedBox(height: 20),

          inputField("Password", _passwordController, obscureText_: true),
          const SizedBox(height: 12),

          inputField(
            "Verify Password",
            _passwordVerifyController,
            obscureText_: true,
          ),
          const SizedBox(height: 32),

          // Register button
          ElevatedButton(
            onPressed: () async {
              AppSound.click.play();
              if (_passwordController.text != _passwordVerifyController.text) {
                setState(() {
                  _registerErrorMessage =
                      "Password wasn't the same both times!";
                });

                return;
              }

              await registerUserWithEmailAndPassword();
            },
            style: _buttonStyle,
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 10),
          const Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Login button
          ElevatedButton(
            onPressed: () async {
              AppSound.click.play();
              Navigator.pop(context);
            },
            style: _buttonStyle,
            child: const Text(
              'Log In',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}