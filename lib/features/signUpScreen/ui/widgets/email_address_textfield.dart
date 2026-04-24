import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/widgets/app_text_field.dart';

import '../../../../core/helper/spacing.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class EmailAddressTextField extends StatelessWidget {
  const EmailAddressTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.email.toUpperCase(),
          style: AppTextStyles.font12BoldNearBlack,
        ),
        verticalSpace(8),
        AppTextFormField(
          inputTextStyle: AppTextStyles.font16RegularNearBlack,
          backgroundColor: ColorsManager.veryLightGray,
          hintText: AppStrings.enterEmailHint,
          hintStyle: AppTextStyles.font16RegularLightGray,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: ColorsManager.neutral,
            size: 22.sp,
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
              return AppStrings.emailRequired;
            }
            return null;
          },
        ),
      ],
    );
  }
}
