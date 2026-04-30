import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class GetAllEntriesUsecase {
  final WeightRepository repository;

  GetAllEntriesUsecase(this.repository);

  Future<List<WeightEntry>> call() => repository.getAllEntries();
}
