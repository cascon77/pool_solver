import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/inventory_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/inventory_repository.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final AppDatabase db;

  InventoryRepositoryImpl(this.db);

  @override
  Future<List<InventoryEntity>> getAllInventory() async {
    return await db.select(db.inventories).get();
  }

  @override
  Future<InventoryEntity?> getInventoryById(int id) async {
    return await (db.select(db.inventories)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertInventory(InventoryEntity inventory) {
    return db.into(db.inventories).insert(InventoriesCompanion.insert(
      chemicalId: Value(inventory.chemicalId),
      stock: Value(inventory.stock),
      minStock: Value(inventory.minStock),
      notes: Value(inventory.notes),
    ));
  }

  @override
  Future<bool> updateInventory(InventoryEntity inventory) {
    return db.update(db.inventories).replace(InventoriesCompanion(
      id: Value(inventory.id!),
      chemicalId: Value(inventory.chemicalId),
      stock: Value(inventory.stock),
      minStock: Value(inventory.minStock),
      notes: Value(inventory.notes),
    ));
  }

  @override
  Future<bool> deleteInventory(int id) async {
    final count = await (db.delete(db.inventories)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<InventoryEntity?> getByChemicalId(int chemicalId) async {
    return await (db.select(db.inventories)
          ..where((t) => t.chemicalId.equals(chemicalId)))
        .getSingleOrNull();
  }

  @override
  Future<List<InventoryEntity>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.inventories);

    if (filter.foreignKeyId != null) {
      query = query..where((t) => t.chemicalId.equals(filter.foreignKeyId!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }
}
