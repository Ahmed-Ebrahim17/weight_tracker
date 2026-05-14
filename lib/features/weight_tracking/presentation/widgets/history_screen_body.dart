import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/app_name_with_notifications_icon.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/loading_history_view.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_ur_next_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/recent_entries_section.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_goal_card.dart';

class HistoryScreenBody extends StatelessWidget {
  const HistoryScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightTrackingCubit, WeightTrackingState>(
      builder: (context, state) {
        if (state is WeightTrackingLoading) {
          return const LoadingHistoryView();
        }

        // Extract values when loaded
        double currentWeight = 0.0;
        double targetWeight = 0.0;

        if (state is WeightTrackingLoaded) {
          currentWeight = state.latestWeight ?? 0.0;
          targetWeight = state.targetWeight ?? 0.0;
        }

        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppNameWithNotificationsIcon(),
              verticalSpace(16),
              Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My Journey',
                      style: AppTextStyles.font20BoldVeryDarkGray,
                    ),
                    verticalSpace(8),
                    Text(
                      'Tracking your progress',
                      style: AppTextStyles.font12GrayRegular,
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
              WeightGoalCard(
                currentWeight: currentWeight,
                targetWeight: targetWeight,
              ),
              verticalSpace(12),
              RecentEntriesSection(
                weightEntries: state is WeightTrackingLoaded ? state.recentEntries : [],
              ),
              verticalSpace(8),
              const LogYourNextEntry(),
            ],
          ),
        );
      },
    );
  }
}
