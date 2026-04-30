part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final double? currentWeight;
  final double? sevenDayTrend;
  final List<WeightEntry> recentEntries;
  final List<WeightEntry> last7DaysEntries;

  const DashboardState({
    this.isLoading = true,
    this.errorMessage,
    this.currentWeight,
    this.sevenDayTrend,
    this.recentEntries = const [],
    this.last7DaysEntries = const [],
  });

  DashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
    double? currentWeight,
    double? sevenDayTrend,
    List<WeightEntry>? recentEntries,
    List<WeightEntry>? last7DaysEntries,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      currentWeight: currentWeight ?? this.currentWeight,
      sevenDayTrend: sevenDayTrend ?? this.sevenDayTrend,
      recentEntries: recentEntries ?? this.recentEntries,
      last7DaysEntries: last7DaysEntries ?? this.last7DaysEntries,
    );
  }

  /// Check if there are any entries
  bool get hasEntries => recentEntries.isNotEmpty;

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    currentWeight,
    sevenDayTrend,
    recentEntries,
    last7DaysEntries,
  ];
}
