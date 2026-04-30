import 'package:weight_tracker/core/database/database.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';

class WeightEntryModel extends WeightEntry {
  const WeightEntryModel({
    required super.id,
    required super.weight,
    required super.date,
    required super.time,
    super.notes,
    required super.createdAt,
    super.updatedAt,
  });

  /// Create from database entity
  factory WeightEntryModel.fromDatabase(WeightEntry dbEntry) {
    return WeightEntryModel(
      id: dbEntry.id,
      weight: dbEntry.weight,
      date: dbEntry.date,
      time: dbEntry.time,
      notes: dbEntry.notes,
      createdAt: dbEntry.createdAt,
      updatedAt: dbEntry.updatedAt,
    );
  }

  /// Convert to domain entity
  WeightEntry toDomain() {
    return WeightEntry(
      id: id,
      weight: weight,
      date: date,
      time: time,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
