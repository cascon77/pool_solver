import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/measurement_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/measurement_repository.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {
  final AppDatabase db;

  MeasurementRepositoryImpl(this.db);

  @override
  Future<List<MeasurementEntity>> getAllMeasurements() async {
    return await db.select(db.measurements).get();
  }

  @override
  Future<MeasurementEntity?> getMeasurementById(int id) async {
    return await (db.select(db.measurements)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertMeasurement(MeasurementEntity measurement) {
    return db.into(db.measurements).insert(MeasurementsCompanion.insert(
      poolId: Value(measurement.poolId),
      date: Value(measurement.date),
      ph: Value(measurement.ph),
      chlorine: Value(measurement.chlorine),
      alkalinity: Value(measurement.alkalinity),
      stabilizer: Value(measurement.stabilizer),
      salt: Value(measurement.salt),
      calciumHardness: Value(measurement.calciumHardness),
      notes: Value(measurement.notes),
    ));
  }

  @override
  Future<bool> updateMeasurement(MeasurementEntity measurement) {
    return db.update(db.measurements).replace(MeasurementsCompanion(
      id: Value(measurement.id!),
      poolId: Value(measurement.poolId),
      date: Value(measurement.date),
      ph: Value(measurement.ph),
      chlorine: Value(measurement.chlorine),
      alkalinity: Value(measurement.alkalinity),
      stabilizer: Value(measurement.stabilizer),
      salt: Value(measurement.salt),
      calciumHardness: Value(measurement.calciumHardness),
      notes: Value(measurement.notes),
    ));
  }

  @override
  Future<bool> deleteMeasurement(int id) async {
    final count = await (db.delete(db.measurements)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<MeasurementEntity>> getByPoolId(int poolId) async {
    return await (db.select(db.measurements)
          ..where((t) => t.poolId.equals(poolId)))
        .get();
  }

  @override
  Future<List<MeasurementEntity>> filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (db.select(db.measurements)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startDate) &
              t.date.isSmallerOrEqualValue(endDate)))
        .get();
  }

  @override
  Future<List<MeasurementEntity>> getByPoolAndDateRange(
    int poolId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (db.select(db.measurements)
          ..where((t) =>
              t.poolId.equals(poolId) &
              t.date.isBiggerOrEqualValue(startDate) &
              t.date.isSmallerOrEqualValue(endDate)))
        .get();
  }

  @override
  Future<List<MeasurementEntity>> getByPoolAndDate(int poolId, DateTime date) async {
    return await (db.select(db.measurements)
          ..where((t) => t.poolId.equals(poolId) & t.date.equals(date)))
        .get();
  }

  @override
  Future<List<MeasurementEntity>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.measurements);

    if (filter.foreignKeyId != null) {
      query = query..where((t) => t.poolId.equals(filter.foreignKeyId!));
    }

    if (filter.startDate != null && filter.endDate != null) {
      query = query
        ..where((t) =>
            t.date.isBiggerOrEqualValue(filter.startDate!) &
            t.date.isSmallerOrEqualValue(filter.endDate!));
    } else if (filter.exactDate != null) {
      query = query..where((t) => t.date.equals(filter.exactDate!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }
}
