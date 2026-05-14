import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 56.w, right: 16.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: ColorsManager.moreLighterGray,
      ),
    );
  }
}
