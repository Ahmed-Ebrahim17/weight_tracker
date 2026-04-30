import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class GetLatestEntryUsecase {
  final WeightRepository repository;

  GetLatestEntryUsecase(this.repository);

  Future<WeightEntry?> call() => repository.getLatestEntry();
}
