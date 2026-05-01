import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class GetAllEntriesUseCase {
  final WeightTrackingRepository repository;

  const GetAllEntriesUseCase({required this.repository});

  Future<ApiResult<List<WeightEntryEntity>>> call() {
    return repository.getAllEntries();
  }
}
