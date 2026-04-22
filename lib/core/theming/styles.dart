import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/font_weight_helper.dart';

class AppTextStyles {
  static TextStyle font40Bold = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.veryDarkGray,
  );
  static TextStyle font48Regular = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.primaryDeepBlue,
  );
  static TextStyle font18Light = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.light,
    color: ColorsManager.secondaryGray,
  );
  static TextStyle font14Bold = TextStyle(
    color: ColorsManager.onPrimary,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
  );
}
