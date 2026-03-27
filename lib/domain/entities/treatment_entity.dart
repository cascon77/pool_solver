
import 'package:pool_solution/domain/entities/chemical_entity.dart';
import 'package:pool_solution/domain/entities/enums.dart';
import 'package:pool_solution/domain/entities/measurement_entity.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/domain/entities/problem_entity.dart';

class TreatmentEntity {
  int? id;
  int? poolId;
  PoolEntity? pool;
  int? chemicalId;
  ChemicalEntity? chemical;
  DateTime? date;
  int? problemId;
  ProblemEntity? problem;
  int? measurementId;
  MeasurementEntity? measurement;
  double? amountUsed;
  Unit? unit;
  String? notes;

  TreatmentEntity({
    this.id,
    this.poolId,
    this.pool,
    this.chemicalId,
    this.chemical,
    this.date,
    this.problemId,
    this.problem,
    this.measurementId,
    this.measurement,
    this.amountUsed,
    this.unit,
    this.notes,
  });

  TreatmentEntity copyWith({
    int? id,
    int? poolId,
    PoolEntity? pool,
    int? chemicalId,
    ChemicalEntity? chemical,
    DateTime? date,
    int? problemId,
    ProblemEntity? problem,
    int? measurementId,
    MeasurementEntity? measurement,
    double? amountUsed,
    Unit? unit,
    String? notes,
  }) {
    return TreatmentEntity(
      id: id ?? this.id,
      poolId: poolId ?? this.poolId,
      pool: pool ?? this.pool,
      chemicalId: chemicalId ?? this.chemicalId,
      chemical: chemical ?? this.chemical,
      date: date ?? this.date,
      problemId: problemId ?? this.problemId,
      problem: problem ?? this.problem,
      measurementId: measurementId ?? this.measurementId,
      measurement: measurement ?? this.measurement,
      amountUsed: amountUsed ?? this.amountUsed,
      unit: unit ?? this.unit,
      notes: notes ?? this.notes,
    );
  }

  factory TreatmentEntity.fromJson(Map<String, dynamic> json) {
    return TreatmentEntity(
      id: json['id'] as int?,
      poolId: json['poolId'] as int?,
      pool: json['pool'] != null
          ? PoolEntity.fromJson(json['pool'] as Map<String, dynamic>)
          : null,
      chemicalId: json['chemicalId'] as int?,
      chemical: json['chemical'] != null
          ? ChemicalEntity.fromJson(json['chemical'] as Map<String, dynamic>)
          : null,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      problemId: json['problemId'] as int?,
      problem: json['problem'] != null
          ? ProblemEntity.fromJson(json['problem'] as Map<String, dynamic>)
          : null,
      measurementId: json['measurementId'] as int?,
      measurement: json['measurement'] != null
          ? MeasurementEntity.fromJson(
              json['measurement'] as Map<String, dynamic>)
          : null,
      amountUsed: (json['amountUsed'] as num?)?.toDouble(),
      unit: json['unit'] != null
          ? Unit.values.firstWhere((e) => e.name == json['unit'])
          : null,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poolId': poolId,
      'pool': pool?.toJson(),
      'chemicalId': chemicalId,
      'chemical': chemical?.toJson(),
      'date': date?.toIso8601String(),
      'problemId': problemId,
      'problem': problem?.toJson(),
      'measurementId': measurementId,
      'measurement': measurement?.toJson(),
      'amountUsed': amountUsed,
      'unit': unit?.name,
      'notes': notes,
    };
  }
}
