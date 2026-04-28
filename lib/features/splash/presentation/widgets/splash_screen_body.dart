import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart' show Routes;
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/splash/presentation/widgets/app_logo_with_kinetic_sanctuary.dart';

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpace(MediaQuery.of(context).size.height * 0.25),
          AppLogoWithKineticSanctuary(),
          Spacer(),
          AppTextButton(
            borderRadius: 50,
            buttonHeight: 60,
            onPressed: () => context.pushNamed(Routes.loginScreen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.enterTheFlow,
                  style: AppTextStyles.font14BoldOnPrimary,
                ),
                horizentalSpace(16),
                Icon(Icons.arrow_forward, color: ColorsManager.onPrimary),
              ],
            ),
          ),
          verticalSpace(64),
        ],
      ),
    );
  }
}
