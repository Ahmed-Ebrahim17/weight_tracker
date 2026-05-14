import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_arc_painter.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/weight_label.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';

class WeightGoalCard extends StatelessWidget {
  final double currentWeight;
  final double targetWeight;

  const WeightGoalCard({
    super.key,
    required this.currentWeight,
    required this.targetWeight,
  });

  double get _difference => currentWeight - targetWeight;

  /// Progress 0.0 → 1.0 based on how close to goal.
  /// Assumes a starting reference weight of currentWeight + difference buffer.
  double get _progress {
    if (_difference <= 0) return 1.0;
    // Example: progress relative to a 10-lb journey
    const journeyLength = 10.0;
    final lost = journeyLength - _difference;
    return (lost / journeyLength).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final arcSize = 150.r;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsManager.surface,
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
          // ── Title ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("WEIGHT GOAL", style: AppTextStyles.font12BoldNearBlack),
              IconButton(
                onPressed: () async {
                  await context.pushNamed(Routes.goalScreen);
                  if (context.mounted) {
                    context.read<WeightTrackingCubit>().loadDashboardData();
                  }
                },
                icon: Icon(size: 14.sp, Icons.edit),
              ),
            ],
          ),
          verticalSpace(24),

          SizedBox(
            width: arcSize,
            height: arcSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(arcSize, arcSize),
                  painter: WeightArcPainter(progress: _progress),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${_difference > 0 ? '-' : '+'}${_difference.abs().toStringAsFixed(1)}",
                      style: AppTextStyles.font24ExtraBoldPrimaryDeepBlue,
                    ),
                    Text(
                      "lbs to go",
                      style: AppTextStyles.font12RegularGray.copyWith(
                        color: ColorsManager.darkGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          verticalSpace(24),

          // ── Current / Target row ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WeightLabel(
                label: "Current",
                value: "${currentWeight.toStringAsFixed(1)} lbs",
              ),
              WeightLabel(
                label: "Target",
                value: "${targetWeight.toStringAsFixed(1)} lbs",
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
