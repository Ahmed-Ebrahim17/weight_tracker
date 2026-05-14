import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class SettingsSegmentTile extends StatelessWidget {
  const SettingsSegmentTile({
    super.key,
    required this.icon,
    required this.title,
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  final IconData icon;
  final String title;
  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Icon(icon, color: ColorsManager.darkGray, size: 22.w),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(title, style: AppTextStyles.font16RegularNearBlack),
          ),
          _SegmentedControl(
            options: options,
            selectedIndex: selectedIndex,
            onSelected: onSelected,
          ),
        ],
      ),
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.options,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> options;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      decoration: BoxDecoration(
        color: ColorsManager.lightGrayishGreen,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? ColorsManager.secondary : Colors.transparent,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                options[index],
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : ColorsManager.darkGray,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
