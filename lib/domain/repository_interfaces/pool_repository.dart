
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class PoolRepository {
  Future<List<PoolEntity>> getAllPools();
  Future<PoolEntity?> getPoolById(int id);
  Future<int> insertPool(PoolEntity pool);
  Future<bool> updatePool(PoolEntity pool);
  Future<bool> deletePool(int id);

  /// Buscar piscinas por nombre (búsqueda parcial)
  Future<List<PoolEntity>> searchByName(String name);

  /// Filtrar piscinas por forma
  Future<List<PoolEntity>> filterByShape(String shape);

  /// Filtrar piscinas por tipo de agua
  Future<List<PoolEntity>> filterByWaterType(String waterType);

  /// Filtrar piscinas por tipo de filtro
  Future<List<PoolEntity>> filterByFilterType(String filterType);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<PoolEntity>> searchByMultipleCriteria(SearchFilter filter);
}
