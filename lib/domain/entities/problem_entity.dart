class ProblemEntity {
  int? id;
  String? name;
  String? description;
  String? category;

  ProblemEntity({
    this.id,
    this.name,
    this.description,
    this.category,
  });

  ProblemEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? category,
  }) {
    return ProblemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  factory ProblemEntity.fromJson(Map<String, dynamic> json) {
    return ProblemEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
    };
  }
}
