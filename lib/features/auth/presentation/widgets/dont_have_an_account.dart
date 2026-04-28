import 'package:flutter/material.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.noAccount,
          style: AppTextStyles.font14RegularNearBlack,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
            AppStrings.signUp,
            style: AppTextStyles.font14BoldOnPrimary.copyWith(color: ColorsManager.primaryBlue),
          ),
          onPressed: () {
            context.pushNamed(Routes.registerScreen);
          },
        ),
      ],
    );
  }
}
