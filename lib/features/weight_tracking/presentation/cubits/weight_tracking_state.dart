import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';

sealed class WeightTrackingState {
  const WeightTrackingState();
}

class WeightTrackingInitial extends WeightTrackingState {
  const WeightTrackingInitial();
}

class WeightTrackingLoading extends WeightTrackingState {
  const WeightTrackingLoading();
}

class WeightTrackingLoaded extends WeightTrackingState {
  /// The most recent weight entry's value. Null if no entries exist yet.
  final double? latestWeight;

  /// Weight change over the last 7 days (positive = gained, negative = lost).
  /// Null if fewer than 2 entries exist in the last 7 days.
  final double? sevenDayTrend;

  /// Total number of weight entries logged by the user.
  final int totalEntries;

  /// The last 7 entries used to draw the line chart (newest first).
  final List<WeightEntryEntity> recentEntries;

  /// The user's target / goal weight. Null until the user sets one.
  final double? targetWeight;

  /// The user's starting weight when the goal was set.
  final double? startingWeight;

  /// The user's target date to reach their goal. Defaults to today if not set.
  final DateTime? targetDate;

  /// The user's goal type (e.g. Lose, Maintain, Gain). Null until the user sets one.
  final String? goalType;

  const WeightTrackingLoaded({
    required this.latestWeight,
    required this.sevenDayTrend,
    required this.totalEntries,
    required this.recentEntries,
    this.targetWeight,
    this.startingWeight,
    this.targetDate,
    this.goalType,
  });
}


class WeightTrackingError extends WeightTrackingState {
  final String message;
  const WeightTrackingError(this.message);
}
