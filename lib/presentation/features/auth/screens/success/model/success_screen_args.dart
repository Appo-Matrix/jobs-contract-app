import 'package:flutter/material.dart';

class SuccessScreenArgs {
  final String title;
  final String message;
  final String imagePath;
  final String buttonText;
  final VoidCallback onButtonTap;

  SuccessScreenArgs({
    required this.title,
    required this.message,
    required this.imagePath,
    required this.buttonText,
    required this.onButtonTap,
  });
}
