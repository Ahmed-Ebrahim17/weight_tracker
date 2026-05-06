import 'package:flutter/material.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/entry_list_view_items.dart';

class RecentEntriesSection extends StatelessWidget {
  const RecentEntriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Entries", style: AppTextStyles.font16BoldVeryDarkGray),
            TextButton(
              onPressed: () {},
              child: Text(
                "View All",
                style: AppTextStyles.font10BoldlightGray.copyWith(
                  color: ColorsManager.primaryBlue,
                ),
              ),
            ),
          ],
        ),
        EntryListViewItems(),
      ],
    );
  }
}
