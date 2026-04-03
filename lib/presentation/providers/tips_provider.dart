import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/datasources/tips_database.dart';
import 'package:pool_solution/domain/entities/tip_entity.dart';

/// Provider that returns all tips
final allTipsProvider = Provider<List<TipEntity>>((ref) {
  return TipsDatabase.getAllTips();
});

/// Provider to get tips by category
final tipsByCategoryProvider =
    Provider.family<List<TipEntity>, String>((ref, category) {
  return TipsDatabase.getTipsByCategory(category);
});

/// Provider to get general tips
final generalTipsProvider = Provider<List<TipEntity>>((ref) {
  return TipsDatabase.getGeneralTips();
});

/// Provider to get lona tips
final lonaTipsProvider = Provider<List<TipEntity>>((ref) {
  return TipsDatabase.getLonaTips();
});

/// Provider to get obra tips
final obraTipsProvider = Provider<List<TipEntity>>((ref) {
  return TipsDatabase.getObraTips();
});

/// Provider to get chlorine/salt tips
final chlorineTipsProvider = Provider<List<TipEntity>>((ref) {
  return TipsDatabase.getChlorineTips();
});

/// Provider to get filter tips
final filterTipsProvider = Provider<List<TipEntity>>((ref) {
  return TipsDatabase.getFilterTips();
});

/// Provider to get tips filtered by pool configuration
final filteredTipsProvider = Provider.family<List<TipEntity>, Map<String, String?>>(
    (ref, config) {
  final poolType = config['poolType'];
  final filterType = config['filterType'];
  final chemicalType = config['chemicalType'];

  return TipsDatabase.getTipsForPool(
    poolType: poolType,
    filterType: filterType,
    chemicalType: chemicalType,
  );
});

