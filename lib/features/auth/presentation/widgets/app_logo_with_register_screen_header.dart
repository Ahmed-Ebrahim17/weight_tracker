import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/assets.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class AppLogoWithRegisterScreenHeader extends StatelessWidget {
  const AppLogoWithRegisterScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.appLogo,
              height: 32.h,
              colorFilter: ColorFilter.mode(
                ColorsManager.secondaryDark2,
                BlendMode.srcIn,
              ),
            ),
            horizontalSpace(12),
            Text(AppStrings.appName, style: AppTextStyles.font24BoldNearBlack),
          ],
        ),
        verticalSpace(32),
        Text(
          AppStrings.registerTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.font32BoldNearBlack,
        ),
        verticalSpace(16),
        Text(
          AppStrings.registerDescription,
          textAlign: TextAlign.center,
          style: AppTextStyles.font16RegularNearBlack,
        ),
      ],
    );
  }
}
