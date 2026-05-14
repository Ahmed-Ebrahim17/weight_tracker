import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/assets.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class AppLogoWithLoginScreenHeader extends StatelessWidget {
  const AppLogoWithLoginScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppAssets.appLogo, height: 48.h),
        verticalSpace(24),
        Text(
          AppStrings.appName,
          textAlign: TextAlign.center,
          style: AppTextStyles.font32BoldNearBlack,
        ),
        verticalSpace(12),
        Text(
          AppStrings.welcomeBackLogin,
          textAlign: TextAlign.center,
          style: AppTextStyles.font16RegularNearBlack,
        ),
      ],
    );
  }
}
