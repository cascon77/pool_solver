import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/pool_repository.dart';

class PoolRepositoryImpl implements PoolRepository {
  final AppDatabase db;

  PoolRepositoryImpl(this.db);

  @override
  Future<List<PoolEntity>> getAllPools() async {
    return await db.select(db.pools).get();
  }

  @override
  Future<PoolEntity?> getPoolById(int id) async {
    return await (db.select(db.pools)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertPool(PoolEntity pool) {
    return db.into(db.pools).insert(PoolsCompanion.insert(
      name: Value(pool.name),
      volumeLiters: Value(pool.volumeLiters),
      waterType: Value(pool.waterType),
      filterType: Value(pool.filterType),
      shape: Value(pool.shape),
      createdAt: Value(pool.createdAt),
    ));
  }

  @override
  Future<bool> updatePool(PoolEntity pool) {
    return db.update(db.pools).replace(PoolsCompanion(
      id: Value(pool.id!),
      name: Value(pool.name),
      volumeLiters: Value(pool.volumeLiters),
      waterType: Value(pool.waterType),
      filterType: Value(pool.filterType),
      shape: Value(pool.shape),
      createdAt: Value(pool.createdAt),
    ));
  }

  @override
  Future<bool> deletePool(int id) async {
    final count = await (db.delete(db.pools)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<PoolEntity>> searchByName(String name) async {
    return await (db.select(db.pools)
          ..where((t) => t.name.like('%$name%')))
        .get();
  }

  @override
  Future<List<PoolEntity>> filterByShape(String shape) async {
    return await (db.select(db.pools)
          ..where((t) => t.shape.equals(shape)))
        .get();
  }

  @override
  Future<List<PoolEntity>> filterByWaterType(String waterType) async {
    return await (db.select(db.pools)
          ..where((t) => t.waterType.equals(waterType)))
        .get();
  }

  @override
  Future<List<PoolEntity>> filterByFilterType(String filterType) async {
    return await (db.select(db.pools)
          ..where((t) => t.filterType.equals(filterType)))
        .get();
  }

  @override
  Future<List<PoolEntity>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.pools);

    if (filter.searchTerm != null && filter.searchTerm!.isNotEmpty) {
      query = query..where((t) => t.name.like('%${filter.searchTerm!}%'));
    }

    if (filter.shape != null && filter.shape!.isNotEmpty) {
      query = query..where((t) => t.shape.equals(filter.shape!));
    }

    if (filter.type != null && filter.type!.isNotEmpty) {
      // type puede ser waterType o filterType, buscar en ambos
      query = query
        ..where((t) =>
            t.waterType.equals(filter.type!) | t.filterType.equals(filter.type!));
    }

    if (filter.startDate != null && filter.endDate != null) {
      query = query
        ..where((t) =>
            t.createdAt.isBiggerOrEqualValue(filter.startDate!) &
            t.createdAt.isSmallerOrEqualValue(filter.endDate!));
    } else if (filter.exactDate != null) {
      query = query..where((t) => t.createdAt.equals(filter.exactDate!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }
}
