import 'package:flutter/material.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class WeightLabel extends StatelessWidget {
  final String label;
  final String value;
  final CrossAxisAlignment crossAxisAlignment;

  const WeightLabel({
    super.key,
    required this.label,
    required this.value,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTextStyles.font10RegularDarkGray),
        verticalSpace(2),
        Text(value, style: AppTextStyles.font14BoldOVeryDarkGray),
      ],
    );
  }
}
