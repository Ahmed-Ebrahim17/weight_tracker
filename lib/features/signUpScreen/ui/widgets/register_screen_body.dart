import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/signUpScreen/ui/widgets/already_have_account.dart';
import 'package:weight_tracker/features/signUpScreen/ui/widgets/app_logo_with_register_screen_header.dart';
import 'package:weight_tracker/features/signUpScreen/ui/widgets/name_email_and_password_fields.dart';
import 'package:weight_tracker/features/signUpScreen/ui/widgets/or_continue_with_divider.dart';
import 'package:weight_tracker/features/signUpScreen/ui/widgets/terms_and_conditions.dart';

import '../../../../core/theming/styles.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24.w,
        left: 24.w,
        bottom: 32.h,
        top: MediaQuery.of(context).size.height * 0.08,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: AppLogoWithRegisterScreenHeader()),
            verticalSpace(32),
            NameEmailAndPasswordFields(),
            verticalSpace(32),
            AppTextButton(
              onPressed: () {},
              buttonHeight: 60,
              borderRadius: 48,
              child: Text(AppStrings.createAccount, style: AppTextStyles.font18BoldOnPrimary),
            ),
            verticalSpace(32),
            OrContinueWithDivider(),
            verticalSpace(24),
            TermsAndConditions(),
            verticalSpace(16),
            AlreadyHaveAccount(),
          ],
        ),
      ),
    );
  }
}