import 'enums.dart';
import 'chemical_type.dart';

class ChemicalEntity {
  int? id;
  String name;
  int? chemicalTypeId;
  ChemicalType? chemicalType;
  ChemicalFormat? format;
  int? concentration;
  Unit? unit;

  ChemicalEntity({
    this.id,
    required this.name,
    this.chemicalTypeId,
    this.chemicalType,
    this.format,
    this.concentration,
    this.unit
  });
}