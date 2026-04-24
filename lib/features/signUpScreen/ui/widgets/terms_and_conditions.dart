import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'By creating an account, you agree to our ',
            style: AppTextStyles.font12RegularGray,
          ),
          TextSpan(
            text: 'Terms of Service',
            style: AppTextStyles.font12RegularGray.copyWith(
              color: ColorsManager.primaryBlue,
            ),
          ),
          TextSpan(
            text: ' and ',
            style: AppTextStyles.font12RegularGray,
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: AppTextStyles.font12RegularGray.copyWith(
              color: ColorsManager.primaryBlue,
            ),
          ),
          TextSpan(
            text: '.',
            style: AppTextStyles.font12RegularGray,
          ),
        ],
      ),
    );
  }
}
