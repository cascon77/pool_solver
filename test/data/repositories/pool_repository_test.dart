import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/pool_repository_impl.dart';
import 'package:pool_solution/domain/entities/enums.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

void main() {
  late AppDatabase db;
  late PoolRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.executor(NativeDatabase.memory());
    repository = PoolRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('PoolRepositoryImpl Tests', () {
    final pool1 = PoolEntity(
      name: 'Piscina Grande',
      volumeLiters: 50000,
      waterType: WaterType.chlorine,
      filterType: FilterType.sand,
      shape: 'rectangular',
      createdAt: DateTime(2023, 1, 1),
    );

    final pool2 = PoolEntity(
      name: 'Pequeña Oasis',
      volumeLiters: 15000,
      waterType: WaterType.salt,
      filterType: FilterType.cartridge,
      shape: 'circular',
      createdAt: DateTime(2023, 6, 1),
    );

    test('Insert and Get All Pools', () async {
      await repository.insertPool(pool1);
      await repository.insertPool(pool2);

      final pools = await repository.getAllPools();
      expect(pools.length, 2);
      expect(pools.any((p) => p.name == 'Piscina Grande'), isTrue);
    });

    test('Search by Name (Partial Match)', () async {
      await repository.insertPool(pool1);
      await repository.insertPool(pool2);

      final results = await repository.searchByName('Grande');
      expect(results.length, 1);
      expect(results.first.name, 'Piscina Grande');

      final results2 = await repository.searchByName('Piscina');
      expect(results2.length, 1);
    });

    test('Filter by Shape', () async {
      await repository.insertPool(pool1);
      await repository.insertPool(pool2);

      final results = await repository.filterByShape('circular');
      expect(results.length, 1);
      expect(results.first.name, 'Pequeña Oasis');
    });

    test('Search by Multiple Criteria - Combined', () async {
      await repository.insertPool(pool1);
      await repository.insertPool(pool2);

      // Search by name and shape
      final filter = SearchFilter(
        searchTerm: 'Piscina',
        shape: 'rectangular',
      );
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.name, 'Piscina Grande');
    });

    test('Search by Multiple Criteria - Date Range', () async {
      await repository.insertPool(pool1);
      await repository.insertPool(pool2);

      final filter = SearchFilter(
        startDate: DateTime(2023, 5, 1),
        endDate: DateTime(2023, 7, 1),
      );
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.name, 'Pequeña Oasis');
    });

    test('Search by Multiple Criteria - Water Type (passed as type)', () async {
      await repository.insertPool(pool1);
      await repository.insertPool(pool2);

      final filter = SearchFilter(type: WaterType.salt.name);
      final results = await repository.searchByMultipleCriteria(filter);
      expect(results.length, 1);
      expect(results.first.name, 'Pequeña Oasis');
    });
  });
}
