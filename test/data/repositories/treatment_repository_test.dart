import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/treatment_repository_impl.dart';
import 'package:pool_solution/domain/entities/enums.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/entities/treatment_entity.dart';

void main() {
  late AppDatabase db;
  late TreatmentRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.executor(NativeDatabase.memory());
    repository = TreatmentRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('TreatmentRepositoryImpl Tests', () {
    final t1 = TreatmentEntity(
      poolId: 1,
      chemicalId: 10,
      problemId: 'green_water',
      date: DateTime(2023, 2, 10),
      amountUsed: 500.0,
      unit: Unit.g,
      notes: 'Tratamiento inicial',
    );

    final t2 = TreatmentEntity(
      poolId: 1,
      chemicalId: 11,
      problemId: 'low_ph',
      date: DateTime(2023, 2, 15),
      amountUsed: 200.0,
      unit: Unit.ml,
      notes: 'Ajuste pH',
    );

    final t3 = TreatmentEntity(
      poolId: 2,
      chemicalId: 10,
      problemId: 'green_water',
      date: DateTime(2023, 3, 1),
      amountUsed: 1000.0,
      unit: Unit.g,
      notes: 'Piscina 2 choque',
    );

    test('Insert and Get By Pool Id', () async {
      await repository.insertTreatment(t1);
      await repository.insertTreatment(t2);
      await repository.insertTreatment(t3);

      final results = await repository.getByPoolId(1);
      expect(results.length, 2);
      // Ordered by date desc in implementation
      expect(results.first.date, DateTime(2023, 2, 15));
    });

    test('Filter by Date Range', () async {
      await repository.insertTreatment(t1);
      await repository.insertTreatment(t2);
      await repository.insertTreatment(t3);

      final results = await repository.filterByDateRange(
        DateTime(2023, 2, 1),
        DateTime(2023, 2, 28),
      );
      expect(results.length, 2);
    });

    test('Search by Multiple Criteria - Pool and Category', () async {
      await repository.insertTreatment(t1);
      await repository.insertTreatment(t2);
      await repository.insertTreatment(t3);

      final filter = SearchFilter(
        foreignKeyId: 1,
        category: 'green_water',
      );
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.problemId, 'green_water');
      expect(results.first.poolId, 1);
    });

    test('Search by Multiple Criteria - Chemical Id', () async {
      await repository.insertTreatment(t1);
      await repository.insertTreatment(t2);
      await repository.insertTreatment(t3);

      // In TreatmentRepositoryImpl, filter.type is parsed to int for chemicalId
      final filter = SearchFilter(type: '10');
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 2);
    });
  });
}
