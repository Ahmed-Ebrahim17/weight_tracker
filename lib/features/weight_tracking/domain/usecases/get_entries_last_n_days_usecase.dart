import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class GetEntriesLastNDaysUseCase {
  final WeightTrackingRepository repository;

  const GetEntriesLastNDaysUseCase({required this.repository});

  /// Returns entries from the last [days] days.
  /// Use [days] = 7 for the dashboard chart, 30/90 for the history screen.
  Future<ApiResult<List<WeightEntryEntity>>> call(int days) {
    return repository.getEntriesLastNDays(days);
  }
}
