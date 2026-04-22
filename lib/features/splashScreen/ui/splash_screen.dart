import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/splashScreen/ui/widgets/app_logo_with_kinetic_sanctuary.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              onpressed: () => context.pushNamed(Routes.loginScreen),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ENTER THE FLOW", style: AppTextStyles.font14Bold),
                  horizentalSpace(16),
                  Icon(Icons.arrow_forward, color: ColorsManager.onPrimary),
                ],
              ),
            ),
            verticalSpace(64),
          ],
        ),
      ),
    );
  }
}
