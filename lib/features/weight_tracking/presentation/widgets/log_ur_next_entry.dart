import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';

class LogYourNextEntry extends StatelessWidget {
  const LogYourNextEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorsManager.lightGray3,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tips_and_updates_outlined,
                size: 28.sp,
                color: ColorsManager.darkOrange,
              ),
              verticalSpace(8),
              Text(
                "Log your next entry to see your trend!",
                style: AppTextStyles.font14RegularNearBlack,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        verticalSpace(12),

        AppTextButton(
          onPressed: () {
            context.pushNamed(Routes.addWeightScreen);
          },
          backgroundColor: ColorsManager.primaryDeepBlue,
          borderRadius: 26.r,
          buttonHeight: 52.h,
          buttonWidth: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: ColorsManager.onPrimary, size: 20.sp),
              horizontalSpace(4),
              Text("Log Weight", style: AppTextStyles.font16BoldOnPrimary),
            ],
          ),
        ),
      ],
    );
  }
}
