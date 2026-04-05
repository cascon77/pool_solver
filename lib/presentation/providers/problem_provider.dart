import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/repositories/problem_repository_impl.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/problem_repository.dart';

final problemRepositoryProvider = Provider<ProblemRepository>((ref) {
  return ProblemRepositoryImpl();
});

final problemsProvider = FutureProvider.family<List<ProblemEntity>, String>((ref, languageCode) async {
  final repository = ref.watch(problemRepositoryProvider);
  return repository.getProblems(languageCode);
});

final problemStepsProvider = FutureProvider.family<List<ProblemStepEntity>, ({String id, String lang, String? level})>((ref, params) async {
  final repository = ref.watch(problemRepositoryProvider);
  return repository.getProblemSteps(params.id, params.lang, level: params.level);
});
