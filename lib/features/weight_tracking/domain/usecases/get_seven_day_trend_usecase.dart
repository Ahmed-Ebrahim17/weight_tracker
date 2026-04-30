import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class GetSevenDayTrendUsecase {
  final WeightRepository repository;

  GetSevenDayTrendUsecase(this.repository);

  Future<double?> call() => repository.getSevenDayTrend();
}
