import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/set_goal_body.dart';

class GoalScreen extends StatelessWidget {
  const GoalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text('Set Goal', style: AppTextStyles.font20BoldVeryDarkGray),
        elevation: 0,
      ),
      body: SetGoalBody(),
    );
  }
}
