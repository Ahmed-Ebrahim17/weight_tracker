part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load dashboard data
class LoadDashboard extends DashboardEvent {
  const LoadDashboard();
}

/// Event to refresh dashboard data
class RefreshDashboard extends DashboardEvent {
  const RefreshDashboard();
}
