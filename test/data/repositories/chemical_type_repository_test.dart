import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/chemical_type_repository_impl.dart';
import 'package:pool_solution/domain/entities/chemical_type.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

void main() {
  late AppDatabase db;
  late ChemicalTypeRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.executor(NativeDatabase.memory());
    repository = ChemicalTypeRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('ChemicalTypeRepositoryImpl Tests', () {
    final ct1 = ChemicalType(
      name: 'Desinfectante',
      parameterTarget: 'chlorine',
    );

    final ct2 = ChemicalType(
      name: 'Equilibrante pH',
      parameterTarget: 'ph',
    );

    test('Search by Name', () async {
      await repository.insertChemicalType(ct1);
      await repository.insertChemicalType(ct2);

      final results = await repository.searchByName('Desinfectante');
      expect(results.length, 1);
      expect(results.first.parameterTarget, 'chlorine');
    });

    test('Filter by Parameter Target', () async {
      await repository.insertChemicalType(ct1);
      await repository.insertChemicalType(ct2);

      final results = await repository.filterByParameterTarget('ph');
      expect(results.length, 1);
      expect(results.first.name, 'Equilibrante pH');
    });
  });
}
