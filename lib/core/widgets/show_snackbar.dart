import 'package:flutter/material.dart';

void showSnakBar(BuildContext context ,Color color,{required String text,} ) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      content: Text(text),
    ),
  );
}