import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';

class EntryListItem extends StatelessWidget {
  final String weight;
  final String date;
  final String diff;
  final bool isDecrease;
  final WeightEntryEntity entry;

  const EntryListItem({
    required this.weight,
    required this.date,
    required this.diff,
    required this.isDecrease,
    required this.entry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final IconData icon = isDecrease ? Icons.trending_down : Icons.trending_up;
    final Color iconBgColor = isDecrease
        ? ColorsManager.lightRed
        : ColorsManager.lightGrayishGreen;
    final Color iconColor = isDecrease
        ? ColorsManager.red
        : ColorsManager.secondaryDark2;
    final Color diffColor = isDecrease
        ? ColorsManager.red
        : ColorsManager.secondaryDark2;

    return Ink(
      decoration: BoxDecoration(
        color: ColorsManager.darkGray2,
        borderRadius: BorderRadius.circular(100.r), // Pill shape
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(100.r),
        onTap: () async {
          await context.pushNamed(Routes.entryEditScreen, arguments: entry);
          if (context.mounted) {
            context.read<WeightTrackingCubit>().loadDashboardData();
          }
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 24.sp),
              ),
              horizontalSpace(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weight, style: AppTextStyles.font16BoldVeryDarkGray),
                  verticalSpace(4),
                  Text(date, style: AppTextStyles.font12RegularGray),
                ],
              ),
              const Spacer(),
              Text(
                diff,
                style: AppTextStyles.font16BoldVeryDarkGray.copyWith(
                  color: diffColor,
                ),
              ),
              horizontalSpace(8),
              Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.nearBlack,
                size: 12.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
