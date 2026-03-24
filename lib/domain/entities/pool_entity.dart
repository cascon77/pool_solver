
class PoolEntity {
  int? id;
  String name;
  double volume_liters;
  String water_type;
  String filter_type;
  String? shape;
  DateTime? created_at;

  PoolEntity({
    this.id,
    required this.name,
    required this.volume_liters,
    required this.water_type,
    required this.filter_type,
    this.shape,
    this.created_at
  });


}