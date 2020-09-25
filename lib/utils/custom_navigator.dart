import 'package:flutter/material.dart';
import 'package:topnews/controllers/main_controller.dart';

class CustomNavigator {
  static void goToHome(BuildContext context, MainController controller) {
    Navigator.pushReplacementNamed(
      context,
      '/home',
      arguments: controller,
    );
  }
}