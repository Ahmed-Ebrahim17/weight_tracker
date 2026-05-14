import 'package:flutter/material.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';

class LogWeightBottomActions extends StatelessWidget {
  const LogWeightBottomActions({super.key, required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextButton(
          onPressed: onSave,
          buttonHeight: 52,
          borderRadius: 30,
          child: Text(
            'Save Entry',
            style: AppTextStyles.font18BoldOnPrimary.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        verticalSpace(16),
        Center(
          child: Text(
            'DATA IS STORED LOCALLY ON THIS DEVICE',
            style: AppTextStyles.font10BoldlightGray.copyWith(
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}
