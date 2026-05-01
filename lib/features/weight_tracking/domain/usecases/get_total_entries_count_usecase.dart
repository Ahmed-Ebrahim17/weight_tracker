import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class GetTotalEntriesCountUseCase {
  final WeightTrackingRepository repository;

  const GetTotalEntriesCountUseCase({required this.repository});

  /// Returns the total number of weight logs recorded by the user.
  Future<ApiResult<int>> call() {
    return repository.getTotalEntriesCount();
  }
}
