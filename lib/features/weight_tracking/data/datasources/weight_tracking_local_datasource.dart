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
}

class WeightTrackingLocalDataSourceImpl
    implements WeightTrackingLocalDataSource {
  final WeightEntryService weightEntryService;

  const WeightTrackingLocalDataSourceImpl({required this.weightEntryService});

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
}
