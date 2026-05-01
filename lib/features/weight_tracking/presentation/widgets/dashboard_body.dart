import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/target_goal_and_current_streak.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/trend_card.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_summary_card.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightTrackingCubit, WeightTrackingState>(
      builder: (context, state) {
        return switch (state) {
          WeightTrackingInitial() => const _LoadingView(),
          WeightTrackingLoading() => const _LoadingView(),
          WeightTrackingError(:final message) => _ErrorView(message: message),
          WeightTrackingLoaded() => _DashboardLoadedView(state: state),
        };
      },
    );
  }
}

/// Shown while data is being fetched.
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryBlue),
    );
  }
}

/// Shown when loading dashboard data fails.
class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.sp,
              color: ColorsManager.darkGray,
            ),
            verticalSpace(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16RegularNearBlack,
            ),
            verticalSpace(24),
            TextButton.icon(
              onPressed: () {
                context.read<WeightTrackingCubit>().loadDashboardData();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The main dashboard content shown when data is loaded successfully.
class _DashboardLoadedView extends StatelessWidget {
  const _DashboardLoadedView({required this.state});

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
            Text("Sarah", style: AppTextStyles.font30ExtraBoldNearBlack),
            verticalSpace(20),
            WeightSummaryCard(
              currentWeight: state.latestWeight,
              weeklyChange: state.sevenDayTrend,
            ),
            verticalSpace(20),
            TrendCard(
              weeklyWeights: weeklyWeights,
              onViewDetails: () {
                // TODO: Navigate to trend details screen
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
