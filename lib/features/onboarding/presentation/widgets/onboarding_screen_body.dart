import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart' show Routes;
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_state.dart';
import 'package:weight_tracker/features/onboarding/presentation/widgets/app_logo_with_kinetic_sanctuary.dart';

class OnboardingScreenBody extends StatelessWidget {
  const OnboardingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        children: [
          verticalSpace(24.h),
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: const AppLogoWithKineticSanctuary(),
              ),
            ),
          ),
          verticalSpace(24.h),
          AppTextButton(
            borderRadius: 50,
            buttonHeight: 60,
            onPressed: () {
              if (authCubit.currentUser != null) {
                Navigator.of(
                  context,
                ).pushReplacementNamed(Routes.dashboardScreen);
              } else {
                Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.enterTheFlow,
                  style: AppTextStyles.font14BoldOnPrimary,
                ),
                horizontalSpace(16),
                Icon(Icons.arrow_forward, color: ColorsManager.onPrimary),
              ],
            ),
          ),
          verticalSpace(32.h),
        ],
      ),
    );
  }
}
