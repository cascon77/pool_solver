import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('InventoryEntity', () {
    final chemical = ChemicalEntity(id: 1, name: 'Cloro');
    final inventory = InventoryEntity(
      id: 1,
      chemicalId: 1,
      chemical: chemical,
      stock: 5000,
      minStock: 1000,
      notes: 'Storage A',
    );

    test('Debe crear una InventoryEntity instance', () {
      expect(inventory.id, 1);
      expect(inventory.chemicalId, 1);
      expect(inventory.chemical, chemical);
      expect(inventory.stock, 5000);
      expect(inventory.minStock, 1000);
      expect(inventory.notes, 'Storage A');
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedInventory = inventory.copyWith(stock: 4500, notes: 'Storage B');

      expect(updatedInventory.id, inventory.id);
      expect(updatedInventory.chemicalId, inventory.chemicalId);
      expect(updatedInventory.chemical, inventory.chemical);
      expect(updatedInventory.stock, 4500);
      expect(updatedInventory.minStock, inventory.minStock);
      expect(updatedInventory.notes, 'Storage B');
    });

    test('toJson debe devolver un map valido', () {
      final json = inventory.toJson();

      expect(json['id'], 1);
      expect(json['chemicalId'], 1);
      expect(json['chemical'], isA<Map<String, dynamic>>());
      expect(json['stock'], 5000);
      expect(json['minStock'], 1000);
      expect(json['notes'], 'Storage A');
    });

    test('fromJson debe devolver una instancia valida de InventoryEntity', () {
      final json = {
        'id': 1,
        'chemicalId': 1,
        'chemical': {
          'id': 1,
          'name': 'Cloro',
        },
        'stock': 5000,
        'minStock': 1000,
        'notes': 'Storage A',
      };

      final fromJsonInventory = InventoryEntity.fromJson(json);

      expect(fromJsonInventory.id, 1);
      expect(fromJsonInventory.chemicalId, 1);
      expect(fromJsonInventory.chemical?.id, 1);
      expect(fromJsonInventory.stock, 5000);
      expect(fromJsonInventory.minStock, 1000);
      expect(fromJsonInventory.notes, 'Storage A');
    });

    test('fromJson debe manejar valores nulos', () {
      final fromJsonInventory = InventoryEntity.fromJson({});

      expect(fromJsonInventory.id, isNull);
      expect(fromJsonInventory.chemicalId, isNull);
      expect(fromJsonInventory.chemical, isNull);
      expect(fromJsonInventory.stock, isNull);
      expect(fromJsonInventory.minStock, isNull);
      expect(fromJsonInventory.notes, isNull);
    });
  });
}
