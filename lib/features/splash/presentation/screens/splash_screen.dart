import 'package:flutter/material.dart';
import 'package:weight_tracker/features/splash/presentation/widgets/splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashScreenBody());
  }
}
