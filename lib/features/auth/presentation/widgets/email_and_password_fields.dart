import 'package:flutter/material.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/email_address_textfield.dart';
import 'package:weight_tracker/features/auth/presentation/widgets/password_textfield.dart';

import '../../../../core/helper/spacing.dart';

class EmailAndPasswordFields extends StatelessWidget {
  const EmailAndPasswordFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailAddressTextField(),
        verticalSpace(24),
        PasswordTextField(),
      ],
    );
  }
}
