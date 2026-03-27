import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/problem_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/problem_repository.dart';

class ProblemRepositoryImpl implements ProblemRepository {
  final AppDatabase db;

  ProblemRepositoryImpl(this.db);

  @override
  Future<List<ProblemEntity>> getAllProblems() async {
    return await db.select(db.problems).get();
  }

  @override
  Future<ProblemEntity?> getProblemById(int id) async {
    return await (db.select(db.problems)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertProblem(ProblemEntity problem) {
    return db.into(db.problems).insert(ProblemsCompanion.insert(
      name: Value(problem.name),
      description: Value(problem.description),
      category: Value(problem.category),
    ));
  }

  @override
  Future<bool> updateProblem(ProblemEntity problem) {
    return db.update(db.problems).replace(ProblemsCompanion(
      id: Value(problem.id!),
      name: Value(problem.name),
      description: Value(problem.description),
      category: Value(problem.category),
    ));
  }

  @override
  Future<bool> deleteProblem(int id) async {
    final count = await (db.delete(db.problems)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<ProblemEntity>> searchByName(String name) async {
    return await (db.select(db.problems)
          ..where((t) => t.name.like('%$name%')))
        .get();
  }

  @override
  Future<List<ProblemEntity>> filterByCategory(String category) async {
    return await (db.select(db.problems)
          ..where((t) => t.category.equals(category)))
        .get();
  }

  @override
  Future<List<ProblemEntity>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.problems);

    if (filter.searchTerm != null && filter.searchTerm!.isNotEmpty) {
      query = query..where((t) => t.name.like('%${filter.searchTerm!}%'));
    }

    if (filter.category != null && filter.category!.isNotEmpty) {
      query = query..where((t) => t.category.equals(filter.category!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }
}
