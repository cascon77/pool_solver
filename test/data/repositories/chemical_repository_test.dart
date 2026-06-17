import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/chemical_repository_impl.dart';
import 'package:pool_solution/domain/entities/chemical_entity.dart';
import 'package:pool_solution/domain/entities/enums.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

void main() {
  late AppDatabase db;
  late ChemicalRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.executor(NativeDatabase.memory());
    repository = ChemicalRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ChemicalRepositoryImpl Tests', () {
    final c1 = ChemicalEntity(
      name: 'Cloro Rápido',
      chemicalTypeId: 1,
      format: ChemicalFormat.powder,
      concentration: 65.0,
      unit: Unit.kg,
    );

    final c2 = ChemicalEntity(
      name: 'Reductor pH',
      chemicalTypeId: 2,
      format: ChemicalFormat.liquid,
      concentration: 15.0,
      unit: Unit.l,
    );

    test('Search by Name', () async {
      await repository.insertChemical(c1);
      await repository.insertChemical(c2);

      final results = await repository.searchByName('Cloro');
      expect(results.length, 1);
      expect(results.first.name, 'Cloro Rápido');
    });

    test('Filter by Chemical Type', () async {
      await repository.insertChemical(c1);
      await repository.insertChemical(c2);

      final results = await repository.filterByChemicalType(2);
      expect(results.length, 1);
      expect(results.first.name, 'Reductor pH');
    });

    test('Search by Multiple Criteria', () async {
      await repository.insertChemical(c1);
      await repository.insertChemical(c2);

      final filter = SearchFilter(
        searchTerm: 'pH',
        format: ChemicalFormat.liquid.name,
      );
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.name, 'Reductor pH');
    });
  });
}
