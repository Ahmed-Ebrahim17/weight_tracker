import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class GetLastNDaysEntriesUsecase {
  final WeightRepository repository;

  GetLastNDaysEntriesUsecase(this.repository);

  Future<List<WeightEntry>> call(int days) =>
      repository.getEntriesLastNDays(days);
}
