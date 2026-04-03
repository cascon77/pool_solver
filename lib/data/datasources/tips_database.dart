import 'package:pool_solution/domain/entities/tip_entity.dart';

class TipsDatabase {
  static const List<TipEntity> allTips = [
    // Consejos Generales para TODOS
    TipEntity(
      id: 1,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 2,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 3,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 4,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 5,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),

    // Consejos ESPECÍFICOS para LONA
    TipEntity(
      id: 6,
      category: 'lona',
      poolType: 'lona',
    ),
    TipEntity(
      id: 7,
      category: 'lona',
      poolType: 'lona',
    ),
    TipEntity(
      id: 8,
      category: 'lona',
      poolType: 'lona',
    ),

    // Consejos ESPECÍFICOS para OBRA
    TipEntity(
      id: 9,
      category: 'obra',
      poolType: 'obra',
    ),
    TipEntity(
      id: 10,
      category: 'obra',
      poolType: 'obra',
    ),
    TipEntity(
      id: 11,
      category: 'obra',
      poolType: 'obra',
    ),

    // Consejos para CLORO TRADICIONAL
    TipEntity(
      id: 12,
      category: 'cloro',
      chemicalType: 'cloro',
    ),
    TipEntity(
      id: 13,
      category: 'cloro',
      chemicalType: 'cloro',
    ),
    TipEntity(
      id: 14,
      category: 'cloro',
      chemicalType: 'cloro',
    ),

    // Consejos para CLORO SALINA
    TipEntity(
      id: 15,
      category: 'cloro',
      chemicalType: 'salina',
    ),
    TipEntity(
      id: 16,
      category: 'cloro',
      chemicalType: 'salina',
    ),
    TipEntity(
      id: 17,
      category: 'cloro',
      chemicalType: 'salina',
    ),

    // Consejos para FILTRO DE ARENA
    TipEntity(
      id: 18,
      category: 'filtro',
      filterType: 'arena',
    ),
    TipEntity(
      id: 19,
      category: 'filtro',
      filterType: 'arena',
    ),
    TipEntity(
      id: 20,
      category: 'filtro',
      filterType: 'arena',
    ),

    // Consejos para FILTRO DE CARTUCHO
    TipEntity(
      id: 21,
      category: 'filtro',
      filterType: 'cartucho',
    ),
    TipEntity(
      id: 22,
      category: 'filtro',
      filterType: 'cartucho',
    ),
    TipEntity(
      id: 23,
      category: 'filtro',
      filterType: 'cartucho',
    ),

    // Consejos para FILTRO DE DIATOMEA
    TipEntity(
      id: 24,
      category: 'filtro',
      filterType: 'diatomea',
    ),
    TipEntity(
      id: 25,
      category: 'filtro',
      filterType: 'diatomea',
    ),
    TipEntity(
      id: 26,
      category: 'filtro',
      filterType: 'diatomea',
    ),

    // Consejos adicionales generales
    TipEntity(
      id: 27,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 28,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 29,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
    TipEntity(
      id: 30,
      category: 'general',
      poolType: 'all',
      filterType: 'all',
      chemicalType: 'all',
    ),
  ];

  /// Get all tips
  static List<TipEntity> getAllTips() {
    return allTips;
  }

  /// Get tips by category
  static List<TipEntity> getTipsByCategory(String category) {
    return allTips.where((tip) => tip.category == category).toList();
  }

  /// Get tips filtered by pool configuration
  static List<TipEntity> getTipsForPool({
    String? poolType,
    String? filterType,
    String? chemicalType,
  }) {
    return allTips
        .where((tip) => tip.appliesToPool(
              poolType: poolType,
              filterType: filterType,
              chemicalType: chemicalType,
            ))
        .toList();
  }

  /// Get tips for a specific type
  static List<TipEntity> getGeneralTips() {
    return getTipsByCategory('general');
  }

  static List<TipEntity> getLonaTips() {
    return getTipsByCategory('lona');
  }

  static List<TipEntity> getObraTips() {
    return getTipsByCategory('obra');
  }

  static List<TipEntity> getChlorineTips() {
    return getTipsByCategory('cloro');
  }

  static List<TipEntity> getFilterTips() {
    return getTipsByCategory('filtro');
  }
}

