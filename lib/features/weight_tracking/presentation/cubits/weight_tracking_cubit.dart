import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_tracker/core/error/failure.dart' as failures;
import 'package:weight_tracker/features/weight_tracking/domain/usecases/add_weight_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/delete_weight_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_entries_last_n_days_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_latest_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_total_entries_count_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_trend_last_n_days_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/update_weight_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/presentation/cubits/weight_tracking_state.dart';

class WeightTrackingCubit extends Cubit<WeightTrackingState> {
  final AddWeightEntryUseCase addWeightEntryUseCase;
  final GetLatestEntryUseCase getLatestEntryUseCase;
  final GetEntriesLastNDaysUseCase getEntriesLastNDaysUseCase;
  final GetTotalEntriesCountUseCase getTotalEntriesCountUseCase;
  final GetTrendLastNDaysUseCase getTrendLastNDaysUseCase;
  final UpdateWeightEntryUseCase updateWeightEntryUseCase;
  final DeleteWeightEntryUseCase deleteWeightEntryUseCase;

  WeightTrackingCubit({
    required this.addWeightEntryUseCase,
    required this.getLatestEntryUseCase,
    required this.getEntriesLastNDaysUseCase,
    required this.getTotalEntriesCountUseCase,
    required this.getTrendLastNDaysUseCase,
    required this.updateWeightEntryUseCase,
    required this.deleteWeightEntryUseCase,
  }) : super(const WeightTrackingInitial());

  /// Loads all dashboard data: latest weight, 7-day trend, total count, recent entries.
  Future<void> loadDashboardData() async {
    emit(const WeightTrackingLoading());

    final latestResult = await getLatestEntryUseCase();
    final trendResult = await getTrendLastNDaysUseCase(7);
    final countResult = await getTotalEntriesCountUseCase();
    final recentResult = await getEntriesLastNDaysUseCase(7);

    // If any critical call fails, emit error
    final latestFailed = latestResult.isLeft();
    final recentFailed = recentResult.isLeft();

    if (latestFailed && recentFailed) {
      emit(const WeightTrackingError('Failed to load weight data.'));
      return;
    }

    final latestWeight = latestResult.fold(
      (_) => null,
      (entry) => entry?.weight,
    );

    final sevenDayTrend = trendResult.fold((_) => null, (trend) => trend);

    final totalEntries = countResult.fold((_) => 0, (count) => count);

    final recentEntries = recentResult.fold(
      (_) => <dynamic>[],
      (entries) => entries,
    );

    emit(
      WeightTrackingLoaded(
        latestWeight: latestWeight,
        sevenDayTrend: sevenDayTrend,
        totalEntries: totalEntries,
        recentEntries: recentEntries.cast(),
      ),
    );
  }

  /// Adds a new weight entry and reloads dashboard data.
  Future<void> addWeightEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) async {
    final result = await addWeightEntryUseCase(
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );

    result.fold(
      (failure) => emit(WeightTrackingError(_mapFailureToMessage(failure))),
      (_) => loadDashboardData(),
    );
  }

  /// Updates an existing entry and reloads dashboard data.
  Future<void> updateWeightEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) async {
    final result = await updateWeightEntryUseCase(
      id: id,
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );

    result.fold(
      (failure) => emit(WeightTrackingError(_mapFailureToMessage(failure))),
      (_) => loadDashboardData(),
    );
  }

  /// Deletes an entry by ID and reloads dashboard data.
  Future<void> deleteWeightEntry(int id) async {
    final result = await deleteWeightEntryUseCase(id);

    result.fold(
      (failure) => emit(WeightTrackingError(_mapFailureToMessage(failure))),
      (_) => loadDashboardData(),
    );
  }

  String _mapFailureToMessage(failures.Failure failure) {
    return switch (failure) {
      failures.NetworkFailure() => 'No internet connection.',
      failures.ValidationFailure() => failure.message,
      failures.AuthFailure() => failure.message,
      failures.ServerFailure() => 'Server error. Please try again.',
      failures.UnknownFailure() =>
        failure.message.isEmpty ? 'Something went wrong.' : failure.message,
    };
  }
}
