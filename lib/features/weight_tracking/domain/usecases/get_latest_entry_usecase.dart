import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class GetLatestEntryUseCase {
  final WeightTrackingRepository repository;

  const GetLatestEntryUseCase({required this.repository});

  /// Returns the most recent weight entry, or null if no entries exist yet.
  Future<ApiResult<WeightEntryEntity?>> call() {
    return repository.getLatestEntry();
  }
}
