import 'package:flutter/material.dart';
import 'package:weight_tracker/features/onboarding/presentation/widgets/onboarding_screen_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingScreenBody(),
    );
  }
}
