
import 'package:pool_solution/domain/entities/problem_entity.dart';

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

  ProblemStepEntity copyWith({
    int? id,
    int? problemId,
    ProblemEntity? problem,
    int? stepOrder,
    String? title,
    String? description,
    bool? requiresCalculation,
  }) {
    return ProblemStepEntity(
      id: id ?? this.id,
      problemId: problemId ?? this.problemId,
      problem: problem ?? this.problem,
      stepOrder: stepOrder ?? this.stepOrder,
      title: title ?? this.title,
      description: description ?? this.description,
      requiresCalculation: requiresCalculation ?? this.requiresCalculation,
    );
  }

  factory ProblemStepEntity.fromJson(Map<String, dynamic> json) {
    return ProblemStepEntity(
      id: json['id'] as int?,
      problemId: json['problemId'] as int?,
      problem: json['problem'] != null
          ? ProblemEntity.fromJson(json['problem'] as Map<String, dynamic>)
          : null,
      stepOrder: json['stepOrder'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      requiresCalculation: json['requiresCalculation'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'problemId': problemId,
      'problem': problem?.toJson(),
      'stepOrder': stepOrder,
      'title': title,
      'description': description,
      'requiresCalculation': requiresCalculation,
    };
  }
}
