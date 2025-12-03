import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lingua_chat/models/database.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/screens/home_screen.dart';

import 'package:lingua_chat/widgets/input_field.dart';
import 'package:lingua_chat/widgets/print_error_text.dart';

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
    padding: const EdgeInsets.symmetric(vertical: 18),
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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );

      currentUser = await DatabaseService().getUser(userEmail);
    } on FirebaseAuthException catch (e) {
      setState(() {
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
      padding: const EdgeInsets.all(40),
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
          const SizedBox(height: 40),

          printErrorText(_loginErrorMessage),
          const SizedBox(height: 10),

          inputField("Email", _emailController),
          const SizedBox(height: 24),

          inputField("Password", _passwordController, obscureText_: true),
          const SizedBox(height: 32),

          // Login button
          ElevatedButton(
            onPressed: () async {
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
              Navigator.pop(context);
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
