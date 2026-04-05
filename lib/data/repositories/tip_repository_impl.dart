import 'package:pool_solution/data/datasources/tips_database.dart';
import 'package:pool_solution/domain/entities/tip_entity.dart';
import 'package:pool_solution/domain/repository_interfaces/tip_repository.dart';

class TipRepositoryImpl implements TipRepository {
  const TipRepositoryImpl();

  @override
  List<TipEntity> getAllTips() => TipsDatabase.getAllTips();

  @override
  List<TipEntity> getTipsForPool({
    String? poolType,
    String? filterType,
    String? chemicalType,
  }) =>
      TipsDatabase.getTipsForPool(
        poolType: poolType,
        filterType: filterType,
        chemicalType: chemicalType,
      );

  @override
  List<TipEntity> getTipsByCategory(String category) =>
      TipsDatabase.getTipsByCategory(category);
}
