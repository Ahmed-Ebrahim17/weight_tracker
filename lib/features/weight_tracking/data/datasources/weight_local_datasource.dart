import 'package:weight_tracker/core/database/database.dart';

abstract class WeightLocalDatasource {
  // Create
  Future<int> addWeightEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  });

  // Read
  Future<List<WeightEntry>> getAllEntries();

  Future<WeightEntry?> getLatestEntry();

  Future<List<WeightEntry>> getEntriesLast7Days();

  Future<List<WeightEntry>> getEntriesLastNDays(int days);

  Future<int> getTotalEntriesCount();

  // Update
  Future<bool> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  });

  // Delete
  Future<int> deleteEntry(int id);

  Future<int> deleteAllEntries();

  // Analytics
  Future<double?> getSevenDayTrend();
}

class WeightLocalDatasourceImpl implements WeightLocalDatasource {
  final AppDatabase _database;

  WeightLocalDatasourceImpl(this._database);

  @override
  Future<int> addWeightEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) =>
      _database.createWeightEntry(
        weight: weight,
        date: date,
        time: time,
        notes: notes,
      );

  @override
  Future<List<WeightEntry>> getAllEntries() =>
      _database.getAllWeightEntries();

  @override
  Future<WeightEntry?> getLatestEntry() =>
      _database.getLatestWeightEntry();

  @override
  Future<List<WeightEntry>> getEntriesLast7Days() =>
      _database.getWeightEntriesLastNDays(7);

  @override
  Future<List<WeightEntry>> getEntriesLastNDays(int days) =>
      _database.getWeightEntriesLastNDays(days);

  @override
  Future<int> getTotalEntriesCount() =>
      _database.getWeightEntriesCount();

  @override
  Future<bool> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) =>
      _database.updateWeightEntry(
        id: id,
        weight: weight,
        date: date,
        time: time,
        notes: notes,
      );

  @override
  Future<int> deleteEntry(int id) => _database.deleteWeightEntry(id);

  @override
  Future<int> deleteAllEntries() => _database.deleteAllWeightEntries();

  @override
  Future<double?> getSevenDayTrend() =>
      _database.getWeightTrendLast7Days();
}
