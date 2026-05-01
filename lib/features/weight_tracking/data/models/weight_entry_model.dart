import 'package:weight_tracker/core/database/database.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart'
    as entities;

class WeightEntryModel extends entities.WeightEntryEntity {
  const WeightEntryModel({
    required super.id,
    required super.weight,
    required super.date,
    required super.time,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WeightEntryModel.fromDrift(WeightEntry entry) {
    return WeightEntryModel(
      id: entry.id,
      weight: entry.weight,
      date: entry.date,
      time: entry.time,
      notes: entry.notes,
      createdAt: entry.createdAt,
      updatedAt: entry.updatedAt,
    );
  }
}
