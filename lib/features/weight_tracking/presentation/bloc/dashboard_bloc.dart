import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weight_tracker/core/database/database.dart';
import 'package:weight_tracker/core/database/services/weight_entry_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final WeightEntryService _weightEntryService;

  DashboardBloc(this._weightEntryService) : super(const DashboardState()) {
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
      final latestEntry = await _weightEntryService.getLatestEntry();
      
      // Get last 7 days entries
      final last7Days = await _weightEntryService.getEntriesLast7Days();
      
      // Get trend
      final trend = await _weightEntryService.getSevenDayTrend();

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
      final latestEntry = await _weightEntryService.getLatestEntry();
      
      // Get last 7 days entries
      final last7Days = await _weightEntryService.getEntriesLast7Days();
      
      // Get trend
      final trend = await _weightEntryService.getSevenDayTrend();

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
