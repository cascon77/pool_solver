

import 'package:pool_solution/domain/entities/entities.dart';

class ChemicalEntity {
  int? id;
  String? name;
  int? chemicalTypeId;
  ChemicalType? chemicalType;
  ChemicalFormat? format;
  double? concentration;
  Unit? unit;

  ChemicalEntity({
    this.id,
    this.name,
    this.chemicalTypeId,
    this.chemicalType,
    this.format,
    this.concentration,
    this.unit
  });

  ChemicalEntity copyWith({
    int? id,
    String? name,
    int? chemicalTypeId,
    ChemicalType? chemicalType,
    ChemicalFormat? format,
    double? concentration,
    Unit? unit,
  }) {
    return ChemicalEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      chemicalTypeId: chemicalTypeId ?? this.chemicalTypeId,
      chemicalType: chemicalType ?? this.chemicalType,
      format: format ?? this.format,
      concentration: concentration ?? this.concentration,
      unit: unit ?? this.unit,
    );
  }

  factory ChemicalEntity.fromJson(Map<String, dynamic> json) {
    return ChemicalEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      chemicalTypeId: json['chemicalTypeId'] as int?,
      chemicalType: json['chemicalType'] != null
          ? ChemicalType.fromJson(json['chemicalType'] as Map<String, dynamic>)
          : null,
      format: json['format'] != null
          ? ChemicalFormat.values.firstWhere((e) => e.name == json['format'])
          : null,
      concentration: json['concentration'] as double?,
      unit: json['unit'] != null
          ? Unit.values.firstWhere((e) => e.name == json['unit'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'chemicalTypeId': chemicalTypeId,
      'chemicalType': chemicalType?.toJson(),
      'format': format?.name,
      'concentration': concentration,
      'unit': unit?.name,
    };
  }
}
