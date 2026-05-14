import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorsManager.moreLighterGray, width: 1),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
