import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class UpdateWeightEntryUseCase {
  final WeightTrackingRepository repository;

  const UpdateWeightEntryUseCase({required this.repository});

  /// Updates an existing entry by [id]. Returns true if the update succeeded.
  Future<ApiResult<bool>> call({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) {
    return repository.updateEntry(
      id: id,
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );
  }
}
