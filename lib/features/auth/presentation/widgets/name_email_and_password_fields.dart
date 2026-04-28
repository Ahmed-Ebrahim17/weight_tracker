import 'package:flutter/material.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/email_address_textfield.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/full_name_textfield.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/password_textfield.dart';

import '../../../../core/helper/spacing.dart';

class NameEmailAndPasswordFields extends StatelessWidget {
  const NameEmailAndPasswordFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FullNameTextField(),
        verticalSpace(24),
        EmailAddressTextField(),
        verticalSpace(24),
        PasswordTextField(),
      ],
    );
  }
}
