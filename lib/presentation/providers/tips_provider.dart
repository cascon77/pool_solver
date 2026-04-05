import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/repositories/tip_repository_impl.dart';
import 'package:pool_solution/domain/entities/tip_entity.dart';
import 'package:pool_solution/domain/repository_interfaces/tip_repository.dart';

final tipRepositoryProvider = Provider<TipRepository>((ref) {
  return const TipRepositoryImpl();
});

/// Todos los tips
final allTipsProvider = Provider<List<TipEntity>>((ref) {
  return ref.watch(tipRepositoryProvider).getAllTips();
});

/// Tips por categoría ('general', 'cloro', 'lona', 'obra', 'filtro')
final tipsByCategoryProvider =
    Provider.family<List<TipEntity>, String>((ref, category) {
  return ref.watch(tipRepositoryProvider).getTipsByCategory(category);
});

/// Tips filtrados por configuración de la piscina activa
final filteredTipsProvider =
    Provider.family<List<TipEntity>, Map<String, String?>>((ref, config) {
  return ref.watch(tipRepositoryProvider).getTipsForPool(
        poolType: config['poolType'],
        filterType: config['filterType'],
        chemicalType: config['chemicalType'],
      );
});

// Accesos directos por categoría (compatibilidad con código existente)
final generalTipsProvider = Provider<List<TipEntity>>((ref) =>
    ref.watch(tipRepositoryProvider).getTipsByCategory('general'));

final lonaTipsProvider = Provider<List<TipEntity>>((ref) =>
    ref.watch(tipRepositoryProvider).getTipsByCategory('lona'));

final obraTipsProvider = Provider<List<TipEntity>>((ref) =>
    ref.watch(tipRepositoryProvider).getTipsByCategory('obra'));

final chlorineTipsProvider = Provider<List<TipEntity>>((ref) =>
    ref.watch(tipRepositoryProvider).getTipsByCategory('cloro'));

final filterTipsProvider = Provider<List<TipEntity>>((ref) =>
    ref.watch(tipRepositoryProvider).getTipsByCategory('filtro'));
