import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_tracker/core/helper/spacing.dart';

class LoadingHistoryView extends StatelessWidget {
  const LoadingHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── AppNameWithNotificationsIcon ──
            // Text: font18ExtraBold ≈ 18sp tall, IconButton touch target = 48×48
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(w: 110.w, h: 18.sp, r: 4.r),
                _circle(size: 24.sp), // icon inside IconButton
              ],
            ),
            verticalSpace(24),

            // ── "My Journey" + subtitle (centered) ──
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  _box(w: 130.w, h: 20.sp, r: 5.r),
                  verticalSpace(8),
                  _box(w: 155.w, h: 12.sp, r: 4.r),
                ],
              ),
            ),
            verticalSpace(24),

            // ── WeightGoalCard ──
            // padding: 20.w / 20.h, radius: 32.r
            // inner: title row + verticalSpace(48) + arc 180.r + verticalSpace(48) + labels row
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Column(
                children: [
                  // "WEIGHT GOAL" title + edit icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _box(w: 90.w, h: 12.sp, r: 3.r),
                      SizedBox(width: 8.w),
                      _circle(size: 14.sp),
                    ],
                  ),
                  verticalSpace(48),

                  // Circular arc skeleton
                  _circle(size: 180.r),
                  verticalSpace(48),

                  // Current / Target row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _box(w: 55.w, h: 12.sp, r: 3.r),
                          verticalSpace(4),
                          _box(w: 70.w, h: 14.sp, r: 3.r),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _box(w: 45.w, h: 12.sp, r: 3.r),
                          verticalSpace(4),
                          _box(w: 70.w, h: 14.sp, r: 3.r),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(16),

            // ── RecentEntriesSection header ──
            // Row: "Recent Entries" font16Bold  |  "View All" TextButton font10
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(w: 120.w, h: 16.sp, r: 4.r),
                _box(w: 50.w, h: 10.sp, r: 3.r),
              ],
            ),
            verticalSpace(12),

            // ── 3 × EntryListItem pills ──
            // padding: 16.w / 12.h
            // circle: 44.w × 44.w
            // text: font16 / font12  |  diff: font16  |  chevron: 12.sp
            _pill(),
            verticalSpace(12),
            _pill(),
            verticalSpace(12),
            _pill(),
            verticalSpace(8),

            // ── LogYourNextEntry ──
            // Container: padding 24.w/24.h, radius 32.r
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32.r),
              ),
              child: Column(
                children: [
                  _circle(size: 28.sp),
                  verticalSpace(8),
                  _box(w: 220.w, h: 14.sp, r: 4.r),
                ],
              ),
            ),
            verticalSpace(24),

            // AppTextButton: height 70.h, radius 70.r
            Container(
              width: double.infinity,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(70.r),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Plain rounded rectangle placeholder.
  Widget _box({required double w, required double h, required double r}) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );
  }

  /// Circle placeholder (use for icons or the arc).
  Widget _circle({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  /// Pill-shaped row skeleton matching EntryListItem exactly.
  /// Real item: horizontal padding 16.w, vertical 12.h,
  ///            circle 44.w, text font16/font12, diff font16, chevron 12.sp
  Widget _pill() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Row(
        children: [
          // Icon circle: 44.w × 44.w
          _circle(size: 44.w),
          SizedBox(width: 16.w),
          // Weight text (font16) + date text (font12)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _box(w: 80.w, h: 16.sp, r: 4.r),
              verticalSpace(4),
              _box(w: 100.w, h: 12.sp, r: 3.r),
            ],
          ),
          const Spacer(),
          // Diff text: font16
          _box(w: 52.w, h: 16.sp, r: 4.r),
          SizedBox(width: 8.w),
          // Chevron: 12.sp
          _box(w: 8.w, h: 12.sp, r: 2.r),
        ],
      ),
    );
  }
}
