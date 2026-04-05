import 'package:pool_solution/domain/entities/entities.dart';

class TreatmentEntity {
  int? id;
  int? poolId;
  int? chemicalId;
  int? measurementId;
  String? problemId;
  DateTime? date;
  double? amountUsed;
  Unit? unit;
  String? notes;

  // Campo UI (no persiste en BD, se carga con join si se necesita)
  String? description;

  TreatmentEntity({
    this.id,
    this.poolId,
    this.chemicalId,
    this.measurementId,
    this.problemId,
    this.date,
    this.amountUsed,
    this.unit,
    this.notes,
    this.description,
  });

  TreatmentEntity copyWith({
    int? id,
    int? poolId,
    int? chemicalId,
    int? measurementId,
    String? problemId,
    DateTime? date,
    double? amountUsed,
    Unit? unit,
    String? notes,
    String? description,
  }) {
    return TreatmentEntity(
      id: id ?? this.id,
      poolId: poolId ?? this.poolId,
      chemicalId: chemicalId ?? this.chemicalId,
      measurementId: measurementId ?? this.measurementId,
      problemId: problemId ?? this.problemId,
      date: date ?? this.date,
      amountUsed: amountUsed ?? this.amountUsed,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
      description: description ?? this.description,
    );
  }

  factory TreatmentEntity.fromJson(Map<String, dynamic> json) {
    return TreatmentEntity(
      id: json['id'] as int?,
      poolId: json['poolId'] as int?,
      chemicalId: json['chemicalId'] as int?,
      measurementId: json['measurementId'] as int?,
      problemId: json['problemId'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      amountUsed: (json['amountUsed'] as num?)?.toDouble(),
      unit: json['unit'] != null
          ? Unit.values.firstWhere((e) => e.name == json['unit'])
          : null,
      notes: json['notes'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poolId': poolId,
      'chemicalId': chemicalId,
      'measurementId': measurementId,
      'problemId': problemId,
      'date': date?.toIso8601String(),
      'amountUsed': amountUsed,
      'unit': unit?.name,
      'notes': notes,
      'description': description,
    };
  }
}
