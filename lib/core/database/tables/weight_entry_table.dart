import 'package:drift/drift.dart';

class WeightEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get weight => real()(); // Weight in lbs/kg
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime()();
  TextColumn get notes => text().nullable()(); // Optional notes
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

// This is the data class that represents a single weight entry
class WeightEntry {
  final int id;
  final double weight;
  final DateTime date;
  final DateTime time;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  WeightEntry({
    required this.id,
    required this.weight,
    required this.date,
    required this.time,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  // Helper method to get combined date and time
  DateTime get dateTime => DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}
