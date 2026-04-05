import 'package:pool_solution/domain/entities/tip_entity.dart';

abstract class TipRepository {
  List<TipEntity> getAllTips();
  List<TipEntity> getTipsForPool({
    String? poolType,
    String? filterType,
    String? chemicalType,
  });
  List<TipEntity> getTipsByCategory(String category);
}
