import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class AddWeightEntryUseCase {
  final WeightTrackingRepository repository;

  const AddWeightEntryUseCase({required this.repository});

  Future<ApiResult<int>> call({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) {
    return repository.addEntry(
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );
  }
}
