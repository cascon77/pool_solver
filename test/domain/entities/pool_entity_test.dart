import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('PoolEntity', () {
    final now = DateTime.now();
    final pool = PoolEntity(
      id: 1,
      name: 'Test Pool',
      volumeLiters: 10000.0,
      waterType: WaterType.chlorine,
      filterType: FilterType.sand,
      shape: 'Rectangular',
      createdAt: now,
    );

    test('Debe crear una PoolEntity instance', () {
      expect(pool.id, 1);
      expect(pool.name, 'Test Pool');
      expect(pool.volumeLiters, 10000.0);
      expect(pool.waterType, WaterType.chlorine);
      expect(pool.filterType, FilterType.sand);
      expect(pool.shape, 'Rectangular');
      expect(pool.createdAt, now);
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedPool = pool.copyWith(name: 'Updated Pool', volumeLiters: 12000.0);

      expect(updatedPool.id, pool.id);
      expect(updatedPool.name, 'Updated Pool');
      expect(updatedPool.volumeLiters, 12000.0);
      expect(updatedPool.waterType, pool.waterType);
      expect(updatedPool.filterType, pool.filterType);
      expect(updatedPool.shape, pool.shape);
      expect(updatedPool.createdAt, pool.createdAt);
    });

    test('toJson debe devolver un map valido', () {
      final json = pool.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'Test Pool');
      expect(json['volumeLiters'], 10000.0);
      expect(json['waterType'], 'chlorine');
      expect(json['filterType'], 'sand');
      expect(json['shape'], 'Rectangular');
      expect(json['createdAt'], now.toIso8601String());
    });

    test('fromJson debe devolver una instancia valida de PoolEntity', () {
      final json = {
        'id': 1,
        'name': 'Test Pool',
        'volumeLiters': 10000.0,
        'waterType': 'chlorine',
        'filterType': 'sand',
        'shape': 'Rectangular',
        'createdAt': now.toIso8601String(),
      };

      final fromJsonPool = PoolEntity.fromJson(json);

      expect(fromJsonPool.id, 1);
      expect(fromJsonPool.name, 'Test Pool');
      expect(fromJsonPool.volumeLiters, 10000.0);
      expect(fromJsonPool.waterType, WaterType.chlorine);
      expect(fromJsonPool.filterType, FilterType.sand);
      expect(fromJsonPool.shape, 'Rectangular');
      expect(fromJsonPool.createdAt, DateTime.parse(now.toIso8601String()));
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonPool = PoolEntity.fromJson({});

      expect(fromJsonPool.id, isNull);
      expect(fromJsonPool.name, isNull);
      expect(fromJsonPool.volumeLiters, isNull);
      expect(fromJsonPool.waterType, isNull);
      expect(fromJsonPool.filterType, isNull);
      expect(fromJsonPool.shape, isNull);
      expect(fromJsonPool.createdAt, isNull);
    });
  });
}
