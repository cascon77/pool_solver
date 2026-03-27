import 'enums.dart';
import 'pool_entity.dart';
import 'problem_entity.dart';
import 'measurement_entity.dart';

class TreatmentEntity {
  int? id;
  int? poolId;
  PoolEntity? pool;
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
    this.date,
    this.problemId,
    this.problem,
    this.measurementId,
    this.measurement,
    this.amountUsed,
    this.unit,
    this.notes,
  });
}