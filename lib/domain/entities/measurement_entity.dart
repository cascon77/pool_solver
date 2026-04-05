import 'package:pool_solution/domain/entities/entities.dart';

class MeasurementEntity {
  int? id;
  int? poolId;
  PoolEntity? pool;
  DateTime? date;
  double? ph;
  double? chlorine;
  double? alkalinity;
  double? stabilizer;
  double? salt;
  double? calciumHardness;
  String? notes;
  List<TreatmentEntity>? treatments;

  MeasurementEntity({
    this.id,
    this.poolId,
    this.pool,
    this.date,
    this.ph,
    this.chlorine,
    this.alkalinity,
    this.stabilizer,
    this.salt,
    this.calciumHardness,
    this.notes,
    this.treatments,
  });

  MeasurementEntity copyWith({
    int? id,
    int? poolId,
    PoolEntity? pool,
    DateTime? date,
    double? ph,
    double? chlorine,
    double? alkalinity,
    double? stabilizer,
    double? salt,
    double? calciumHardness,
    String? notes,
    List<TreatmentEntity>? treatments,
  }) {
    return MeasurementEntity(
      id: id ?? this.id,
      poolId: poolId ?? this.poolId,
      pool: pool ?? this.pool,
      date: date ?? this.date,
      ph: ph ?? this.ph,
      chlorine: chlorine ?? this.chlorine,
      alkalinity: alkalinity ?? this.alkalinity,
      stabilizer: stabilizer ?? this.stabilizer,
      salt: salt ?? this.salt,
      calciumHardness: calciumHardness ?? this.calciumHardness,
      notes: notes ?? this.notes,
      treatments: treatments ?? this.treatments,
    );
  }

  factory MeasurementEntity.fromJson(Map<String, dynamic> json) {
    return MeasurementEntity(
      id: json['id'] as int?,
      poolId: json['poolId'] as int?,
      pool: json['pool'] != null
          ? PoolEntity.fromJson(json['pool'] as Map<String, dynamic>)
          : null,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      ph: (json['ph'] as num?)?.toDouble(),
      chlorine: (json['chlorine'] as num?)?.toDouble(),
      alkalinity: (json['alkalinity'] as num?)?.toDouble(),
      stabilizer: (json['stabilizer'] as num?)?.toDouble(),
      salt: (json['salt'] as num?)?.toDouble(),
      calciumHardness: (json['calciumHardness'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      treatments: json['treatments'] != null
          ? (json['treatments'] as List)
              .map((i) => TreatmentEntity.fromJson(i as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poolId': poolId,
      'pool': pool?.toJson(),
      'date': date?.toIso8601String(),
      'ph': ph,
      'chlorine': chlorine,
      'alkalinity': alkalinity,
      'stabilizer': stabilizer,
      'salt': salt,
      'calciumHardness': calciumHardness,
      'notes': notes,
      'treatments': treatments?.map((e) => e.toJson()).toList(),
    };
  }
}
