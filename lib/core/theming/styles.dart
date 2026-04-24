import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/font_weight_helper.dart';

class AppTextStyles {
  static TextStyle font40BoldVeryDarkGray = TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.veryDarkGray,
  );
  static TextStyle font48RegularPrimaryDeepBlue = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.primaryDeepBlue,
  );
  static TextStyle font24ExtraBoldPrimaryDeepBlue = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: ColorsManager.primaryDeepBlue,
  );
    static TextStyle font26ExtraBoldPrimaryDeepBlue = TextStyle(
    fontSize: 26.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: ColorsManager.nearBlack,
  );
  static TextStyle font18LightSecondaryGray = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.light,
    color: ColorsManager.secondaryGray,
  );
  static TextStyle font14BoldOnPrimary = TextStyle(
    color: ColorsManager.onPrimary,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font18BoldOnPrimary = TextStyle(
    color: ColorsManager.onPrimary,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
  );
   static TextStyle font18RegularNearBlack = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font32BoldNearBlack = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 32.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font14BoldSemiBold = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font16RegularNearBlack = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font14RegularNearBlack = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font16RegularLightGray = TextStyle(
    color: ColorsManager.lightGray,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font12BoldNearBlack = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font10BoldlightGray = TextStyle(
    color: ColorsManager.lightGray,
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
  );

 static TextStyle  font12RegularGray = TextStyle(
    color: ColorsManager.gray6E7979,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font24BoldNearBlack = TextStyle(
    color: ColorsManager.nearBlack,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
  );
}
