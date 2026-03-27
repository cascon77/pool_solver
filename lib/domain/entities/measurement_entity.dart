import 'pool_entity.dart';

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
    this.notes
  });

}