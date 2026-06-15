import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('ProblemEntity', () {
    final problem = ProblemEntity(
      id: 'algae',
      name: 'Green Algae',
      description: 'Water turns green',
      category: 'Water Quality',
      languageCode: 'en',
    );

    test('Debe crear una ProblemEntity instance', () {
      expect(problem.id, 'algae');
      expect(problem.name, 'Green Algae');
      expect(problem.description, 'Water turns green');
      expect(problem.category, 'Water Quality');
      expect(problem.languageCode, 'en');
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedProblem = problem.copyWith(name: 'Black Algae', languageCode: 'es');

      expect(updatedProblem.id, problem.id);
      expect(updatedProblem.name, 'Black Algae');
      expect(updatedProblem.description, problem.description);
      expect(updatedProblem.category, problem.category);
      expect(updatedProblem.languageCode, 'es');
    });

    test('toJson debe devolver un map valido', () {
      final json = problem.toJson();

      expect(json['id'], 'algae');
      expect(json['name'], 'Green Algae');
      expect(json['description'], 'Water turns green');
      expect(json['category'], 'Water Quality');
      expect(json['languageCode'], 'en');
    });

    test('fromJson debe devolver una instancia valida de ProblemEntity', () {
      final json = {
        'id': 'algae',
        'name': 'Green Algae',
        'description': 'Water turns green',
        'category': 'Water Quality',
        'languageCode': 'en',
      };

      final fromJsonProblem = ProblemEntity.fromJson(json);

      expect(fromJsonProblem.id, 'algae');
      expect(fromJsonProblem.name, 'Green Algae');
      expect(fromJsonProblem.description, 'Water turns green');
      expect(fromJsonProblem.category, 'Water Quality');
      expect(fromJsonProblem.languageCode, 'en');
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonProblem = ProblemEntity.fromJson({});

      expect(fromJsonProblem.id, isNull);
      expect(fromJsonProblem.name, isNull);
      expect(fromJsonProblem.description, isNull);
      expect(fromJsonProblem.category, isNull);
      expect(fromJsonProblem.languageCode, isNull);
    });
  });
}
