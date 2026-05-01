import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class DeleteWeightEntryUseCase {
  final WeightTrackingRepository repository;

  const DeleteWeightEntryUseCase({required this.repository});

  /// Deletes a single entry by [id].
  /// Returns the number of rows deleted (1 on success, 0 if not found).
  Future<ApiResult<int>> call(int id) {
    return repository.deleteEntry(id);
  }
}
