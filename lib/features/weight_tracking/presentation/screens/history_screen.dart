import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/history_screen_body.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.veryLightGray,
      body: SafeArea(child: SingleChildScrollView(child: HistoryScreenBody())),
    );
  }
}
