import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/entities/treatment_entity.dart';
import 'package:pool_solution/domain/repository_interfaces/treatment_repository.dart';

class TreatmentRepositoryImpl implements TreatmentRepository {
  final AppDatabase db;

  TreatmentRepositoryImpl(this.db);

  @override
  Future<List<TreatmentEntity>> getAllTreatments() async {
    return await db.select(db.treatments).get();
  }

  @override
  Future<TreatmentEntity?> getTreatmentById(int id) async {
    return await (db.select(db.treatments)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertTreatment(TreatmentEntity treatment) {
    return db.into(db.treatments).insert(TreatmentsCompanion.insert(
      poolId: Value(treatment.poolId),
      chemicalId: Value(treatment.chemicalId),
      measurementId: Value(treatment.measurementId),
      problemId: Value(treatment.problemId),
      date: Value(treatment.date),
      amountUsed: Value(treatment.amountUsed),
      unit: Value(treatment.unit),
      notes: Value(treatment.notes),
    ));
  }

  @override
  Future<bool> updateTreatment(TreatmentEntity treatment) {
    return db.update(db.treatments).replace(TreatmentsCompanion(
      id: Value(treatment.id!),
      poolId: Value(treatment.poolId),
      chemicalId: Value(treatment.chemicalId),
      measurementId: Value(treatment.measurementId),
      problemId: Value(treatment.problemId),
      date: Value(treatment.date),
      amountUsed: Value(treatment.amountUsed),
      unit: Value(treatment.unit),
      notes: Value(treatment.notes),
    ));
  }

  @override
  Future<bool> deleteTreatment(int id) async {
    final count = await (db.delete(db.treatments)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<TreatmentEntity>> getByPoolId(int poolId) async {
    return await (db.select(db.treatments)
          ..where((t) => t.poolId.equals(poolId)))
        .get();
  }

  @override
  Future<List<TreatmentEntity>> getByChemicalId(int chemicalId) async {
    return await (db.select(db.treatments)
          ..where((t) => t.chemicalId.equals(chemicalId)))
        .get();
  }

  @override
  Future<List<TreatmentEntity>> getByProblemId(int problemId) async {
    return await (db.select(db.treatments)
          ..where((t) => t.problemId.equals(problemId)))
        .get();
  }

  @override
  Future<List<TreatmentEntity>> getByMeasurementId(int measurementId) async {
    return await (db.select(db.treatments)
          ..where((t) => t.measurementId.equals(measurementId)))
        .get();
  }

  @override
  Future<List<TreatmentEntity>> filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (db.select(db.treatments)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startDate) &
              t.date.isSmallerOrEqualValue(endDate)))
        .get();
  }

  @override
  Future<List<TreatmentEntity>> getByPoolAndDateRange(
    int poolId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (db.select(db.treatments)
          ..where((t) =>
              t.poolId.equals(poolId) &
              t.date.isBiggerOrEqualValue(startDate) &
              t.date.isSmallerOrEqualValue(endDate)))
        .get();
  }

  @override
  Future<List<TreatmentEntity>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.treatments);

    // Búsqueda por piscina
    if (filter.foreignKeyId != null) {
      query = query..where((t) => t.poolId.equals(filter.foreignKeyId!));
    }

    // Búsqueda por químico
    if (filter.type != null && filter.type!.isNotEmpty) {
      // Intenta interpretar como ID de químico
      final chemicalId = int.tryParse(filter.type!);
      if (chemicalId != null) {
        query = query..where((t) => t.chemicalId.equals(chemicalId));
      }
    }

    // Búsqueda por problema (si hay un parámetro específico)
    if (filter.category != null && filter.category!.isNotEmpty) {
      final problemId = int.tryParse(filter.category!);
      if (problemId != null) {
        query = query..where((t) => t.problemId.equals(problemId));
      }
    }

    // Filtrado por rango de fechas
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
