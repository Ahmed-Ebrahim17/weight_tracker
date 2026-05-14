import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';

class DailyBreakdownSection extends StatelessWidget {
  const DailyBreakdownSection({required this.entries, super.key});

  final List<WeightEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.dailyBreakdown,
          style: AppTextStyles.font18BoldVeryDarkGray,
        ),
        verticalSpace(16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: entries.length,
          separatorBuilder: (_, _) => Divider(
            color: ColorsManager.lightGray.withValues(alpha: 0.3),
            height: 1,
          ),
          itemBuilder: (context, index) {
            final entry = entries[index];
            final previousEntry =
                index + 1 < entries.length ? entries[index + 1] : null;
            return _DailyBreakdownItem(
              entry: entry,
              previousEntry: previousEntry,
            );
          },
        ),
      ],
    );
  }
}

// ─── Single day row ──────────────────────────────────────────────────────────

class _DailyBreakdownItem extends StatelessWidget {
  const _DailyBreakdownItem({
    required this.entry,
    this.previousEntry,
  });

  final WeightEntryEntity entry;
  final WeightEntryEntity? previousEntry;

  @override
  Widget build(BuildContext context) {
    final dayName = DateFormat('EEE').format(entry.date).toUpperCase();
    final ({Color color, IconData icon}) trend = _resolveTrend();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          SizedBox(
            width: 40.w,
            child: Text(
              dayName,
              style: AppTextStyles.font12BoldNearBlack.copyWith(
                color: ColorsManager.primaryBlue,
                letterSpacing: 0.5,
              ),
            ),
          ),
          horizontalSpace(16),
          Text(
            '${entry.weight.toStringAsFixed(1)} ${AppStrings.units}',
            style: AppTextStyles.font16BoldVeryDarkGray,
          ),
          const Spacer(),
          Icon(trend.icon, color: trend.color, size: 22.sp),
        ],
      ),
    );
  }

  ({Color color, IconData icon}) _resolveTrend() {
    if (previousEntry == null) {
      return (color: ColorsManager.darkGray, icon: Icons.trending_flat_rounded);
    }
    if (entry.weight < previousEntry!.weight) {
      return (
        color: ColorsManager.secondaryDark2,
        icon: Icons.trending_down_rounded,
      );
    }
    if (entry.weight > previousEntry!.weight) {
      return (color: ColorsManager.red, icon: Icons.trending_up_rounded);
    }
    return (color: ColorsManager.darkGray, icon: Icons.trending_flat_rounded);
  }
}
