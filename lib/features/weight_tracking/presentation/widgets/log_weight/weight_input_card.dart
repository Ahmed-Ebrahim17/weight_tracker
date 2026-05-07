import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class WeightInputCard extends StatelessWidget {
  const WeightInputCard({super.key, required this.controller, this.label});

  final TextEditingController controller;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h),
      decoration: BoxDecoration(
        color: ColorsManager.darkLightGray,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(
        children: [
          if (label != null) ...[
            Text(
              label!.toUpperCase(),
              style: AppTextStyles.font12RegularGray.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            verticalSpace(16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
          SizedBox(
            width: 140.w,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: AppTextStyles.font48RegularPrimaryDeepBlue.copyWith(
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: '0.0',
                hintStyle: AppTextStyles.font48RegularPrimaryDeepBlue.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.primaryDeepBlue.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          horizontalSpace(8),
          Text(
            'lbs',
            style: AppTextStyles.font16RegularNearBlack.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
            ],
          ),
        ],
      ),
    );
  }
}
