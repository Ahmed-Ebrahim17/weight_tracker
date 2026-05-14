import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class SettingsNavTile extends StatelessWidget {
  const SettingsNavTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.onTap,
    this.iconBackgroundColor,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final VoidCallback? onTap;
  final Color? iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            if (iconBackgroundColor != null)
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: Colors.white, size: 20.w),
              )
            else
              Icon(icon, color: ColorsManager.darkGray, size: 22.w),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(title, style: AppTextStyles.font16RegularNearBlack),
            ),
            if (trailingText != null)
              Text(
                trailingText!,
                style: AppTextStyles.font14RegularDarkGray,
              ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: ColorsManager.lightGray, size: 20.w),
          ],
        ),
      ),
    );
  }
}
