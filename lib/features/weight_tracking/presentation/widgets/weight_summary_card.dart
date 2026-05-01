import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class WeightSummaryCard extends StatelessWidget {
  const WeightSummaryCard({
    super.key,
    required this.currentWeight,
    required this.weeklyChange,
  });

  /// The most recent weight value. Null when no entries exist yet.
  final double? currentWeight;

  /// Weight change over the last 7 days. Null when not enough data.
  final double? weeklyChange;

  @override
  Widget build(BuildContext context) {
    final displayWeight = currentWeight?.toStringAsFixed(1) ?? '--';
    final trendText = _buildTrendText();
    final trendIcon = _buildTrendIcon();
    final trendColor = _buildTrendColor();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.8,
          colors: [
            ColorsManager.primaryBlueLight3.withValues(alpha: 0.2),
            ColorsManager.surface,
          ],
          stops: const [0.0, 0.5],
        ),
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'CURRENT WEIGHT',
            style: AppTextStyles.font14BoldSemiBold.copyWith(
              letterSpacing: 1.5,
              color: ColorsManager.darkGray,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(displayWeight, style: AppTextStyles.font72ExtraBoldVeryDarkGray),
              SizedBox(width: 8.w),
              Text(
                'lbs',
                style: AppTextStyles.font24BoldNearBlack.copyWith(
                  color: ColorsManager.darkGray,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: trendColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(trendIcon, color: trendColor, size: 20.sp),
                SizedBox(width: 4.w),
                Text(
                  trendText,
                  style: AppTextStyles.font16RegularNearBlack.copyWith(
                    fontWeight: FontWeight.w600,
                    color: trendColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildTrendText() {
    if (weeklyChange == null) return 'Not enough data';
    final sign = weeklyChange! > 0 ? '+' : '';
    return '$sign${weeklyChange!.toStringAsFixed(1)} lbs this week';
  }

  IconData _buildTrendIcon() {
    if (weeklyChange == null) return Icons.remove;
    if (weeklyChange! < 0) return Icons.trending_down;
    if (weeklyChange! > 0) return Icons.trending_up;
    return Icons.trending_flat;
  }

  Color _buildTrendColor() {
    if (weeklyChange == null) return ColorsManager.darkGray;
    if (weeklyChange! < 0) return ColorsManager.secondaryDark2;
    if (weeklyChange! > 0) return ColorsManager.tertiaryDark1;
    return ColorsManager.darkGray;
  }
}
