import 'package:flutter/material.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.haveAccount,
          style: AppTextStyles.font14RegularNearBlack,
        ),
        TextButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          child: Text(
            AppStrings.login,
            style: AppTextStyles.font14BoldOnPrimary.copyWith(color: ColorsManager.secondaryDark2),
          ),
          onPressed: () {
            context.pushNamed(Routes.loginScreen);
          },
        ),
      ],
    );
  }
}
