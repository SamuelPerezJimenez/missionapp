import 'package:flutter/material.dart';

enum SnackBarType { success, information, failure }

class CustomSnackBar {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  CustomSnackBar(this.scaffoldMessengerKey);

  void show(String message, SnackBarType type) {
    Color backgroundColor;
    switch (type) {
      case SnackBarType.success:
        backgroundColor = const Color.fromARGB(255, 36, 138, 40);
        break;
      case SnackBarType.information:
        backgroundColor = Colors.blueAccent;
        break;
      case SnackBarType.failure:
        backgroundColor = Colors.redAccent;
        break;
    }

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    );
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
