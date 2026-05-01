class WeightEntryEntity {
  final int id;
  final double weight;
  final DateTime date;
  final DateTime time;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WeightEntryEntity({
    required this.id,
    required this.weight,
    required this.date,
    required this.time,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  DateTime get dateTime => DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
}
