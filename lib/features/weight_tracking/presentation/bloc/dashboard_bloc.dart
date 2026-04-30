import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_latest_entry_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_last_n_days_entries_usecase.dart';
import 'package:weight_tracker/features/weight_tracking/domain/usecases/get_seven_day_trend_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetLatestEntryUsecase _getLatestEntryUsecase;
  final GetLastNDaysEntriesUsecase _getLastNDaysEntriesUsecase;
  final GetSevenDayTrendUsecase _getSevenDayTrendUsecase;

  DashboardBloc(
    this._getLatestEntryUsecase,
    this._getLastNDaysEntriesUsecase,
    this._getSevenDayTrendUsecase,
  ) : super(const DashboardState()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<RefreshDashboard>(_onRefreshDashboard);
  }

  /// Load dashboard data
  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // Get latest weight entry
      final latestEntry = await _getLatestEntryUsecase();
      
      // Get last 7 days entries
      final last7Days = await _getLastNDaysEntriesUsecase(7);
      
      // Get trend
      final trend = await _getSevenDayTrendUsecase();

      emit(
        state.copyWith(
          isLoading: false,
          currentWeight: latestEntry?.weight,
          sevenDayTrend: trend,
          recentEntries: last7Days.take(5).toList(), // Last 5 entries
          last7DaysEntries: last7Days,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load dashboard: ${e.toString()}',
        ),
      );
    }
  }

  /// Refresh dashboard data
  Future<void> _onRefreshDashboard(
    RefreshDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      // Get latest weight entry
      final latestEntry = await _getLatestEntryUsecase();
      
      // Get last 7 days entries
      final last7Days = await _getLastNDaysEntriesUsecase(7);
      
      // Get trend
      final trend = await _getSevenDayTrendUsecase();

      emit(
        state.copyWith(
          isLoading: false,
          currentWeight: latestEntry?.weight,
          sevenDayTrend: trend,
          recentEntries: last7Days.take(5).toList(), // Last 5 entries
          last7DaysEntries: last7Days,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: 'Failed to refresh dashboard: ${e.toString()}',
        ),
      );
    }
  }
}
