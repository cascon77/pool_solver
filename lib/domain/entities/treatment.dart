class Treatment {
  int? id;
  int pool_id;
  int chemical_id;
  int measurement_id;
  int problem_id;
  DateTime date;
  double? amount_used;
  String unit;
  String notes;

  Treatment({
    this.id,
    required this.pool_id,
    required this.chemical_id,
    required this.measurement_id,
    required this.problem_id,
    required this.date,
    this.amount_used,
    required this.unit,
    required this.notes
  });
}