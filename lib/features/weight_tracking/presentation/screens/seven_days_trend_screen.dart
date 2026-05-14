import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/daily_breakdown_section.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/loading_trend_view.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/trend_header.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/trend_insight_card.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weekly_summary_row.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_chart.dart';

class SevenDaysTrendScreen extends StatelessWidget {
  const SevenDaysTrendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '7 Days Trend',
          style: AppTextStyles.font20BoldVeryDarkGray,
        ),
      ),
      backgroundColor: ColorsManager.veryLightGray,
      body: BlocBuilder<WeightTrackingCubit, WeightTrackingState>(
        builder: (context, state) {
          if (state is! WeightTrackingLoaded) {
            return const LoadingTrendView();
          }

          final entries = state.recentEntries.toList()
            ..sort((a, b) => b.date.compareTo(a.date));

          final weeklyWeights = entries.reversed.map((e) => e.weight).toList();

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TrendHeader(
                    sevenDayTrend: state.sevenDayTrend,
                    entries: entries,
                  ),
                  verticalSpace(20),
                  WeightChart(weeklyWeights: weeklyWeights),
                  verticalSpace(20),
                  WeeklySummaryRow(
                    highest: state.highestWeight,
                    lowest: state.lowestWeight,
                    average: state.averageWeight,
                  ),
                  verticalSpace(24),
                  TrendInsightCard(
                    highest: state.highestWeight,
                    lowest: state.lowestWeight,
                    sevenDayTrend: state.sevenDayTrend,
                  ),
                  verticalSpace(24),
                  DailyBreakdownSection(entries: entries),
                  verticalSpace(24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
