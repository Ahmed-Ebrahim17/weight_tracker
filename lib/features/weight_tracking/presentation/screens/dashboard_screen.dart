import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.veryLightGray,
      body: SafeArea(child: DashboardBody()),
    );
  }
}
