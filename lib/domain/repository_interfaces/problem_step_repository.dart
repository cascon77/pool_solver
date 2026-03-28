
import 'package:pool_solution/domain/entities/problem_step_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class ProblemStepRepository {
  /// Obtener todos los pasos de un problema en un idioma específico
  Future<List<ProblemStepEntity>> getAllProblemSteps(String languageCode);

  /// Obtener un paso específico por ID
  Future<ProblemStepEntity?> getProblemStepById(int id);

  /// Insertar un nuevo paso (siempre debe incluir languageCode)
  Future<int> insertProblemStep(ProblemStepEntity step);

  /// Actualizar un paso existente
  Future<bool> updateProblemStep(ProblemStepEntity step);

  /// Eliminar un paso
  Future<bool> deleteProblemStep(int id);

  /// Obtener pasos de un problema específico en un idioma específico
  Future<List<ProblemStepEntity>> getByProblemId(int problemId, String languageCode);

  /// Búsqueda avanzada con múltiples criterios en un idioma específico
  Future<List<ProblemStepEntity>> searchByMultipleCriteria(SearchFilter filter, String languageCode);

  /// Obtener un paso específico en un idioma específico
  Future<ProblemStepEntity?> getByIdAndLanguage(int stepId, String languageCode);

  /// Obtener todos los idiomas disponibles para un paso
  Future<List<String>> getAvailableLanguagesForStep(int stepId);
}
