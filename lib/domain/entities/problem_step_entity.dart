import 'package:pool_solution/domain/entities/entities.dart';

class ProblemStepEntity {
  String? id;
  String? problemId;
  ProblemEntity? problem;
  int? stepOrder;
  String? title;
  String? description;
  bool? requiresCalculation;
  String? languageCode;

  ProblemStepEntity({
    this.id,
    this.problemId,
    this.problem,
    this.stepOrder,
    this.title,
    this.description,
    this.requiresCalculation,
    this.languageCode,
  });

  ProblemStepEntity copyWith({
    String? id,
    String? problemId,
    ProblemEntity? problem,
    int? stepOrder,
    String? title,
    String? description,
    bool? requiresCalculation,
    String? languageCode,
  }) {
    return ProblemStepEntity(
      id: id ?? this.id,
      problemId: problemId ?? this.problemId,
      problem: problem ?? this.problem,
      stepOrder: stepOrder ?? this.stepOrder,
      title: title ?? this.title,
      description: description ?? this.description,
      requiresCalculation: requiresCalculation ?? this.requiresCalculation,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  factory ProblemStepEntity.fromJson(Map<String, dynamic> json) {
    return ProblemStepEntity(
      id: json['id'] as String?,
      problemId: json['problemId'] as String?,
      problem: json['problem'] != null
          ? ProblemEntity.fromJson(json['problem'] as Map<String, dynamic>)
          : null,
      stepOrder: json['stepOrder'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      requiresCalculation: json['requiresCalculation'] as bool?,
      languageCode: json['languageCode'] as String?,
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
      'languageCode': languageCode,
    };
  }
}
