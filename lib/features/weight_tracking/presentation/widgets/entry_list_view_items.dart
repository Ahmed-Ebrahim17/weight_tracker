import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/entry_list_items.dart';

class EntryListViewItems extends StatefulWidget {
  const EntryListViewItems({super.key});

  @override
  State<EntryListViewItems> createState() => _EntryListViewItemsState();
}

class _EntryListViewItemsState extends State<EntryListViewItems> {
  // Mock data for the items
  final List<Map<String, dynamic>> _items = [
    {
      "weight": "164.2 lbs",
      "date": "Today, 8:00 AM",
      "diff": "-0.8 lbs",
      "isDecrease": true,
    },
    {
      "weight": "165.0 lbs",
      "date": "Oct 12, 7:45 AM",
      "diff": "0.0 lbs",
      "isDecrease": false,
    },
    {
      "weight": "165.0 lbs",
      "date": "Oct 5, 8:15 AM",
      "diff": "-1.2 lbs",
      "isDecrease": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => verticalSpace(12),
      itemBuilder: (context, index) {
        final item = _items[index];

        return Dismissible(
          key: Key(item["date"]),
          direction: DismissDirection.horizontal, // Swipe both ways
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Swipe Right -> Edit
              // TODO: Navigate to Edit screen or show bottom sheet
              return false; // Don't actually dismiss the widget
            } else if (direction == DismissDirection.endToStart) {
              // Swipe Left -> Delete
              return true; // Proceed with dismissal
            }
            return false;
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              setState(() {
                _items.removeAt(index);
              });
              // TODO: Call Cubit to delete item from database here
            }
          },
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: ColorsManager.primaryDeepBlue,
              borderRadius: BorderRadius.circular(100.r), // Match pill shape
            ),
            child: Icon(Icons.edit_outlined, color: Colors.white, size: 28.sp),
          ),
          secondaryBackground: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(100.r), // Match pill shape
            ),
            child: Icon(Icons.delete_outline, color: Colors.white, size: 28.sp),
          ),
          child: EntryListItem(
            weight: item["weight"],
            date: item["date"],
            diff: item["diff"],
            isDecrease: item["isDecrease"],
          ),
        );
      },
    );
  }
}
