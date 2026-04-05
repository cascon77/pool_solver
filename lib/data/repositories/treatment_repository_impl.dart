import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/entities/treatment_entity.dart';
import 'package:pool_solution/domain/repository_interfaces/treatment_repository.dart';

class TreatmentRepositoryImpl implements TreatmentRepository {
  final AppDatabase db;

  TreatmentRepositoryImpl(this.db);

  // ── CRUD básico ────────────────────────────────────────────────────────────

  @override
  Future<List<TreatmentEntity>> getAllTreatments() =>
      db.select(db.treatments).get();

  @override
  Future<TreatmentEntity?> getTreatmentById(int id) =>
      (db.select(db.treatments)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  @override
  Future<int> insertTreatment(TreatmentEntity treatment) =>
      db.into(db.treatments).insert(TreatmentsCompanion.insert(
            poolId: Value(treatment.poolId),
            chemicalId: Value(treatment.chemicalId),
            measurementId: Value(treatment.measurementId),
            problemId: Value(treatment.problemId),
            date: Value(treatment.date),
            amountUsed: Value(treatment.amountUsed),
            unit: Value(treatment.unit),
            notes: Value(treatment.notes ?? treatment.description),
          ));

  @override
  Future<bool> updateTreatment(TreatmentEntity treatment) =>
      db.update(db.treatments).replace(TreatmentsCompanion(
            id: Value(treatment.id!),
            poolId: Value(treatment.poolId),
            chemicalId: Value(treatment.chemicalId),
            measurementId: Value(treatment.measurementId),
            problemId: Value(treatment.problemId),
            date: Value(treatment.date),
            amountUsed: Value(treatment.amountUsed),
            unit: Value(treatment.unit),
            notes: Value(treatment.notes ?? treatment.description),
          ));

  @override
  Future<bool> deleteTreatment(int id) async {
    final count = await (db.delete(db.treatments)
          ..where((t) => t.id.equals(id)))
        .go();
    return count > 0;
  }

  // ── Búsquedas por FK ──────────────────────────────────────────────────────

  @override
  Future<List<TreatmentEntity>> getByPoolId(int poolId) =>
      (db.select(db.treatments)
            ..where((t) => t.poolId.equals(poolId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  @override
  Future<List<TreatmentEntity>> getByChemicalId(int chemicalId) =>
      (db.select(db.treatments)
            ..where((t) => t.chemicalId.equals(chemicalId)))
          .get();

  @override
  Future<List<TreatmentEntity>> getByProblemId(int problemId) =>
      // problemId en BD es String (id del JSON), se convierte
      (db.select(db.treatments)
            ..where((t) => t.problemId.equals(problemId.toString())))
          .get();

  /// Variante que acepta el id de problema como String (recomendada)
  Future<List<TreatmentEntity>> getByProblemStringId(String problemId) =>
      (db.select(db.treatments)
            ..where((t) => t.problemId.equals(problemId)))
          .get();

  @override
  Future<List<TreatmentEntity>> getByMeasurementId(int measurementId) =>
      (db.select(db.treatments)
            ..where((t) => t.measurementId.equals(measurementId)))
          .get();

  // ── Filtros por fecha ──────────────────────────────────────────────────────

  @override
  Future<List<TreatmentEntity>> filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) =>
      (db.select(db.treatments)
            ..where((t) =>
                t.date.isBiggerOrEqualValue(startDate) &
                t.date.isSmallerOrEqualValue(endDate))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  @override
  Future<List<TreatmentEntity>> getByPoolAndDateRange(
    int poolId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      (db.select(db.treatments)
            ..where((t) =>
                t.poolId.equals(poolId) &
                t.date.isBiggerOrEqualValue(startDate) &
                t.date.isSmallerOrEqualValue(endDate))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  // ── Búsqueda avanzada ─────────────────────────────────────────────────────

  @override
  Future<List<TreatmentEntity>> searchByMultipleCriteria(
      SearchFilter filter) async {
    var query = db.select(db.treatments);

    query.where((t) {
      Expression<bool> expr = const Constant(true);

      if (filter.foreignKeyId != null) {
        expr = expr & t.poolId.equals(filter.foreignKeyId!);
      }

      if (filter.type != null && filter.type!.isNotEmpty) {
        final chemId = int.tryParse(filter.type!);
        if (chemId != null) {
          expr = expr & t.chemicalId.equals(chemId);
        }
      }

      if (filter.category != null && filter.category!.isNotEmpty) {
        // category se usa para filtrar por problemId (String)
        expr = expr & t.problemId.equals(filter.category!);
      }

      if (filter.startDate != null && filter.endDate != null) {
        expr = expr &
            t.date.isBiggerOrEqualValue(filter.startDate!) &
            t.date.isSmallerOrEqualValue(filter.endDate!);
      } else if (filter.exactDate != null) {
        final start = DateTime(filter.exactDate!.year, filter.exactDate!.month,
            filter.exactDate!.day);
        final end = start.add(const Duration(days: 1));
        expr = expr &
            t.date.isBiggerOrEqualValue(start) &
            t.date.isSmallerThanValue(end);
      }

      return expr;
    });

    query.orderBy([(t) => OrderingTerm.desc(t.date)]);

    if (filter.limit != null) {
      query.limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return query.get();
  }
}
