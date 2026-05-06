import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_cubit.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/dashboard_loaded_view.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/error_dashboard_view.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/widgets/loading_dashboard_view.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightTrackingCubit, WeightTrackingState>(
      builder: (context, state) {
        return switch (state) {
          WeightTrackingInitial() => const LoadingDashBoardView(),
          WeightTrackingLoading() => const LoadingDashBoardView(),
          WeightTrackingError(:final message) => ErrorDashboardView(
            message: message,
          ),
          WeightTrackingLoaded() => DashboardLoadedView(state: state),
        };
      },
    );
  }
}
