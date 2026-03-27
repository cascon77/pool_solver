class TreatmentChemicalEntity {
  final int? id;
  final int treatmentId;
  final int chemicalId;
  final double amountUsed;
  final String unit;

  const TreatmentChemicalEntity({
    this.id,
    required this.treatmentId,
    required this.chemicalId,
    required this.amountUsed,
    required this.unit,
  });
}