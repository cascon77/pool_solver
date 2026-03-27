
import 'package:pool_solution/domain/entities/inventory_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class InventoryRepository {
  Future<List<InventoryEntity>> getAllInventory();
  Future<InventoryEntity?> getInventoryById(int id);
  Future<int> insertInventory(InventoryEntity inventory);
  Future<bool> updateInventory(InventoryEntity inventory);
  Future<bool> deleteInventory(int id);

  /// Obtener inventario por químico (clave secundaria)
  Future<InventoryEntity?> getByChemicalId(int chemicalId);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<InventoryEntity>> searchByMultipleCriteria(SearchFilter filter);
}
