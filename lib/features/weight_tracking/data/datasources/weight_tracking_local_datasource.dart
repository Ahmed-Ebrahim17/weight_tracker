import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker/core/database/services/weight_entry_service.dart';
import 'package:weight_tracker/features/weight_tracking/data/models/weight_entry_model.dart';

abstract class WeightTrackingLocalDataSource {
  Future<int> addEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  });

  Future<List<WeightEntryModel>> getAllEntries();

  Future<WeightEntryModel?> getLatestEntry();

  Future<List<WeightEntryModel>> getEntriesLastNDays(int days);

  Future<int> getTotalEntriesCount();

  Future<bool> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  });

  Future<int> deleteEntry(int id);

  Future<int> deleteAllEntries();

  Future<double?> getTrendLastNDays(int days);

  Future<double?> getSevenDayTrend();

  Future<void> saveTargetGoal(
    double targetWeight,
    DateTime targetDate,
    String goalType,
  );

  Future<double?> getTargetWeight();
  Future<DateTime?> getTargetDate();
  Future<String?> getGoalType();
}

class WeightTrackingLocalDataSourceImpl
    implements WeightTrackingLocalDataSource {
  final WeightEntryService weightEntryService;
  final SharedPreferences sharedPreferences;

  const WeightTrackingLocalDataSourceImpl({
    required this.weightEntryService,
    required this.sharedPreferences,
  });
  // Target goal keys
  static const String _targetWeightKey = 'target_weight';
  static const String _targetDateKey = 'target_date';
  static const String _goalTypeKey = 'goal_type';

  @override
  Future<int> addEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) {
    return weightEntryService.addWeightEntry(
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );
  }

  @override
  Future<List<WeightEntryModel>> getAllEntries() async {
    final entries = await weightEntryService.getAllEntries();
    return entries.map(WeightEntryModel.fromDrift).toList();
  }

  @override
  Future<WeightEntryModel?> getLatestEntry() async {
    final entry = await weightEntryService.getLatestEntry();
    if (entry == null) {
      return null;
    }
    return WeightEntryModel.fromDrift(entry);
  }

  @override
  Future<List<WeightEntryModel>> getEntriesLastNDays(int days) async {
    final entries = await weightEntryService.getEntriesLastNDays(days);
    return entries.map(WeightEntryModel.fromDrift).toList();
  }

  @override
  Future<int> getTotalEntriesCount() {
    return weightEntryService.getTotalEntriesCount();
  }

  @override
  Future<bool> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) {
    return weightEntryService.updateEntry(
      id: id,
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );
  }

  @override
  Future<int> deleteEntry(int id) {
    return weightEntryService.deleteEntry(id);
  }

  @override
  Future<int> deleteAllEntries() {
    return weightEntryService.deleteAllEntries();
  }

  @override
  Future<double?> getTrendLastNDays(int days) {
    return weightEntryService.getTrendLastNDays(days);
  }

  @override
  Future<double?> getSevenDayTrend() {
    return weightEntryService.getSevenDayTrend();
  }

  @override
  Future<void> saveTargetGoal(
    double targetWeight,
    DateTime targetDate,
    String goalType,
  ) async {
    await sharedPreferences.setDouble(_targetWeightKey, targetWeight);
    await sharedPreferences.setString(
      _targetDateKey,
      targetDate.toIso8601String(),
    );
    await sharedPreferences.setString(_goalTypeKey, goalType);
  }

  @override
  Future<double?> getTargetWeight() async {
    return sharedPreferences.getDouble(_targetWeightKey);
  }

  @override
  Future<DateTime?> getTargetDate() async {
    final dateString = sharedPreferences.getString(_targetDateKey);
    if (dateString != null) {
      return DateTime.tryParse(dateString);
    }
    return null;
  }

  @override
  Future<String?> getGoalType() async {
    return sharedPreferences.getString(_goalTypeKey);
  }
}
