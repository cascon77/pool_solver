class ChemicalType {
  int? id;
  String? name;
  String? parameterTarget;

  ChemicalType({
    this.id,
    this.name,
    this.parameterTarget,
  });

  ChemicalType copyWith({
    int? id,
    String? name,
    String? parameterTarget,
  }) {
    return ChemicalType(
      id: id ?? this.id,
      name: name ?? this.name,
      parameterTarget: parameterTarget ?? this.parameterTarget,
    );
  }

  factory ChemicalType.fromJson(Map<String, dynamic> json) {
    return ChemicalType(
      id: json['id'] as int?,
      name: json['name'] as String?,
      parameterTarget: json['parameterTarget'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parameterTarget': parameterTarget,
    };
  }
}
