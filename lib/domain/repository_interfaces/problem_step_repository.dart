
import 'package:pool_solution/domain/entities/problem_step_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class ProblemStepRepository {
  Future<List<ProblemStepEntity>> getAllProblemSteps();
  Future<ProblemStepEntity?> getProblemStepById(int id);
  Future<int> insertProblemStep(ProblemStepEntity step);
  Future<bool> updateProblemStep(ProblemStepEntity step);
  Future<bool> deleteProblemStep(int id);

  /// Obtener pasos de un problema específico (clave secundaria)
  Future<List<ProblemStepEntity>> getByProblemId(int problemId);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<ProblemStepEntity>> searchByMultipleCriteria(SearchFilter filter);
}
