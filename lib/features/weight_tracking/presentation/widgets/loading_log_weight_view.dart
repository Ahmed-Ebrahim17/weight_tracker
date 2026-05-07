import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_tracker/core/helper/spacing.dart';

class LoadingLogWeightView extends StatelessWidget {
  const LoadingLogWeightView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(w: 160.w, h: 32.sp, r: 6.r),
                  verticalSpace(8),

                  _box(w: double.infinity, h: 14.sp, r: 4.r),

                  verticalSpace(40),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        _box(w: 140.w, h: 48.sp, r: 6.r),
                        SizedBox(width: 8.w),
                        _box(w: 28.w, h: 16.sp, r: 3.r),
                      ],
                    ),
                  ),
                  verticalSpace(40),

                  _box(w: 80.w, h: 12.sp, r: 3.r),
                  verticalSpace(16),

                  Row(
                    children: [
                      Expanded(child: _pickerCard()),
                      SizedBox(width: 16.w),
                      Expanded(child: _pickerCard()),
                    ],
                  ),
                  verticalSpace(16),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                verticalSpace(24),
                Center(
                  child: _box(w: 230.w, h: 10.sp, r: 3.r),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pickerCard() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _circle(18.sp),
        SizedBox(width: 8.w),
        _box(w: 70.w, h: 14.sp, r: 3.r),
      ],
    ),
  );

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
