class Measurement {
  int? id;
  int pool_id;
  DateTime date;
  double ph;
  double chlorine;
  double? alkalinity;
  double? stabilizer;
  double? salt;
  double? calcium_hardness;
  String? notes;

  Measurement({
    this.id,
    required this.pool_id,
    required this.date,
    required this.ph,
    required this.chlorine,
    this.alkalinity,
    this.stabilizer,
    this.salt,
    this.calcium_hardness,
    this.notes
  });

}