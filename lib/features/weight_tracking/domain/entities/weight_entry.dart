import 'package:equatable/equatable.dart';

class WeightEntry extends Equatable {
  final int id;
  final double weight;
  final DateTime date;
  final DateTime time;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const WeightEntry({
    required this.id,
    required this.weight,
    required this.date,
    required this.time,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        weight,
        date,
        time,
        notes,
        createdAt,
        updatedAt,
      ];

  /// Combine date and time into a single DateTime
  DateTime get dateTime => DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
}
