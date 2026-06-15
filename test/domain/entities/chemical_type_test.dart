import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('ChemicalType', () {
    final chemicalType = ChemicalType(
      id: 1,
      name: 'Cloro',
      parameterTarget: 'cl',
    );

    test('Debe crear una ChemicalType instance', () {
      expect(chemicalType.id, 1);
      expect(chemicalType.name, 'Cloro');
      expect(chemicalType.parameterTarget, 'cl');
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedType = chemicalType.copyWith(name: 'pH Increaser', parameterTarget: 'ph');

      expect(updatedType.id, chemicalType.id);
      expect(updatedType.name, 'pH Increaser');
      expect(updatedType.parameterTarget, 'ph');
    });

    test('toJson debe devolver un map valido', () {
      final json = chemicalType.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Cloro');
      expect(json['parameterTarget'], 'cl');
    });

    test('fromJson debe devolver una instancia valida de ChemicalType', () {
      final json = {
        'id': 1,
        'name': 'Cloro',
        'parameterTarget': 'cl',
      };

      final fromJsonType = ChemicalType.fromJson(json);

      expect(fromJsonType.id, 1);
      expect(fromJsonType.name, 'Cloro');
      expect(fromJsonType.parameterTarget, 'cl');
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonType = ChemicalType.fromJson({});

      expect(fromJsonType.id, isNull);
      expect(fromJsonType.name, isNull);
      expect(fromJsonType.parameterTarget, isNull);
    });
  });
}
