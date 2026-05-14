import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/already_have_account.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/app_logo_with_register_screen_header.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/name_email_and_password_fields.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/or_continue_with_divider.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/register_bloc_listener.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/terms_and_conditions.dart';

import '../../../../core/theming/styles.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({super.key});

  @override
  State<RegisterScreenBody> createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
        bottom: 32.h,
        top: MediaQuery.of(context).size.height * 0.08,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: AppLogoWithRegisterScreenHeader()),
              verticalSpace(32),
              NameEmailAndPasswordFields(
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              verticalSpace(32),
              AppTextButton(
                onPressed: () {
                  _validateThenDoSignup();
                },
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
              RegisterBlocListener(),
            ],
          ),
        ),
      ),
    );
  }

  void _validateThenDoSignup() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().registerWithEmail(
            email: _emailController.text,
            password: _passwordController.text,
            fullName: _nameController.text,
          );
    }
  }
}
