import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/measurement_repository_impl.dart';
import 'package:pool_solution/domain/entities/measurement_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

void main() {
  late AppDatabase db;
  late MeasurementRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.executor(NativeDatabase.memory());
    repository = MeasurementRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('MeasurementRepositoryImpl Tests', () {
    final m1 = MeasurementEntity(
      poolId: 1,
      date: DateTime(2023, 5, 10),
      ph: 7.2,
      chlorine: 1.5,
      notes: 'Medición 1',
    );

    final m2 = MeasurementEntity(
      poolId: 1,
      date: DateTime(2023, 5, 20),
      ph: 7.4,
      chlorine: 2.0,
      notes: 'Medición 2',
    );

    final m3 = MeasurementEntity(
      poolId: 2,
      date: DateTime(2023, 6, 1),
      ph: 7.0,
      chlorine: 1.0,
      notes: 'Medición Piscina 2',
    );

    test('Insert and Get By Pool Id', () async {
      await repository.insertMeasurement(m1);
      await repository.insertMeasurement(m2);
      await repository.insertMeasurement(m3);

      final results = await repository.getByPoolId(1);
      expect(results.length, 2);
    });

    test('Filter by Date Range', () async {
      await repository.insertMeasurement(m1);
      await repository.insertMeasurement(m2);
      await repository.insertMeasurement(m3);

      final results = await repository.filterByDateRange(
        DateTime(2023, 5, 1),
        DateTime(2023, 5, 15),
      );
      expect(results.length, 1);
      expect(results.first.notes, 'Medición 1');
    });

    test('Search by Multiple Criteria - Pool and Date Range', () async {
      await repository.insertMeasurement(m1);
      await repository.insertMeasurement(m2);
      await repository.insertMeasurement(m3);

      final filter = SearchFilter(
        foreignKeyId: 1,
        startDate: DateTime(2023, 5, 15),
        endDate: DateTime(2023, 5, 25),
      );
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.notes, 'Medición 2');
    });
  });
}
