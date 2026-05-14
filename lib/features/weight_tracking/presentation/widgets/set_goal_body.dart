import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/helper/spacing.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/choose_goal.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/loading_goal_view.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/save_goal_button.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/target_date_section.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/target_weight_card.dart';

class SetGoalBody extends StatefulWidget {
  const SetGoalBody({super.key});

  @override
  State<SetGoalBody> createState() => _SetGoalBodyState();
}

class _SetGoalBodyState extends State<SetGoalBody> {
  String _selectedGoal = 'Lose';
  double _currentWeight = 165.0;
  double _targetWeight = 165.0;
  DateTime _targetDate = DateTime.now().add(const Duration(days: 30));
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData(context.read<WeightTrackingCubit>().state);
  }

  void _initializeData(WeightTrackingState state) {
    if (state is WeightTrackingLoaded && !_isInitialized) {
      setState(() {
        _currentWeight = state.latestWeight ?? 165.0;
        // If there's no target weight yet, set it to the current weight initially
        _targetWeight = state.targetWeight ?? _currentWeight;

        if (state.goalType != null) {
          _selectedGoal = state.goalType!;
        }
        if (state.targetDate != null) {
          _targetDate = state.targetDate!;
        }
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightTrackingCubit, WeightTrackingState>(
      builder: (context, state) {
        if (state is WeightTrackingLoading || state is WeightTrackingInitial) {
          return const LoadingGoalView();
        }
        return BlocListener<WeightTrackingCubit, WeightTrackingState>(
          listener: (context, state) => _initializeData(state),
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChooseGoal(
                    selectedGoal: _selectedGoal,
                    onGoalSelected: (goal) {
                      setState(() {
                        _selectedGoal = goal;
                      });
                    },
                  ),
                  verticalSpace(28),
                  TargetWeightCard(
                    currentWeight: _currentWeight,
                    targetWeight: _targetWeight,
                    onTargetWeightChanged: (weight) {
                      setState(() {
                        _targetWeight = weight;
                      });
                    },
                  ),
                  verticalSpace(24),
                  TargetDateSection(
                    selectedDate: _targetDate,
                    onDateSelected: (date) {
                      setState(() {
                        _targetDate = date;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SaveGoalButton(
            targetWeight: _targetWeight,
            targetDate: _targetDate,
            selectedGoal: _selectedGoal,
          ),
        ],
          ),
        );
      },
    );
  }
}
