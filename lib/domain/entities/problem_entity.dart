class ProblemEntity {
  String? id;
  String? name;
  String? description;
  String? category;
  String? languageCode;

  ProblemEntity({
    this.id,
    this.name,
    this.description,
    this.category,
    this.languageCode,
  });

  ProblemEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    String? languageCode,
  }) {
    return ProblemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  factory ProblemEntity.fromJson(Map<String, dynamic> json) {
    return ProblemEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      languageCode: json['languageCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'languageCode': languageCode,
    };
  }
}
