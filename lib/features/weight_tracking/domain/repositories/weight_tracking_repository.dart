import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/target_goal_entity.dart';

abstract class WeightTrackingRepository {
  Future<ApiResult<int>> addEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  });

  Future<ApiResult<List<WeightEntryEntity>>> getAllEntries();

  Future<ApiResult<WeightEntryEntity?>> getLatestEntry();

  Future<ApiResult<List<WeightEntryEntity>>> getEntriesLastNDays(int days);

  Future<ApiResult<int>> getTotalEntriesCount();

  Future<ApiResult<bool>> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  });

  Future<ApiResult<int>> deleteEntry(int id);

  Future<ApiResult<int>> deleteAllEntries();

  Future<ApiResult<double?>> getTrendLastNDays(int days);

  Future<ApiResult<double?>> getSevenDayTrend();

  Future<ApiResult<void>> saveTargetGoal({
    required double targetWeight,
    required DateTime targetDate,
    required String goalType,
    required double startingWeight,
  });

  Future<ApiResult<TargetGoalEntity?>> getTargetGoal();
}
