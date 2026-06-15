import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('ProblemStepEntity', () {
    final problem = ProblemEntity(id: 'algae', name: 'Algae');
    final step = ProblemStepEntity(
      id: 'step1',
      problemId: 'algae',
      problem: problem,
      stepOrder: 1,
      title: 'Brush Walls',
      description: 'Brush all walls thoroughly',
      requiresCalculation: false,
      languageCode: 'en',
    );

    test('Debe crear una ProblemStepEntity instance', () {
      expect(step.id, 'step1');
      expect(step.problemId, 'algae');
      expect(step.problem, problem);
      expect(step.stepOrder, 1);
      expect(step.title, 'Brush Walls');
      expect(step.description, 'Brush all walls thoroughly');
      expect(step.requiresCalculation, false);
      expect(step.languageCode, 'en');
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedStep = step.copyWith(title: 'Updated Title', stepOrder: 2);

      expect(updatedStep.id, step.id);
      expect(updatedStep.problemId, step.problemId);
      expect(updatedStep.problem, step.problem);
      expect(updatedStep.stepOrder, 2);
      expect(updatedStep.title, 'Updated Title');
      expect(updatedStep.description, step.description);
      expect(updatedStep.requiresCalculation, step.requiresCalculation);
      expect(updatedStep.languageCode, step.languageCode);
    });

    test('toJson debe devolver un map valido', () {
      final json = step.toJson();

      expect(json['id'], 'step1');
      expect(json['problemId'], 'algae');
      expect(json['problem'], isA<Map<String, dynamic>>());
      expect(json['stepOrder'], 1);
      expect(json['title'], 'Brush Walls');
      expect(json['requiresCalculation'], false);
    });

    test('fromJson debe devolver una instancia valida de ProblemStepEntity', () {
      final json = {
        'id': 'step1',
        'problemId': 'algae',
        'problem': {'id': 'algae', 'name': 'Algae'},
        'stepOrder': 1,
        'title': 'Brush Walls',
        'description': 'Brush all walls thoroughly',
        'requiresCalculation': false,
        'languageCode': 'en',
      };

      final fromJsonStep = ProblemStepEntity.fromJson(json);

      expect(fromJsonStep.id, 'step1');
      expect(fromJsonStep.problemId, 'algae');
      expect(fromJsonStep.problem?.id, 'algae');
      expect(fromJsonStep.stepOrder, 1);
      expect(fromJsonStep.title, 'Brush Walls');
      expect(fromJsonStep.requiresCalculation, false);
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonStep = ProblemStepEntity.fromJson({});

      expect(fromJsonStep.id, isNull);
      expect(fromJsonStep.problemId, isNull);
      expect(fromJsonStep.problem, isNull);
      expect(fromJsonStep.stepOrder, isNull);
      expect(fromJsonStep.title, isNull);
      expect(fromJsonStep.requiresCalculation, isNull);
    });
  });
}
