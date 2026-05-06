import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class EntryListItem extends StatelessWidget {
  final String weight;
  final String date;
  final String diff;
  final bool isDecrease;

  const EntryListItem({
    required this.weight,
    required this.date,
    required this.diff,
    required this.isDecrease,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IconData icon = isDecrease
        ? Icons.trending_down
        : Icons.arrow_forward;
    final Color iconBgColor = isDecrease
        ? ColorsManager.lightGrayishGreen
        : ColorsManager.neutralLight3;
    final Color iconColor = isDecrease
        ? ColorsManager.secondaryDark2
        : ColorsManager.nearBlack;
    final Color diffColor = isDecrease
        ? ColorsManager.secondaryDark2
        : ColorsManager.nearBlack;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.darkGray2,
        borderRadius: BorderRadius.circular(100.r), // Pill shape
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(weight, style: AppTextStyles.font16BoldVeryDarkGray),
              verticalSpace(4),
              Text(date, style: AppTextStyles.font12RegularGray),
            ],
          ),
          const Spacer(),
          Text(
            diff,
            style: AppTextStyles.font16BoldVeryDarkGray.copyWith(
              color: diffColor,
            ),
          ),
          horizontalSpace(8),
        ],
      ),
    );
  }
}
