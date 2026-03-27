import 'chemical_entity.dart';

class InventoryEntity {
  int? id;
  int? chemicalId;
  ChemicalEntity? chemical;
  int? stock;
  int? minStock;
  String? notes;

  InventoryEntity({
    this.id,
    this.chemicalId,
    this.chemical,
    this.stock,
    this.minStock,
    this.notes
});
}