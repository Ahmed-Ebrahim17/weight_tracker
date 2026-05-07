import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/font_weight_helper.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class ChooseGoal extends StatelessWidget {
  final String selectedGoal;
  final ValueChanged<String> onGoalSelected;

  const ChooseGoal({
    super.key,
    required this.selectedGoal,
    required this.onGoalSelected,
  });

  static const List<String> goals = ['Lose', 'Maintain', 'Gain'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.moreLighterGray,
        borderRadius: BorderRadius.circular(32.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: goals.map((goal) {
          final isSelected = selectedGoal == goal;

          return GestureDetector(
            onTap: () => onGoalSelected(goal),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                color: isSelected
                    ? ColorsManager.lightGreen
                    : Colors.transparent,
              ),
              child: Text(
                goal,
                style: AppTextStyles.font14SemiBoldPrimaryBlue.copyWith(
                  color: ColorsManager.veryDarkGray,
                  fontWeight: isSelected
                      ? FontWeightHelper.semiBold
                      : FontWeightHelper.regular,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
