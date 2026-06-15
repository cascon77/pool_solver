import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('MeasurementEntity', () {
    final now = DateTime.now();
    final pool = PoolEntity(id: 1, name: 'Main Pool');
    final treatment = TreatmentEntity(id: 1, amountUsed: 500.0);
    final measurement = MeasurementEntity(
      id: 1,
      poolId: 1,
      pool: pool,
      date: now,
      ph: 7.2,
      chlorine: 1.5,
      alkalinity: 100.0,
      stabilizer: 40.0,
      salt: 3000.0,
      calciumHardness: 250.0,
      temperature: 25.0,
      notes: 'Morning test',
      treatments: [treatment],
    );

    test('Debe crear una MeasurementEntity instance', () {
      expect(measurement.id, 1);
      expect(measurement.poolId, 1);
      expect(measurement.pool, pool);
      expect(measurement.date, now);
      expect(measurement.ph, 7.2);
      expect(measurement.chlorine, 1.5);
      expect(measurement.alkalinity, 100.0);
      expect(measurement.stabilizer, 40.0);
      expect(measurement.salt, 3000.0);
      expect(measurement.calciumHardness, 250.0);
      expect(measurement.temperature, 25.0);
      expect(measurement.notes, 'Morning test');
      expect(measurement.treatments?.length, 1);
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedMeasurement = measurement.copyWith(ph: 7.4, temperature: 26.0);

      expect(updatedMeasurement.id, measurement.id);
      expect(updatedMeasurement.poolId, measurement.poolId);
      expect(updatedMeasurement.ph, 7.4);
      expect(updatedMeasurement.temperature, 26.0);
      expect(updatedMeasurement.notes, measurement.notes);
    });

    test('toJson debe devolver un map valido', () {
      final json = measurement.toJson();

      expect(json['id'], 1);
      expect(json['poolId'], 1);
      expect(json['pool'], isA<Map<String, dynamic>>());
      expect(json['date'], now.toIso8601String());
      expect(json['ph'], 7.2);
      expect(json['treatments'], isA<List>());
    });

    test('fromJson debe devolver una instancia valida de MeasurementEntity', () {
      final json = {
        'id': 1,
        'poolId': 1,
        'pool': {'id': 1, 'name': 'Main Pool'},
        'date': now.toIso8601String(),
        'ph': 7.2,
        'chlorine': 1.5,
        'treatments': [
          {'id': 1, 'amountUsed': 500.0}
        ],
      };

      final fromJsonMeasurement = MeasurementEntity.fromJson(json);

      expect(fromJsonMeasurement.id, 1);
      expect(fromJsonMeasurement.poolId, 1);
      expect(fromJsonMeasurement.pool?.id, 1);
      expect(fromJsonMeasurement.date, DateTime.parse(now.toIso8601String()));
      expect(fromJsonMeasurement.ph, 7.2);
      expect(fromJsonMeasurement.treatments?.first.id, 1);
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonMeasurement = MeasurementEntity.fromJson({});

      expect(fromJsonMeasurement.id, isNull);
      expect(fromJsonMeasurement.poolId, isNull);
      expect(fromJsonMeasurement.date, isNull);
      expect(fromJsonMeasurement.ph, isNull);
      expect(fromJsonMeasurement.treatments, isNull);
    });
  });
}
