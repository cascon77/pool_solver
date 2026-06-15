import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('TreatmentEntity', () {
    final now = DateTime.now();
    final treatment = TreatmentEntity(
      id: 1,
      poolId: 1,
      chemicalId: 2,
      measurementId: 3,
      problemId: 'algae',
      date: now,
      amountUsed: 500.0,
      unit: Unit.g,
      notes: 'Test treatment',
      description: 'Test description',
    );

    test('Debe crear una TreatmentEntity instance', () {
      expect(treatment.id, 1);
      expect(treatment.poolId, 1);
      expect(treatment.chemicalId, 2);
      expect(treatment.measurementId, 3);
      expect(treatment.problemId, 'algae');
      expect(treatment.date, now);
      expect(treatment.amountUsed, 500.0);
      expect(treatment.unit, Unit.g);
      expect(treatment.notes, 'Test treatment');
      expect(treatment.description, 'Test description');
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedTreatment = treatment.copyWith(amountUsed: 600.0, notes: 'Updated notes');

      expect(updatedTreatment.id, treatment.id);
      expect(updatedTreatment.amountUsed, 600.0);
      expect(updatedTreatment.notes, 'Updated notes');
      expect(updatedTreatment.poolId, treatment.poolId);
    });

    test('toJson debe devolver un map valido', () {
      final json = treatment.toJson();

      expect(json['id'], 1);
      expect(json['poolId'], 1);
      expect(json['chemicalId'], 2);
      expect(json['measurementId'], 3);
      expect(json['problemId'], 'algae');
      expect(json['date'], now.toIso8601String());
      expect(json['amountUsed'], 500.0);
      expect(json['unit'], 'g');
      expect(json['notes'], 'Test treatment');
      expect(json['description'], 'Test description');
    });

    test('fromJson debe devolver una instancia valida de TreatmentEntity', () {
      final json = {
        'id': 1,
        'poolId': 1,
        'chemicalId': 2,
        'measurementId': 3,
        'problemId': 'algae',
        'date': now.toIso8601String(),
        'amountUsed': 500.0,
        'unit': 'g',
        'notes': 'Test treatment',
        'description': 'Test description',
      };

      final fromJsonTreatment = TreatmentEntity.fromJson(json);

      expect(fromJsonTreatment.id, 1);
      expect(fromJsonTreatment.poolId, 1);
      expect(fromJsonTreatment.amountUsed, 500.0);
      expect(fromJsonTreatment.unit, Unit.g);
      expect(fromJsonTreatment.date, DateTime.parse(now.toIso8601String()));
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonTreatment = TreatmentEntity.fromJson({});

      expect(fromJsonTreatment.id, isNull);
      expect(fromJsonTreatment.poolId, isNull);
      expect(fromJsonTreatment.amountUsed, isNull);
      expect(fromJsonTreatment.unit, isNull);
      expect(fromJsonTreatment.date, isNull);
    });
  });
}
