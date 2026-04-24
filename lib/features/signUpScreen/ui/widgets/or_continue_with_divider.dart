import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/colors.dart';


class OrContinueWithDivider extends StatelessWidget {
  const OrContinueWithDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(height: 1, color: ColorsManager.lightGray)),
      ],
    );
  }
}
