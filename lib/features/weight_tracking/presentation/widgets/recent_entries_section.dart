import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/helper/extensions.dart';
import 'package:weight_tracker/core/routing/routes.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/entry_list_view_items.dart';

class RecentEntriesSection extends StatelessWidget {
  final List<WeightEntryEntity> weightEntries;

  const RecentEntriesSection({super.key, required this.weightEntries});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Entries", style: AppTextStyles.font16BoldVeryDarkGray),
            TextButton(
              onPressed: () {
                context.pushNamed(Routes.sevenDaysTrend);
                if (context.mounted) {
                  context.read<WeightTrackingCubit>().loadDashboardData();
                }
              },
              child: Text(
                "View All",
                style: AppTextStyles.font10BoldlightGray.copyWith(
                  color: ColorsManager.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        EntryListViewItems(weightEntries: weightEntries),
      ],
    );
  }
}
