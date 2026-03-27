import 'problem_entity.dart';

class ProblemStepEntity {
  int? id;
  int? problemId;
  ProblemEntity? problem;
  int? stepOrder;
  String? title;
  String? description;
  bool? requiresCalculation;

  ProblemStepEntity({
    this.id,
    this.problemId,
    this.problem,
    this.stepOrder,
    this.title,
    this.description,
    this.requiresCalculation,
  });
}