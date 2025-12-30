import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';

AppBar linguaAppBar({required String title_, required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: Text(
      title_,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    ),
    elevation: 4,
    actions: [IconButton(icon: Icon(Icons.home), onPressed: () {
      Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
    })],
  );
}
