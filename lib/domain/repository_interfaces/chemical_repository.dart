
import 'package:pool_solution/domain/entities/chemical_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class ChemicalRepository {
  Future<List<ChemicalEntity>> getAllChemicals();
  Future<ChemicalEntity?> getChemicalById(int id);
  Future<int> insertChemical(ChemicalEntity chemical);
  Future<bool> updateChemical(ChemicalEntity chemical);
  Future<bool> deleteChemical(int id);

  /// Buscar químicos por nombre (búsqueda parcial)
  Future<List<ChemicalEntity>> searchByName(String name);

  /// Filtrar químicos por tipo de químico
  Future<List<ChemicalEntity>> filterByChemicalType(int chemicalTypeId);

  /// Filtrar químicos por formato (liquid, tablet, powder)
  Future<List<ChemicalEntity>> filterByFormat(String format);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<ChemicalEntity>> searchByMultipleCriteria(SearchFilter filter);
}
