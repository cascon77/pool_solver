
import 'package:pool_solution/domain/entities/entities.dart';

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
    this.notes,
  });

  InventoryEntity copyWith({
    int? id,
    int? chemicalId,
    ChemicalEntity? chemical,
    int? stock,
    int? minStock,
    String? notes,
  }) {
    return InventoryEntity(
      id: id ?? this.id,
      chemicalId: chemicalId ?? this.chemicalId,
      chemical: chemical ?? this.chemical,
      stock: stock ?? this.stock,
      minStock: minStock ?? this.minStock,
      notes: notes ?? this.notes,
    );
  }

  factory InventoryEntity.fromJson(Map<String, dynamic> json) {
    return InventoryEntity(
      id: json['id'] as int?,
      chemicalId: json['chemicalId'] as int?,
      chemical: json['chemical'] != null
          ? ChemicalEntity.fromJson(json['chemical'] as Map<String, dynamic>)
          : null,
      stock: json['stock'] as int?,
      minStock: json['minStock'] as int?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chemicalId': chemicalId,
      'chemical': chemical?.toJson(),
      'stock': stock,
      'minStock': minStock,
      'notes': notes,
    };
  }
}
