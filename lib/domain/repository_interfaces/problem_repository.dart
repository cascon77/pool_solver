
import 'package:pool_solution/domain/entities/problem_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class ProblemRepository {
  Future<List<ProblemEntity>> getAllProblems();
  Future<ProblemEntity?> getProblemById(int id);
  Future<int> insertProblem(ProblemEntity problem);
  Future<bool> updateProblem(ProblemEntity problem);
  Future<bool> deleteProblem(int id);

  /// Buscar problemas por nombre (búsqueda parcial)
  Future<List<ProblemEntity>> searchByName(String name);

  /// Filtrar problemas por categoría
  Future<List<ProblemEntity>> filterByCategory(String category);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<ProblemEntity>> searchByMultipleCriteria(SearchFilter filter);
}
