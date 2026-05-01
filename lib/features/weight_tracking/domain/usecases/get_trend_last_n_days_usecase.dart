import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class GetTrendLastNDaysUseCase {
  final WeightTrackingRepository repository;

  const GetTrendLastNDaysUseCase({required this.repository});

  /// Returns the weight change over the last [days] days.
  /// Positive value = weight gained, negative = weight lost.
  /// Returns null if there is not enough data to calculate a trend.
  Future<ApiResult<double?>> call(int days) {
    return repository.getTrendLastNDays(days);
  }
}
