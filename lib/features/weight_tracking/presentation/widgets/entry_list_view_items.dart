import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/entry_list_items.dart';

class EntryListViewItems extends StatelessWidget {
  final List<WeightEntryEntity> weightEntries;

  const EntryListViewItems({super.key, required this.weightEntries});

  @override
  Widget build(BuildContext context) {
    final displayEntries = weightEntries.take(3).toList();

    return ListView.separated(
      itemCount: displayEntries.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        final entry = displayEntries[index];

        String diffText = "0.0 lbs";
        bool isDecrease = false;

        if (index + 1 < weightEntries.length) {
          final previousEntry = weightEntries[index + 1];
          final diff = entry.weight - previousEntry.weight;
          isDecrease = diff < 0;
          diffText = "${diff >= 0 ? '+' : ''}${diff.toStringAsFixed(1)} lbs";
        }

        final String formattedDate = _getFormattedDate(entry.dateTime);

        return EntryListItem(
          weight: "${entry.weight.toStringAsFixed(1)} lbs",
          date: formattedDate,
          diff: diffText,
          isDecrease: isDecrease,
          entry: entry,
        );
      },
    );
  }

  String _getFormattedDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final entryDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (entryDate == today) {
      return "Today, ${DateFormat('h:mm a').format(dateTime)}";
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }
}
