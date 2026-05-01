import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/assets.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';

class GoogleAndAppleButtons extends StatelessWidget {
  const GoogleAndAppleButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppTextButton(
            onPressed: () {
              context.read<AuthCubit>().loginWithGoogle();
            },
            backgroundColor: ColorsManager.background,
            shadowColor: Colors.transparent,
            borderRadius: 32,
            buttonHeight: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.googleLogo, height: 24, width: 24),
                horizontalSpace(8),
                Text(
                  AppStrings.google,
                  style: AppTextStyles.font14BoldSemiBold,
                ),
              ],
            ),
          ),
        ),
        horizontalSpace(16),
        Expanded(
          child: AppTextButton(
            onPressed: () {},
            backgroundColor: ColorsManager.darkLightGray,
            shadowColor: Colors.transparent,
            borderRadius: 32,
            buttonHeight: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.appleLogo, height: 24, width: 24),
                horizontalSpace(8),
                Text(AppStrings.apple, style: AppTextStyles.font14BoldSemiBold),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
