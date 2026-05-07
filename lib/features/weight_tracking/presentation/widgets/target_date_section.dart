import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';

/// Displays a "TARGET DATE" header and a horizontally scrollable date picker.
class TargetDateSection extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const TargetDateSection({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          onCalendarTap: () => _showDatePicker(context, selectedDate),
        ),
        verticalSpace(16),
        _DateScrollPicker(
          selectedDate: selectedDate,
          onDateSelected: onDateSelected,
        ),
      ],
    );
  }

  Future<void> _showDatePicker(
    BuildContext context,
    DateTime currentDate,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null && context.mounted) {
      onDateSelected(picked);
    }
  }
}

// ── Header ───────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final VoidCallback onCalendarTap;

  const _SectionHeader({required this.onCalendarTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TARGET DATE',
          style: AppTextStyles.font14SemiBoldPrimaryBlue.copyWith(
            color: ColorsManager.darkGray,
          ),
        ),
        GestureDetector(
          onTap: onCalendarTap,
          child: Icon(
            Icons.calendar_month_outlined,
            size: 22.sp,
            color: ColorsManager.darkGray,
          ),
        ),
      ],
    );
  }
}

// ── Horizontal date scroller ─────────────────────────────────────────────────

/// Shows a sliding window of [_visibleDays] days centered on [selectedDate].
/// Tapping any day calls [onDateSelected].
class _DateScrollPicker extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  // Total days to generate around today so the list feels infinite
  static const int _totalDays = 365;

  // How many days before today the list starts
  static const int _pastDays = 30;

  const _DateScrollPicker({
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<_DateScrollPicker> createState() => _DateScrollPickerState();
}

class _DateScrollPickerState extends State<_DateScrollPicker> {
  static const double _itemWidth = 56.0;

  late final ScrollController _controller;
  late final DateTime _startDate;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now().subtract(
      const Duration(days: _DateScrollPicker._pastDays),
    );

    // Pre-scroll so selectedDate is roughly centered.
    final initialOffset = _offsetForDate(widget.selectedDate);
    _controller = ScrollController(initialScrollOffset: initialOffset);
  }

  @override
  void didUpdateWidget(_DateScrollPicker old) {
    super.didUpdateWidget(old);
    // Animate to the new selected date when it changes externally
    // (e.g. the user picks from the calendar dialog).
    if (old.selectedDate != widget.selectedDate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_controller.hasClients) {
          _controller.animateTo(
            _offsetForDate(widget.selectedDate),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Returns the scroll offset that puts [date] in the center of the viewport.
  double _offsetForDate(DateTime date) {
    final daysFromStart = date.difference(_startDate).inDays;
    // Center by subtracting half the approximate viewport width
    final centerOffset = daysFromStart * _itemWidth - (_itemWidth * 2.5);
    return centerOffset.clamp(0.0, double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: _DateScrollPicker._totalDays,
        itemExtent: _itemWidth,
        itemBuilder: (context, index) {
          final date = _startDate.add(Duration(days: index));
          final isSelected = _isSameDay(date, widget.selectedDate);

          return _DateItem(
            date: date,
            isSelected: isSelected,
            onTap: () => widget.onDateSelected(date),
          );
        },
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

// ── Single date cell ──────────────────────────────────────────────────────────

class _DateItem extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const _DateItem({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat('MMM').format(date).toUpperCase();
    final dayLabel = date.day.toString();

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            monthLabel,
            style: AppTextStyles.font10RegularDarkGray.copyWith(
              color: isSelected
                  ? ColorsManager.primaryBlue
                  : ColorsManager.lightGray,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          verticalSpace(4),
          Text(
            dayLabel,
            style: isSelected
                ? AppTextStyles.font24BoldNearBlack.copyWith(
                    color: ColorsManager.primaryBlue,
                    fontWeight: FontWeight.w800,
                  )
                : AppTextStyles.font20BoldVeryDarkGray.copyWith(
                    color: ColorsManager.lightGray,
                  ),
          ),
        ],
      ),
    );
  }
}
