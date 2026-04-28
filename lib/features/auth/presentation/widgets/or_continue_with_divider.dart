import 'package:flutter/material.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/theming/colors.dart';

import '../../../../core/theming/styles.dart';

class OrContinueWithDivider extends StatelessWidget {
  const OrContinueWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(height: 1, color: ColorsManager.lightGray)),
        Text(AppStrings.or, style: AppTextStyles.font10BoldlightGray),
        Expanded(child: Divider(height: 1, color: ColorsManager.lightGray)),
      ],
    );
  }
}
