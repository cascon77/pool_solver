import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('ChemicalEntity', () {
    final chemicalType = ChemicalType(id: 1, name: 'Cloro', parameterTarget: 'cl');
    final chemical = ChemicalEntity(
      id: 1,
      name: 'Cloro Granulado',
      chemicalTypeId: 1,
      chemicalType: chemicalType,
      format: ChemicalFormat.powder,
      concentration: 90.0,
      unit: Unit.g,
    );

    test('Debe crear una instancia de ChemicalEntity', () {
      expect(chemical.id, 1);
      expect(chemical.name, 'Cloro Granulado');
      expect(chemical.chemicalTypeId, 1);
      expect(chemical.chemicalType, chemicalType);
      expect(chemical.format, ChemicalFormat.powder);
      expect(chemical.concentration, 90.0);
      expect(chemical.unit, Unit.g);
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedChemical = chemical.copyWith(name: 'Cloro Líquido', concentration: 10.0);

      expect(updatedChemical.id, chemical.id);
      expect(updatedChemical.name, 'Cloro Líquido');
      expect(updatedChemical.chemicalTypeId, chemical.chemicalTypeId);
      expect(updatedChemical.chemicalType, chemical.chemicalType);
      expect(updatedChemical.format, chemical.format);
      expect(updatedChemical.concentration, 10.0);
      expect(updatedChemical.unit, chemical.unit);
    });

    test('toJson debe devolver un map valido', () {
      final json = chemical.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Cloro Granulado');
      expect(json['chemicalTypeId'], 1);
      expect(json['chemicalType'], isA<Map<String, dynamic>>());
      expect(json['format'], 'powder');
      expect(json['concentration'], 90.0);
      expect(json['unit'], 'g');
    });

    test('fromJson debe devolver una instancia valida de ChemicalEntity', () {
      final json = {
        'id': 1,
        'name': 'Cloro Granulado',
        'chemicalTypeId': 1,
        'chemicalType': {
          'id': 1,
          'name': 'Cloro',
          'parameterTarget': 'cl',
        },
        'format': 'powder',
        'concentration': 90.0,
        'unit': 'g',
      };

      final fromJsonChemical = ChemicalEntity.fromJson(json);

      expect(fromJsonChemical.id, 1);
      expect(fromJsonChemical.name, 'Cloro Granulado');
      expect(fromJsonChemical.chemicalTypeId, 1);
      expect(fromJsonChemical.chemicalType?.id, 1);
      expect(fromJsonChemical.format, ChemicalFormat.powder);
      expect(fromJsonChemical.concentration, 90.0);
      expect(fromJsonChemical.unit, Unit.g);
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonChemical = ChemicalEntity.fromJson({});

      expect(fromJsonChemical.id, isNull);
      expect(fromJsonChemical.name, isNull);
      expect(fromJsonChemical.chemicalTypeId, isNull);
      expect(fromJsonChemical.chemicalType, isNull);
      expect(fromJsonChemical.format, isNull);
      expect(fromJsonChemical.concentration, isNull);
      expect(fromJsonChemical.unit, isNull);
    });
  });
}
