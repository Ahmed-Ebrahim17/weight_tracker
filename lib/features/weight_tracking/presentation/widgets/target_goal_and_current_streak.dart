import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class TargetGoalAndCurrentStreak extends StatelessWidget {
  const TargetGoalAndCurrentStreak({super.key, required this.totalEntries});

  /// Total number of weight entries logged by the user.
  final int totalEntries;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildTargetGoalCard()),
          horizontalSpace(16),
          Expanded(child: _buildTotalEntriesCard()),
        ],
      ),
    );
  }

  Widget _buildTargetGoalCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.surface,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.lightGrayishGreen,
            ),
            child: const Icon(
              Icons.flag_outlined,
              color: ColorsManager.nearBlack,
            ),
          ),
          verticalSpace(16),
          Text(
            "TARGET GOAL",
            style: AppTextStyles.font12RegularGray.copyWith(letterSpacing: 1.2),
          ),
          verticalSpace(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "135.0",
                style: AppTextStyles.font32BoldNearBlack.copyWith(
                  fontSize: 26.sp,
                ),
              ),
              horizontalSpace(4),
              Text("lbs", style: AppTextStyles.font14RegularNearBlack),
            ],
          ),
          verticalSpace(16),
          Container(
            height: 6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.lightGrayishGreen,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor:
                  0.7, // 70% progress — will be dynamic when goal feature is built
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.secondaryDark2,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalEntriesCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.surface,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.lightOrange,
            ),
            child: const Icon(
              Icons.bar_chart_rounded,
              color: ColorsManager.darkOrange,
            ),
          ),
          verticalSpace(16),
          Text(
            "CURRENT\nSTREAK",
            style: AppTextStyles.font12RegularGray.copyWith(
              letterSpacing: 1.2,
              height: 1.2,
            ),
          ),
          verticalSpace(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$totalEntries',
                style: AppTextStyles.font32BoldNearBlack.copyWith(
                  fontSize: 26.sp,
                ),
              ),
              horizontalSpace(4),
              Text("Days", style: AppTextStyles.font14RegularNearBlack),
            ],
          ),
        ],
      ),
    );
  }
}
