/// Clase reutilizable para encapsular parámetros de búsqueda y filtrado
class SearchFilter {
  final String? searchTerm;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? exactDate;
  final int? foreignKeyId;
  final String? format;
  final String? shape;
  final String? category;
  final String? type;
  final int? limit;
  final int? offset;

  SearchFilter({
    this.searchTerm,
    this.startDate,
    this.endDate,
    this.exactDate,
    this.foreignKeyId,
    this.format,
    this.shape,
    this.category,
    this.type,
    this.limit = 100,
    this.offset = 0,
  });

  /// Copia el filtro con valores opcionales nuevos
  SearchFilter copyWith({
    String? searchTerm,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? exactDate,
    int? foreignKeyId,
    String? format,
    String? shape,
    String? category,
    String? type,
    int? limit,
    int? offset,
  }) {
    return SearchFilter(
      searchTerm: searchTerm ?? this.searchTerm,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      exactDate: exactDate ?? this.exactDate,
      foreignKeyId: foreignKeyId ?? this.foreignKeyId,
      format: format ?? this.format,
      shape: shape ?? this.shape,
      category: category ?? this.category,
      type: type ?? this.type,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }
}

