import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class TrendInsightCard extends StatelessWidget {
  const TrendInsightCard({
    required this.highest,
    required this.lowest,
    required this.sevenDayTrend,
    super.key,
  });

  final double? highest;
  final double? lowest;
  final double? sevenDayTrend;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.primaryBlueLight3.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(14.r),
        border: Border(
          left: BorderSide(
            color: ColorsManager.primaryBlue,
            width: 3.w,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InsightIcon(),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.trendInsight,
                  style: AppTextStyles.font16BoldVeryDarkGray,
                ),
                verticalSpace(6),
                Text(
                  _buildInsightMessage(),
                  style: AppTextStyles.font14RegularDarkGray.copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildInsightMessage() {
    if (highest == null || lowest == null) {
      return 'Not enough data yet. Keep logging to see insights.';
    }

    final range = (highest! - lowest!).abs();
    final direction = _trendDirection;

    if (range <= 2.0) {
      return 'You\'ve been very consistent this week! '
          'Your weight stayed within a tight ${range.toStringAsFixed(1)} ${AppStrings.units} range. '
          'The overall trend shows a slight, healthy $direction trajectory.';
    }

    return 'Your weight varied by ${range.toStringAsFixed(1)} ${AppStrings.units} this week. '
        'The overall trend is $direction. '
        'Try to maintain consistent meal times for steadier results.';
  }

  String get _trendDirection {
    if (sevenDayTrend == null) return '';
    if (sevenDayTrend! < 0) return 'downward';
    if (sevenDayTrend! > 0) return 'upward';
    return 'flat';
  }
}

class _InsightIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: ColorsManager.primaryBlueLight3.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(
        Icons.auto_awesome,
        color: ColorsManager.primaryBlue,
        size: 20.sp,
      ),
    );
  }
}
