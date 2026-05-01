import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight/date_time_picker_row.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight/log_weight_bottom_actions.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight/weight_input_card.dart';

class LogWeightSection extends StatefulWidget {
  const LogWeightSection({super.key});

  @override
  State<LogWeightSection> createState() => _LogWeightSectionState();
}

class _LogWeightSectionState extends State<LogWeightSection> {
  final TextEditingController _weightController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _onSave() {
    final weightText = _weightController.text.trim();
    final weight = double.tryParse(weightText);

    if (weight == null || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid weight.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    context.read<WeightTrackingCubit>().addWeightEntry(
          weight: weight,
          date: _selectedDate,
          time: dateTime,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeightTrackingCubit, WeightTrackingState>(
      listener: _handleStateChange,
      child: Scaffold(
        backgroundColor: ColorsManager.surface,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildContent()),
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    child: LogWeightBottomActions(onSave: _onSave),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateChange(BuildContext context, WeightTrackingState state) {
    switch (state) {
      case WeightTrackingLoaded():
        // Entry saved successfully — go back to dashboard.
        Navigator.of(context).pop();
      case WeightTrackingError(:final message):
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            behavior: SnackBarBehavior.floating,
          ),
        );
      case _:
        break;
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: ColorsManager.surface,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: ColorsManager.nearBlack),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'KINETIC',
        style: AppTextStyles.font14SemiBoldPrimaryBlue.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Log Weight', style: AppTextStyles.font32BoldNearBlack),
          verticalSpace(8),
          Text(
            'Enter your current weight to track your progress.',
            style: AppTextStyles.font14RegularDarkGray,
          ),
          verticalSpace(40),
          WeightInputCard(controller: _weightController),
          verticalSpace(40),
          DateTimePickerRow(
            selectedDate: _selectedDate,
            selectedTime: _selectedTime,
            onDateTap: _pickDate,
            onTimeTap: _pickTime,
          ),
          verticalSpace(16),
        ],
      ),
    );
  }
}
