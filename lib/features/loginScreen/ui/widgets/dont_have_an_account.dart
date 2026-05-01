import 'package:flutter/material.dart';

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
          'Don\'t have an account? ',
          style: AppTextStyles.font14RegularNearBlack,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Sign Up',
            style: AppTextStyles.font14BoldOnPrimary.copyWith(
              color: ColorsManager.primaryBlue,
            ),
          ),
        ),
      ],
    );
  }
}
