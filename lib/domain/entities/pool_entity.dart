
import 'enums.dart';

class PoolEntity {
  int? id;
  String? name;
  double? volumeLiters;
  WaterType? waterType;
  FilterType? filterType;
  String? shape;
  DateTime? createdAt;

  PoolEntity({
    this.id,
    this.name,
    this.volumeLiters,
    this.waterType,
    this.filterType,
    this.shape,
    this.createdAt
  });
}