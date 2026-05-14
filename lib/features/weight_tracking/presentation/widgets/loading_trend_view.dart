import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_tracker/core/helper/spacing.dart';

class LoadingTrendView extends StatelessWidget {
  const LoadingTrendView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ───────────────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _bone(width: 20.w, height: 20.w, radius: 4),
                        verticalSpace(16),
                        _bone(width: 180.w, height: 24.h, radius: 6),
                        verticalSpace(6),
                        _bone(width: 130.w, height: 12.h, radius: 4),
                      ],
                    ),
                  ),
                  _bone(width: 80.w, height: 36.h, radius: 8),
                ],
              ),

              verticalSpace(24),

              // ── Chart ────────────────────────────────────────────────
              _bone(
                width: double.infinity,
                height: 220.h,
                radius: 16,
              ),

              verticalSpace(28),

              // ── Weekly Summary ────────────────────────────────────────
              _bone(width: 140.w, height: 18.h, radius: 6),
              verticalSpace(16),
              Row(
                children: List.generate(3, (_) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _bone(width: 60.w, height: 10.h, radius: 4),
                          verticalSpace(8),
                          _bone(width: 70.w, height: 22.h, radius: 6),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              verticalSpace(24),

              // ── Trend Insight Card ───────────────────────────────────
              _bone(
                width: double.infinity,
                height: 120.h,
                radius: 16,
              ),

              verticalSpace(28),

              // ── Daily Breakdown ───────────────────────────────────────
              _bone(width: 140.w, height: 18.h, radius: 6),
              verticalSpace(16),
              ...List.generate(5, (_) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      _bone(width: 36.w, height: 14.h, radius: 4),
                      horizontalSpace(16),
                      _bone(width: 90.w, height: 16.h, radius: 4),
                      const Spacer(),
                      _bone(width: 22.w, height: 14.h, radius: 4),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable shimmer placeholder block.
  static Widget _bone({
    required double width,
    required double height,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
