import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/font_weight_helper.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class TargetWeightCard extends StatelessWidget {
  final double currentWeight;
  final double targetWeight;
  final ValueChanged<double> onTargetWeightChanged;

  const TargetWeightCard({
    super.key,
    required this.currentWeight,
    required this.targetWeight,
    required this.onTargetWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Section label
        Text(
          'TARGET WEIGHT',
          style: AppTextStyles.font14SemiBoldPrimaryBlue.copyWith(
            color: ColorsManager.darkGray,
            letterSpacing: 0.8,
          ),
        ),
        verticalSpace(20),

        // Weight number + unit
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              targetWeight.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), ''),
              style: AppTextStyles.font72ExtraBoldVeryDarkGray.copyWith(
                color: ColorsManager.primaryBlue,
                fontSize: 64.sp,
              ),
            ),
            horizontalSpace(6),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Text(
                'lbs',
                style: AppTextStyles.font20BoldVeryDarkGray.copyWith(
                  color: ColorsManager.darkGray,
                  fontWeight: FontWeightHelper.semiBold,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(20),

        // ─ / Current: 165 lbs / + row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CircleButton(
              icon: Icons.remove,
              onPressed: () {
                if (targetWeight > 1) {
                  onTargetWeightChanged(targetWeight - 1);
                }
              },
            ),
            horizontalSpace(20),
            Text(
              'Current: ${currentWeight.toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')} lbs',
              style: AppTextStyles.font16RegularNearBlack.copyWith(
                color: ColorsManager.darkGray,
              ),
            ),
            horizontalSpace(20),
            _CircleButton(
              icon: Icons.add,
              onPressed: () {
                onTargetWeightChanged(targetWeight + 1);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CircleButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: const BoxDecoration(
          color: ColorsManager.darkLightGray,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18.sp, color: ColorsManager.darkGray),
      ),
    );
  }
}
