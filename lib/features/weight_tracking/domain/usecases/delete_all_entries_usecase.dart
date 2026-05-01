import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class DeleteAllEntriesUseCase {
  final WeightTrackingRepository repository;

  const DeleteAllEntriesUseCase({required this.repository});

  /// Deletes ALL weight entries. Typically called from the Settings screen.
  /// Returns the number of rows deleted.
  Future<ApiResult<int>> call() {
    return repository.deleteAllEntries();
  }
}
