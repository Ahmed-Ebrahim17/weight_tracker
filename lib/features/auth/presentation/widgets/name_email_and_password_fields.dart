import 'package:flutter/material.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/email_address_textfield.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/full_name_textfield.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/password_textfield.dart';

import '../../../../core/helper/spacing.dart';

class NameEmailAndPasswordFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const NameEmailAndPasswordFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullNameTextField(controller: nameController),
        verticalSpace(24),
        EmailAddressTextField(controller: emailController),
        verticalSpace(24),
        PasswordTextField(controller: passwordController),
      ],
    );
  }
}
