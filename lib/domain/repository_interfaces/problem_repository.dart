import 'package:pool_solution/domain/entities/entities.dart';

abstract class ProblemRepository {
  Future<List<ProblemEntity>> getProblems(String languageCode);
  Future<ProblemEntity?> getProblemById(String id, String languageCode);
  Future<List<ProblemStepEntity>> getProblemSteps(String problemId, String languageCode, {String? level});
}
