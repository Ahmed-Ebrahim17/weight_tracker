import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_tracker/core/helper/assets.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class AppLogoWithLoginScreenHeader extends StatelessWidget {
  const AppLogoWithLoginScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.appLogo, height: 48.h),
        verticalSpace(24),
        Text("Kinetic Sanctuary", style: AppTextStyles.font32BoldNearBlack),
        verticalSpace(12),
        Text(
          "Welcome back. Log in to continue your\njourney.",
          textAlign: TextAlign.center,
          style: AppTextStyles.font16RegularNearBlack,
        ),
      ],
    );
  }
}
