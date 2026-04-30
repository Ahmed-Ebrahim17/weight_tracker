import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables/weight_entry_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [WeightEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ==================== WEIGHT ENTRIES CRUD ====================

  /// Create a new weight entry
  Future<int> createWeightEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) {
    final entry = WeightEntriesCompanion(
      weight: Value(weight),
      date: Value(date),
      time: Value(time),
      notes: notes != null ? Value(notes) : const Value.absent(),
    );
    return into(weightEntries).insert(entry);
  }

  /// Get all weight entries (ordered by date descending)
  Future<List<WeightEntry>> getAllWeightEntries() {
    return (select(weightEntries)
          ..orderBy([(t) => OrderingTerm(
              expression: t.date,
              mode: OrderingMode.desc,
            )]))
        .get();
  }

  /// Get the latest weight entry
  Future<WeightEntry?> getLatestWeightEntry() async {
    final result = await (select(weightEntries)
          ..orderBy([(t) => OrderingTerm(
              expression: t.date,
              mode: OrderingMode.desc,
            ))]
          ..limit(1))
        .getSingleOrNull();
    return result;
  }

  /// Get weight entries from the last N days
  Future<List<WeightEntry>> getWeightEntriesLastNDays(int days) {
    final cutoffDate = DateTime.now().subtract(Duration(days: days));
    return (select(weightEntries)
          ..where((t) => t.date.isBiggerOrEqual(Variable(cutoffDate)))
          ..orderBy([(t) => OrderingTerm(
              expression: t.date,
              mode: OrderingMode.desc,
            )]))
        .get();
  }

  /// Update a weight entry
  Future<bool> updateWeightEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) {
    final entry = WeightEntriesCompanion(
      id: Value(id),
      weight: Value(weight),
      date: Value(date),
      time: Value(time),
      notes: notes != null ? Value(notes) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
    return update(weightEntries).replace(entry);
  }

  /// Delete a weight entry
  Future<int> deleteWeightEntry(int id) {
    return (delete(weightEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Delete all weight entries
  Future<int> deleteAllWeightEntries() {
    return delete(weightEntries).go();
  }

  /// Get total number of weight entries
  Future<int> getWeightEntriesCount() {
    return (selectOnly(weightEntries)
          ..addColumns([weightEntries.id.count()]))
        .map((row) => row.read<int>(weightEntries.id.count()))
        .getSingle();
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'weight_tracker_db');
}
