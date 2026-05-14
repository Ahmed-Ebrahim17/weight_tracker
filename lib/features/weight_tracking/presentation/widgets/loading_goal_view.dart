import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_tracker/core/helper/spacing.dart';

/// Pixel-perfect shimmer skeleton for GoalScreen / SetGoalBody.
///
/// Layout mirrors:
///   padding: 24.w / 24.h
///   ChooseGoal   → pill toggle: radius 32.r, items padding 24.w/10.h, font14
///   verticalSpace(40)
///   TargetWeightCard → label font14 + big number 64.sp + "lbs" font20 +
///                      verticalSpace(20) × 2 + circle-buttons 36.w + text
///   verticalSpace(32)
///   TargetDateSection → header font14 + calendar icon 22.sp + date strip 80.h
///   SaveGoalButton → padding 24.w/8.h/32.h, height 60.h, full-width
class LoadingGoalView extends StatelessWidget {
  const LoadingGoalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── ChooseGoal toggle ──
                  // Container: radius 32.r, padding all 4.w
                  // Three items: padding 24.w/10.h, text font14 ≈ 14.sp
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (i) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          child: _box(w: 36.w, h: 14.sp, r: 3.r),
                        );
                      }),
                    ),
                  ),
                  verticalSpace(40),

                  // ── TargetWeightCard ──
                  // "TARGET WEIGHT" label font14
                  _box(w: 130.w, h: 14.sp, r: 3.r),
                  verticalSpace(20),

                  // Big number: 64.sp  +  "lbs" font20
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      _box(w: 100.w, h: 64.sp, r: 8.r),
                      SizedBox(width: 6.w),
                      _box(w: 30.w, h: 20.sp, r: 4.r),
                    ],
                  ),
                  verticalSpace(20),

                  // Circle-minus  |  "Current: xx lbs" font16  |  Circle-plus
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _circle(36.w), // 36.w × 36.w button
                      SizedBox(width: 20.w),
                      _box(w: 140.w, h: 16.sp, r: 4.r),
                      SizedBox(width: 20.w),
                      _circle(36.w),
                    ],
                  ),
                  verticalSpace(32),

                  // ── TargetDateSection ──
                  // Header row: "TARGET DATE" font14  |  calendar icon 22.sp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _box(w: 100.w, h: 14.sp, r: 3.r),
                      _circle(22.sp),
                    ],
                  ),
                  verticalSpace(16),

                  // Date scroll strip: SizedBox height 80.h
                  // Shows 5 representative date cells (itemWidth ≈ 56 px each)
                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemExtent: 56,
                      itemBuilder: (_, _) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _box(w: 28.w, h: 10.sp, r: 3.r), // month label
                            verticalSpace(4),
                            _box(w: 28.w, h: 24.sp, r: 4.r), // day number
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── SaveGoalButton ──
        // padding: fromLTRB(24.w, 8.h, 24.w, 32.h), height 60.h
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 32.h),
            child: Container(
              width: double.infinity,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _box({required double w, required double h, required double r}) =>
      Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r),
        ),
      );

  Widget _circle(double size) => Container(
    width: size,
    height: size,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
  );
}
