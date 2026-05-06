import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/app_name_with_notifications_icon.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_ur_next_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/recent_entries_section.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_goal_card.dart';

class HistoryScreenBody extends StatelessWidget {
  const HistoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppNameWithNotificationsIcon(),
          verticalSpace(24),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('My Journey', style: AppTextStyles.font20BoldVeryDarkGray),
                verticalSpace(8),
                Text(
                  'Tracking your progress',
                  style: AppTextStyles.font12GrayRegular,
                ),
              ],
            ),
          ),
          verticalSpace(24),
          const WeightGoalCard(currentWeight: 164.2, targetWeight: 160.0),
          verticalSpace(16),
          const RecentEntriesSection(),
          verticalSpace(8),
          const LogYourNextEntry(),
        ],
      ),
    );
  }
}
