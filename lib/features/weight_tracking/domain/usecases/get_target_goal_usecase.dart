import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/target_goal_entity.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class GetTargetGoalUseCase {
  final WeightTrackingRepository repository;

  GetTargetGoalUseCase({required this.repository});

  Future<ApiResult<TargetGoalEntity?>> call() {
    return repository.getTargetGoal();
  }
}
