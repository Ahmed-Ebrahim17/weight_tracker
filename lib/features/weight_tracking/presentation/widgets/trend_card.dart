import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_chart.dart';

class TrendCard extends StatelessWidget {
  final List<double> weeklyWeights;
  final VoidCallback? onViewDetails;

  const TrendCard({super.key, required this.weeklyWeights, this.onViewDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 16.w,
        top: 12.h,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: ColorsManager.darkLightGray,
        borderRadius: BorderRadius.circular(24.r),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("7-Day Trend", style: AppTextStyles.font18BoldVeryDarkGray),
              TextButton(
                onPressed: onViewDetails,
                child: Text(
                  "View Details",
                  style: AppTextStyles.font14SemiBoldPrimaryBlue,
                ),
              ),
            ],
          ),
          verticalSpace(20),
          WeightChart(weeklyWeights: weeklyWeights),
        ],
      ),
    );
  }
}
