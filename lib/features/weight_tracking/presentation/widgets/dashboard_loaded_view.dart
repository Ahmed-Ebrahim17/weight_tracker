import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/target_goal_and_current_streak.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/trend_card.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_summary_card.dart';

class DashboardLoadedView extends StatelessWidget {
  const DashboardLoadedView({super.key, required this.state});

  final WeightTrackingLoaded state;

  @override
  Widget build(BuildContext context) {
    final weeklyWeights = state.recentEntries
        .map((e) => e.weight)
        .toList()
        .reversed
        .toList();

    return Scaffold(
      backgroundColor: ColorsManager.veryLightGray,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("GOOD MORNING,", style: AppTextStyles.font14RegularDarkGray),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                String userName = "User";
                if (authState is AuthSuccess) {
                  final fullName = authState.user.fullName;
                  if (fullName != null && fullName.isNotEmpty) {
                    userName = fullName.split(' ').first;
                  }
                }
                return Text(userName, style: AppTextStyles.font30ExtraBoldNearBlack);
              },
            ),
            verticalSpace(20),
            WeightSummaryCard(
              currentWeight: state.latestWeight,
              weeklyChange: state.sevenDayTrend,
            ),
            verticalSpace(20),
            TrendCard(
              weeklyWeights: weeklyWeights,
              onViewDetails: () {
                context.pushNamed(Routes.historyScreen);
              },
            ),
            verticalSpace(20),
            TargetGoalAndCurrentStreak(totalEntries: state.totalEntries),
            verticalSpace(20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          await context.pushNamed(Routes.addWeightScreen);
          if (context.mounted) {
            context.read<WeightTrackingCubit>().loadDashboardData();
          }
        },
        backgroundColor: ColorsManager.primaryBlue,
        child: Icon(Icons.add, color: ColorsManager.onPrimary),
      ),
    );
  }
}
