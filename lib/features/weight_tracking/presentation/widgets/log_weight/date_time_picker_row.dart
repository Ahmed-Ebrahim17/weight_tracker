import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

class DateTimePickerRow extends StatelessWidget {
  const DateTimePickerRow({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTap,
    required this.onTimeTap,
  });

  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DATE & TIME',
          style: AppTextStyles.font12BoldNearBlack.copyWith(
            color: ColorsManager.gray6E7979,
            letterSpacing: 1.2,
          ),
        ),
        verticalSpace(16),
        Row(
          children: [
            Expanded(
              child: _DateTimePickerCard(
                icon: Icons.calendar_today_outlined,
                text: _formatDate(selectedDate),
                onTap: onDateTap,
              ),
            ),
            horizontalSpace(16),
            Expanded(
              child: _DateTimePickerCard(
                icon: Icons.access_time_outlined,
                text: _formatTime(selectedTime),
                onTap: onTimeTap,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DateTimePickerCard extends StatelessWidget {
  const _DateTimePickerCard({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: ColorsManager.darkLightGray,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: ColorsManager.primaryBlueDark1, size: 18.sp),
            horizontalSpace(8),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.font14RegularNearBlack.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
