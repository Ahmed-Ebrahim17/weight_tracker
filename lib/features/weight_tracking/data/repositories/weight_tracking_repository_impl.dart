import 'package:dartz/dartz.dart';
import 'package:weight_tracker/core/error/api_result.dart';
import 'package:weight_tracker/core/error/failure.dart';
import 'package:weight_tracker/features/weight_tracking/data/datasources/weight_tracking_local_datasource.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/target_goal_entity.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_tracking_repository.dart';

class WeightTrackingRepositoryImpl implements WeightTrackingRepository {
  final WeightTrackingLocalDataSource localDataSource;

  const WeightTrackingRepositoryImpl({required this.localDataSource});

  @override
  Future<ApiResult<int>> addEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) async {
    try {
      final id = await localDataSource.addEntry(
        weight: weight,
        date: date,
        time: time,
        notes: notes,
      );
      return Right(id);
    } catch (e) {
      return const Left(UnknownFailure('Failed to add weight entry.'));
    }
  }

  @override
  Future<ApiResult<List<WeightEntryEntity>>> getAllEntries() async {
    try {
      final entries = await localDataSource.getAllEntries();
      return Right(entries.map<WeightEntryEntity>((entry) => entry).toList());
    } catch (e) {
      return const Left(UnknownFailure('Failed to load weight entries.'));
    }
  }

  @override
  Future<ApiResult<WeightEntryEntity?>> getLatestEntry() async {
    try {
      final entry = await localDataSource.getLatestEntry();
      return Right(entry);
    } catch (e) {
      return const Left(UnknownFailure('Failed to load latest entry.'));
    }
  }

  @override
  Future<ApiResult<List<WeightEntryEntity>>> getEntriesLastNDays(
    int days,
  ) async {
    try {
      final entries = await localDataSource.getEntriesLastNDays(days);
      return Right(entries.map<WeightEntryEntity>((entry) => entry).toList());
    } catch (e) {
      return const Left(UnknownFailure('Failed to load recent entries.'));
    }
  }

  @override
  Future<ApiResult<int>> getTotalEntriesCount() async {
    try {
      final count = await localDataSource.getTotalEntriesCount();
      return Right(count);
    } catch (e) {
      return const Left(UnknownFailure('Failed to load entries count.'));
    }
  }

  @override
  Future<ApiResult<bool>> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) async {
    try {
      final updated = await localDataSource.updateEntry(
        id: id,
        weight: weight,
        date: date,
        time: time,
        notes: notes,
      );
      return Right(updated);
    } catch (e) {
      return const Left(UnknownFailure('Failed to update entry.'));
    }
  }

  @override
  Future<ApiResult<int>> deleteEntry(int id) async {
    try {
      final result = await localDataSource.deleteEntry(id);
      return Right(result);
    } catch (e) {
      return const Left(UnknownFailure('Failed to delete entry.'));
    }
  }

  @override
  Future<ApiResult<int>> deleteAllEntries() async {
    try {
      final result = await localDataSource.deleteAllEntries();
      return Right(result);
    } catch (e) {
      return const Left(UnknownFailure('Failed to delete entries.'));
    }
  }

  @override
  Future<ApiResult<double?>> getTrendLastNDays(int days) async {
    try {
      final trend = await localDataSource.getTrendLastNDays(days);
      return Right(trend);
    } catch (e) {
      return const Left(UnknownFailure('Failed to load trend data.'));
    }
  }

  @override
  Future<ApiResult<double?>> getSevenDayTrend() async {
    try {
      final trend = await localDataSource.getTrendLastNDays(7);
      return Right(trend);
    } catch (e) {
      return const Left(UnknownFailure('Failed to load seven day trend.'));
    }
  }

  @override
  Future<ApiResult<void>> saveTargetGoal({
    required double targetWeight,
    required DateTime targetDate,
    required String goalType,
    required double startingWeight,
  }) async {
    try {
      await localDataSource.saveTargetGoal(
        targetWeight,
        targetDate,
        goalType,
        startingWeight,
      );
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure('Failed to save target goal.'));
    }
  }

  @override
  Future<ApiResult<TargetGoalEntity?>> getTargetGoal() async {
    try {
      final targetWeight = await localDataSource.getTargetWeight();
      final targetDate = await localDataSource.getTargetDate();
      final goalType = await localDataSource.getGoalType();
      final startingWeight = await localDataSource.getStartingWeight();

      if (targetWeight != null && targetDate != null && goalType != null) {
        return Right(
          TargetGoalEntity(
            targetWeight: targetWeight,
            targetDate: targetDate,
            goalType: goalType,
            startingWeight: startingWeight,
          ),
        );
      }
      return const Right(null);
    } catch (e) {
      return const Left(UnknownFailure('Failed to load target goal.'));
    }
  }
}
