import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class UpdateWeightEntryUsecase {
  final WeightRepository repository;

  UpdateWeightEntryUsecase(this.repository);

  Future<bool> call({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) =>
      repository.updateEntry(
        id: id,
        weight: weight,
        date: date,
        time: time,
        notes: notes,
      );
}
