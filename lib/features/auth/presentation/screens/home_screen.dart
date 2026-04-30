import 'package:flutter/material.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/screens/log_weight_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton
        (
          onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LogWeightScreen(),
    ),
  );
          },
          child: const Text('Test'),
        ),
      ),
    );
  }
}