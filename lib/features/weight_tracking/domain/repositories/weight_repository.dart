import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';

abstract class WeightRepository {
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
