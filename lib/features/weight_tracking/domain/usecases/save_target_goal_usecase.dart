import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class SaveTargetGoalUseCase {
  final WeightTrackingRepository repository;

  SaveTargetGoalUseCase({required this.repository});

  Future<ApiResult<void>> call({
    required double targetWeight,
    required DateTime targetDate,
    required String goalType,
  }) {
    return repository.saveTargetGoal(
      targetWeight: targetWeight,
      targetDate: targetDate,
      goalType: goalType,
    );
  }
}
