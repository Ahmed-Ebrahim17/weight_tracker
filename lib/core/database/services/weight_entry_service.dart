import '../../database.dart';
import '../tables/weight_entry_table.dart';

/// Service layer for weight entry operations
/// Use this instead of calling database directly
class WeightEntryService {
  final AppDatabase _database;

  WeightEntryService(this._database);

  // Create
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

  // Read
  Future<List<WeightEntry>> getAllEntries() =>
      _database.getAllWeightEntries();

  Future<WeightEntry?> getLatestEntry() =>
      _database.getLatestWeightEntry();

  Future<List<WeightEntry>> getEntriesLast7Days() =>
      _database.getWeightEntriesLastNDays(7);

  Future<List<WeightEntry>> getEntriesLastNDays(int days) =>
      _database.getWeightEntriesLastNDays(days);

  Future<int> getTotalEntriesCount() =>
      _database.getWeightEntriesCount();

  // Update
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

  // Delete
  Future<int> deleteEntry(int id) => _database.deleteWeightEntry(id);

  Future<int> deleteAllEntries() => _database.deleteAllWeightEntries();

  // Calculations
  Future<double?> getTrendLastNDays(int days) async {
    final entries = await getEntriesLastNDays(days);
    if (entries.isEmpty) return null;
    if (entries.length == 1) return 0;

    final latest = entries.first.weight;
    final oldest = entries.last.weight;
    return latest - oldest;
  }

  /// Returns the 7-day trend
  Future<double?> getSevenDayTrend() => getTrendLastNDays(7);
}
