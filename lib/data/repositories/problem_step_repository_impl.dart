import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/problem_step_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/problem_step_repository.dart';

class ProblemStepRepositoryImpl implements ProblemStepRepository {
  final AppDatabase db;

  ProblemStepRepositoryImpl(this.db);

  @override
  Future<List<ProblemStepEntity>> getAllProblemSteps(String languageCode) async {
    return await (db.select(db.problemSteps)
          ..where((t) => t.languageCode.equals(languageCode)))
        .get();
  }

  @override
  Future<ProblemStepEntity?> getProblemStepById(int id) async {
    return await (db.select(db.problemSteps)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertProblemStep(ProblemStepEntity step) {
    return db.into(db.problemSteps).insert(ProblemStepsCompanion.insert(
      problemId: Value(step.problemId),
      stepOrder: Value(step.stepOrder),
      title: Value(step.title),
      description: Value(step.description),
      requiresCalculation: Value(step.requiresCalculation),
      languageCode: Value(step.languageCode ?? 'es'),
    ));
  }

  @override
  Future<bool> updateProblemStep(ProblemStepEntity step) {
    return db.update(db.problemSteps).replace(ProblemStepsCompanion(
      id: Value(step.id!),
      problemId: Value(step.problemId),
      stepOrder: Value(step.stepOrder),
      title: Value(step.title),
      description: Value(step.description),
      requiresCalculation: Value(step.requiresCalculation),
      languageCode: Value(step.languageCode ?? 'es'),
    ));
  }

  @override
  Future<bool> deleteProblemStep(int id) async {
    final count = await (db.delete(db.problemSteps)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<ProblemStepEntity>> getByProblemId(int problemId, String languageCode) async {
    return await (db.select(db.problemSteps)
          ..where((t) => t.problemId.equals(problemId) & t.languageCode.equals(languageCode))
          ..orderBy([(t) => OrderingTerm(expression: t.stepOrder)]))
        .get();
  }

  @override
  Future<List<ProblemStepEntity>> searchByMultipleCriteria(SearchFilter filter, String languageCode) async {
    var query = db.select(db.problemSteps)..where((t) => t.languageCode.equals(languageCode));

    if (filter.foreignKeyId != null) {
      query = query..where((t) => t.problemId.equals(filter.foreignKeyId!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }

  @override
  Future<ProblemStepEntity?> getByIdAndLanguage(int stepId, String languageCode) async {
    return await (db.select(db.problemSteps)
          ..where((t) => t.id.equals(stepId) & t.languageCode.equals(languageCode)))
        .getSingleOrNull();
  }

  @override
  Future<List<String>> getAvailableLanguagesForStep(int stepId) async {
    final steps = await (db.select(db.problemSteps, distinct: true)
          ..where((t) => t.id.equals(stepId)))
        .get();
    
    return steps.map((s) => s.languageCode ?? 'es').toList();
  }
}
