import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';

class TrendHeader extends StatelessWidget {
  const TrendHeader({
    required this.sevenDayTrend,
    required this.entries,
    super.key,
  });

  final double? sevenDayTrend;
  final List<WeightEntryEntity> entries;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.weightFluctuation,
                style: AppTextStyles.font24BoldNearBlack,
              ),
              verticalSpace(4),
              Text(
                _formatDateRange(),
                style: AppTextStyles.font12RegularGray,
              ),
            ],
          ),
        ),
        _TrendBadge(sevenDayTrend: sevenDayTrend),
      ],
    );
  }

  String _formatDateRange() {
    if (entries.isEmpty) return '';
    final formatter = DateFormat('MMM dd');
    return '${formatter.format(entries.last.date)} - ${formatter.format(entries.first.date)}';
  }
}

// ─── Private sub-widgets ─────────────────────────────────────────────────────

class _TrendBadge extends StatelessWidget {
  const _TrendBadge({required this.sevenDayTrend});

  final double? sevenDayTrend;

  @override
  Widget build(BuildContext context) {
    if (sevenDayTrend == null) return const SizedBox.shrink();

    final sign = sevenDayTrend! > 0 ? '+' : '';
    final color = sevenDayTrend! <= 0
        ? ColorsManager.primaryBlue
        : ColorsManager.tertiaryDark1;

    return Padding(
      padding: EdgeInsets.only(top: 36.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '$sign${sevenDayTrend!.toStringAsFixed(1)}',
            style: AppTextStyles.font30ExtraBoldNearBlack.copyWith(
              color: color,
            ),
          ),
          horizontalSpace(4),
          Text(
            AppStrings.units,
            style: AppTextStyles.font14RegularDarkGray.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
