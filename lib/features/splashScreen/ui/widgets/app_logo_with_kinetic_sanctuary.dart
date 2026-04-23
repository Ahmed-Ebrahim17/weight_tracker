import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_tracker/core/helper/assets.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class AppLogoWithKineticSanctuary extends StatelessWidget {
  const AppLogoWithKineticSanctuary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.appLogo, height: 80.h),
        verticalSpace(64),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Kinetic\n',
                style: AppTextStyles.font40BoldVeryDarkGray,
              ),
              TextSpan(
                text: 'Sanctuary',
                style: AppTextStyles.font48RegularPrimaryDeepBlue,
              ),
            ],
          ),
        ),
        verticalSpace(24),
        Text(
          'Align your energy. Master your rest.',
          style: AppTextStyles.font18LightSecondaryGray,
        ),
      ],
    );
  }
}
