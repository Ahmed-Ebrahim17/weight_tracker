import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';

class SaveGoalButton extends StatelessWidget {
  const SaveGoalButton({
    super.key,
    required double targetWeight,
    required DateTime targetDate,
    required String selectedGoal,
  }) : _targetWeight = targetWeight,
       _targetDate = targetDate,
       _selectedGoal = selectedGoal;

  final double _targetWeight;
  final DateTime _targetDate;
  final String _selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 32.h),
      child: AppTextButton(
        buttonHeight: 60.h,
        onPressed: () {
          context.read<WeightTrackingCubit>().saveTargetGoal(
            targetWeight: _targetWeight,
            targetDate: _targetDate,
            goalType: _selectedGoal,
          );
          context.pop();
        },
        backgroundColor: ColorsManager.primaryBlue,
        child: Text('Save Goal', style: AppTextStyles.font16BoldOnPrimary),
      ),
    );
  }
}
