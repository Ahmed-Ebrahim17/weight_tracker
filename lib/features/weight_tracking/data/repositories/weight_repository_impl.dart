import 'package:weight_tracker/features/weight_tracking/data/datasources/weight_local_datasource.dart';
import 'package:weight_tracker/features/weight_tracking/data/models/weight_entry_model.dart';
import 'package:weight_tracker/features/weight_tracking/domain/entities/weight_entry.dart';
import 'package:weight_tracker/features/weight_tracking/domain/repositories/weight_repository.dart';

class WeightRepositoryImpl implements WeightRepository {
  final WeightLocalDatasource localDatasource;

  WeightRepositoryImpl(this.localDatasource);

  @override
  Future<int> addWeightEntry({
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) async {
    return await localDatasource.addWeightEntry(
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );
  }

  @override
  Future<List<WeightEntry>> getAllEntries() async {
    final entries = await localDatasource.getAllEntries();
    return entries.map((e) => WeightEntryModel.fromDatabase(e).toDomain()).toList();
  }

  @override
  Future<WeightEntry?> getLatestEntry() async {
    final entry = await localDatasource.getLatestEntry();
    if (entry == null) return null;
    return WeightEntryModel.fromDatabase(entry).toDomain();
  }

  @override
  Future<List<WeightEntry>> getEntriesLast7Days() async {
    final entries = await localDatasource.getEntriesLast7Days();
    return entries.map((e) => WeightEntryModel.fromDatabase(e).toDomain()).toList();
  }

  @override
  Future<List<WeightEntry>> getEntriesLastNDays(int days) async {
    final entries = await localDatasource.getEntriesLastNDays(days);
    return entries.map((e) => WeightEntryModel.fromDatabase(e).toDomain()).toList();
  }

  @override
  Future<int> getTotalEntriesCount() =>
      localDatasource.getTotalEntriesCount();

  @override
  Future<bool> updateEntry({
    required int id,
    required double weight,
    required DateTime date,
    required DateTime time,
    String? notes,
  }) async {
    return await localDatasource.updateEntry(
      id: id,
      weight: weight,
      date: date,
      time: time,
      notes: notes,
    );
  }

  @override
  Future<int> deleteEntry(int id) => localDatasource.deleteEntry(id);

  @override
  Future<int> deleteAllEntries() => localDatasource.deleteAllEntries();

  @override
  Future<double?> getSevenDayTrend() => localDatasource.getSevenDayTrend();
}
