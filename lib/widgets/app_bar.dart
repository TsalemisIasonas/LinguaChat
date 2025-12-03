import 'package:flutter/material.dart';

AppBar linguaAppBar({required String title_}) {
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
    actions: [IconButton(icon: Icon(Icons.home), onPressed: () {})],
  );
}
