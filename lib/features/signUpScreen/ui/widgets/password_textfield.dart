import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/widgets/app_text_field.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.password.toUpperCase(),
          style: AppTextStyles.font12BoldNearBlack,
        ),
        verticalSpace(8),
        AppTextFormField(
          inputTextStyle: AppTextStyles.font16RegularNearBlack,
          backgroundColor: ColorsManager.veryLightGray,
          hintText: AppStrings.enterPasswordHint,
          hintStyle: AppTextStyles.font16RegularLightGray,
          isObscureText: _isObscure,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: ColorsManager.neutral,
            size: 22.sp,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            child: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: ColorsManager.neutral,
              size: 22.sp,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(25),
          ),
          foucsedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorsManager.primaryBlue,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppStrings.passwordRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
