
import 'package:pool_solution/domain/entities/chemical_type.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class ChemicalTypeRepository {
  Future<List<ChemicalType>> getAllChemicalTypes();
  Future<ChemicalType?> getChemicalTypeById(int id);
  Future<int> insertChemicalType(ChemicalType chemicalType);
  Future<bool> updateChemicalType(ChemicalType chemicalType);
  Future<bool> deleteChemicalType(int id);

  /// Buscar tipos de químicos por nombre (búsqueda parcial)
  Future<List<ChemicalType>> searchByName(String name);

  /// Filtrar por parámetro objetivo
  Future<List<ChemicalType>> filterByParameterTarget(String parameterTarget);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<ChemicalType>> searchByMultipleCriteria(SearchFilter filter);
}
