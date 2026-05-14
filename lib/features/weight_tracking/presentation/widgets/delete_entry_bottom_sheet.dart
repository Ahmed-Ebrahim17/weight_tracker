import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';

class DeleteEntryBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteEntryBottomSheet({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ColorsManager.lightGray,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          verticalSpace(24),
          // Title
          Text(
            AppStrings.deleteEntryQuestion,
            style: AppTextStyles.font24BoldNearBlack,
            textAlign: TextAlign.center,
          ),
          verticalSpace(12),
          // Message
          Text(
            AppStrings.deleteEntryWarning,
            style: AppTextStyles.font14RegularDarkGray,
            textAlign: TextAlign.center,
          ),
          verticalSpace(24),
          // Actions
          AppTextButton(
            backgroundColor: ColorsManager.red,
            onPressed: () {
              Navigator.pop(context);
              onDelete();
            },
            child: Text(
              AppStrings.delete,
              style: AppTextStyles.font16BoldOnPrimary,
            ),
          ),
          verticalSpace(12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
            ),
            child: Text(
              AppStrings.cancel,
              style: AppTextStyles.font16BoldVeryDarkGray.copyWith(
                color: ColorsManager.secondaryGray,
              ),
            ),
          ),
          verticalSpace(12),
        ],
      ),
    );
  }
}
