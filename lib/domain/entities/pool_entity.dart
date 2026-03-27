
import 'package:pool_solution/domain/entities/enums.dart';

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
    this.createdAt,
  });

  PoolEntity copyWith({
    int? id,
    String? name,
    double? volumeLiters,
    WaterType? waterType,
    FilterType? filterType,
    String? shape,
    DateTime? createdAt,
  }) {
    return PoolEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      volumeLiters: volumeLiters ?? this.volumeLiters,
      waterType: waterType ?? this.waterType,
      filterType: filterType ?? this.filterType,
      shape: shape ?? this.shape,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory PoolEntity.fromJson(Map<String, dynamic> json) {
    return PoolEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      volumeLiters: (json['volumeLiters'] as num?)?.toDouble(),
      waterType: json['waterType'] != null
          ? WaterType.values.firstWhere((e) => e.name == json['waterType'])
          : null,
      filterType: json['filterType'] != null
          ? FilterType.values.firstWhere((e) => e.name == json['filterType'])
          : null,
      shape: json['shape'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'volumeLiters': volumeLiters,
      'waterType': waterType?.name,
      'filterType': filterType?.name,
      'shape': shape,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
