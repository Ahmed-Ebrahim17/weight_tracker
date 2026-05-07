import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/constants/app_strings.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/core/theming/colors.dart';
import 'package:weight_tracker/core/theming/styles.dart';
import 'package:weight_tracker/core/widgets/app_text_button.dart';
import 'package:weight_tracker/core/widgets/app_text_field.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/delete_entry_bottom_sheet.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/log_weight/weight_input_card.dart';

class EntryEditScreenBody extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController notesController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;
  final WeightEntryEntity entry;

  const EntryEditScreenBody({
    super.key,
    required this.weightController,
    required this.notesController,
    required this.dateController,
    required this.timeController,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTap,
    required this.onTimeTap,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeightTrackingCubit, WeightTrackingState>(
      listener: (context, state) {
        if (state is WeightTrackingLoaded) {
          Navigator.pop(context);
        } else if (state is WeightTrackingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    WeightInputCard(
                      controller: weightController,
                      label: AppStrings.currentWeight,
                    ),
                    verticalSpace(32),
                    _buildLabel(AppStrings.date),
                    verticalSpace(8),
                    AppTextFormField(
                      hintText: '',
                      controller: dateController,
                      readOnly: true,
                      onTap: onDateTap,
                      prefixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        color: ColorsManager.primaryBlue,
                      ),
                      validator: (v) => null,
                    ),
                    verticalSpace(20),
                    _buildLabel(AppStrings.time),
                    verticalSpace(8),
                    AppTextFormField(
                      hintText: '',
                      controller: timeController,
                      readOnly: true,
                      onTap: onTimeTap,
                      prefixIcon: const Icon(
                        Icons.access_time_outlined,
                        color: ColorsManager.primaryBlue,
                      ),
                      validator: (v) => null,
                    ),
                    verticalSpace(20),
                    _buildLabel(AppStrings.notesOptional),
                    verticalSpace(8),
                    AppTextFormField(
                      hintText: AppStrings.addNotesHint,
                      controller: notesController,
                      foucsedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: ColorsManager.primaryDeepBlue,
                          width: 2.w,
                        ),
                      ),
                      maxLines: 4,
                      validator: (v) => null,
                    ),
                    verticalSpace(40),
                    AppTextButton(
                      buttonHeight: 60.h,
                      borderRadius: 100.r,
                      onPressed: () {
                        final weight = double.tryParse(weightController.text);
                        if (weight != null) {
                          final dateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                          context.read<WeightTrackingCubit>().updateWeightEntry(
                            id: entry.id,
                            weight: weight,
                            date: selectedDate,
                            time: dateTime,
                            notes: notesController.text.trim().isEmpty
                                ? null
                                : notesController.text.trim(),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: ColorsManager.onPrimary,
                            size: 20.sp,
                          ),
                          horizontalSpace(8),
                          Text(
                            AppStrings.saveChanges,
                            style: AppTextStyles.font16BoldOnPrimary,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(24),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (bottomSheetContext) =>
                                DeleteEntryBottomSheet(
                              onDelete: () {
                                context
                                    .read<WeightTrackingCubit>()
                                    .deleteWeightEntry(entry.id);
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: ColorsManager.red,
                          size: 20.sp,
                        ),
                        label: Text(
                          AppStrings.deleteEntry,
                          style: AppTextStyles.font16BoldOnPrimary.copyWith(
                            color: ColorsManager.red,
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.font14BoldOVeryDarkGray.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
