import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class DeleteWeightEntryUsecase {
  final WeightRepository repository;

  DeleteWeightEntryUsecase(this.repository);

  Future<int> call(int id) => repository.deleteEntry(id);
}
