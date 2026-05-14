import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class WeeklySummaryRow extends StatelessWidget {
  const WeeklySummaryRow({
    required this.highest,
    required this.lowest,
    required this.average,
    super.key,
  });

  final double? highest;
  final double? lowest;
  final double? average;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.weeklySummary,
          style: AppTextStyles.font18BoldVeryDarkGray,
        ),
        verticalSpace(16),
        Row(
          children: [
            Expanded(
              child: _SummaryMetric(
                icon: Icons.arrow_upward_rounded,
                iconColor: ColorsManager.primaryBlue,
                label: AppStrings.highest,
                value: highest,
              ),
            ),
            Expanded(
              child: _SummaryMetric(
                icon: Icons.arrow_downward_rounded,
                iconColor: ColorsManager.secondaryDark2,
                label: AppStrings.lowest,
                value: lowest,
              ),
            ),
            Expanded(
              child: _SummaryMetric(
                icon: Icons.sync_alt_rounded,
                iconColor: ColorsManager.tertiaryDark1,
                label: AppStrings.average,
                value: average,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14.sp, color: iconColor),
            horizontalSpace(4),
            Text(
              label,
              style: AppTextStyles.font12BoldNearBlack.copyWith(
                color: iconColor,
                fontSize: 10.sp,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        verticalSpace(6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value?.toStringAsFixed(1) ?? '--',
              style: AppTextStyles.font20BoldVeryDarkGray,
            ),
            horizontalSpace(4),
            Text(AppStrings.units, style: AppTextStyles.font12RegularGray),
          ],
        ),
      ],
    );
  }
}
