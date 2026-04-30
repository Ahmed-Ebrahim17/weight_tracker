import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class AddWeightEntryUsecase {
  final WeightRepository repository;

  AddWeightEntryUsecase(this.repository);

  Future<int> call({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) =>
      repository.addWeightEntry(
        weight: weight,
        date: date,
        time: time,
        notes: notes,
      );
}
