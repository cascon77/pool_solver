import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/inventory_repository_impl.dart';
import 'package:pool_solution/domain/entities/inventory_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

void main() {
  late AppDatabase db;
  late InventoryRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.executor(NativeDatabase.memory());
    repository = InventoryRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('InventoryRepositoryImpl Tests', () {
    final i1 = InventoryEntity(
      chemicalId: 1,
      stock: 5,
      minStock: 2,
      notes: 'Stock de cloro',
    );

    final i2 = InventoryEntity(
      chemicalId: 2,
      stock: 10,
      minStock: 5,
      notes: 'Stock de pH minus',
    );

    test('Get By Chemical Id', () async {
      await repository.insertInventory(i1);
      await repository.insertInventory(i2);

      final result = await repository.getByChemicalId(2);
      expect(result, isNotNull);
      expect(result!.notes, 'Stock de pH minus');
    });

    test('Search by Multiple Criteria', () async {
      await repository.insertInventory(i1);
      await repository.insertInventory(i2);

      final filter = SearchFilter(foreignKeyId: 1);
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.notes, 'Stock de cloro');
    });
  });
}
