import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:lingua_chat/repositories/user_repository.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/screens/register_screen.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/widgets/input_field.dart';
import 'package:lingua_chat/widgets/print_error_text.dart';
import 'package:lingua_chat/services/sound_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _loginErrorMessage;

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2B2B2B),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 4,
  );

  Future<void> loginUserWithEmailAndPassword() async {
    String userEmail = _emailController.text.trim();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: _passwordController.text.trim(),
      );

      currentUser = await UserRepository().getUser(userEmail);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        AppSound.error.play();
        _loginErrorMessage = e.message;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            'Log In',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),

          printErrorText(_loginErrorMessage),
          const SizedBox(height: 10),

          inputField("Email", _emailController),
          const SizedBox(height: 20),

          inputField("Password", _passwordController, obscureText_: true),
          const SizedBox(height: 32),

          // Login button
          ElevatedButton(
            onPressed: () async {
              AppSound.click.play();
              await loginUserWithEmailAndPassword();
            },
            style: _buttonStyle,
            child: const Text(
              'Log In',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            'OR',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Register button
          ElevatedButton(
            onPressed: () async {
              AppSound.click.play();
              Navigator.push(context, RegisterScreen.route());
            },
            style: _buttonStyle,
            child: const Text(
              'Register Here',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
