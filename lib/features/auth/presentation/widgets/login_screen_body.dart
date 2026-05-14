import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/app_logo_with_login_scren_header.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/dont_have_an_account.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/email_and_password_fields.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/google_and_apple_buttons.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/login_bloc_listener.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/or_continue_with_divider.dart';

import '../../../../core/theming/styles.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 24.w,
        left: 24.w,
        bottom: 64.h,
        top: MediaQuery.of(context).size.height * 0.11,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: AppLogoWithLoginScreenHeader()),
            verticalSpace(32),
            EmailAndPasswordFields(
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            verticalSpace(32),
            AppTextButton(
              onPressed: () {
                _validateThenDoLogin();
              },
              buttonHeight: 60,
              borderRadius: 48,
              child: Text(
                AppStrings.login,
                style: AppTextStyles.font18BoldOnPrimary,
              ),
            ),
            verticalSpace(32),
            OrContinueWithDivider(),
            verticalSpace(24),
            GoogleAndAppleButtons(),
            verticalSpace(32),
            DontHaveAnAccount(),
            LoginBlocListener(),
          ],
        ),
      ),
    );
  }

  void _validateThenDoLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().loginWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }
}
