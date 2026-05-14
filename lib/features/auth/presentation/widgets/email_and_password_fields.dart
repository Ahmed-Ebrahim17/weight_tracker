import 'package:flutter/material.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/email_address_textfield.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/password_textfield.dart';

import '../../../../core/helper/spacing.dart';

class EmailAndPasswordFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const EmailAndPasswordFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailAddressTextField(controller: emailController),
        verticalSpace(24),
        PasswordTextField(controller: passwordController),
      ],
    );
  }
}
