
import 'package:pool_solution/domain/entities/problem_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class ProblemRepository {
  /// Obtener todos los problemas en un idioma específico
  Future<List<ProblemEntity>> getAllProblems(String languageCode);

  /// Obtener un problema específico por ID
  Future<ProblemEntity?> getProblemById(int id);

  /// Insertar un nuevo problema (siempre debe incluir languageCode)
  Future<int> insertProblem(ProblemEntity problem);

  /// Actualizar un problema existente
  Future<bool> updateProblem(ProblemEntity problem);

  /// Eliminar un problema
  Future<bool> deleteProblem(int id);

  /// Buscar problemas por nombre en un idioma específico
  Future<List<ProblemEntity>> searchByName(String name, String languageCode);

  /// Filtrar problemas por categoría en un idioma específico
  Future<List<ProblemEntity>> filterByCategory(String category, String languageCode);

  /// Búsqueda avanzada con múltiples criterios en un idioma específico
  Future<List<ProblemEntity>> searchByMultipleCriteria(SearchFilter filter, String languageCode);

  /// Obtener un problema en un idioma específico
  Future<ProblemEntity?> getProblemByIdAndLanguage(int id, String languageCode);

  /// Obtener todos los idiomas disponibles para un problema
  Future<List<String>> getAvailableLanguagesForProblem(int problemId);
}
