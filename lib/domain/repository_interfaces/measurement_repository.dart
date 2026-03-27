
import 'package:pool_solution/domain/entities/measurement_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class MeasurementRepository {
  Future<List<MeasurementEntity>> getAllMeasurements();
  Future<MeasurementEntity?> getMeasurementById(int id);
  Future<int> insertMeasurement(MeasurementEntity measurement);
  Future<bool> updateMeasurement(MeasurementEntity measurement);
  Future<bool> deleteMeasurement(int id);

  /// Obtener mediciones por piscina
  Future<List<MeasurementEntity>> getByPoolId(int poolId);

  /// Filtrar mediciones por rango de fechas
  Future<List<MeasurementEntity>> filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Obtener mediciones de una piscina específica en un rango de fechas
  Future<List<MeasurementEntity>> getByPoolAndDateRange(
    int poolId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Obtener mediciones de una piscina en una fecha específica
  Future<List<MeasurementEntity>> getByPoolAndDate(int poolId, DateTime date);

  /// Búsqueda avanzada con múltiples criterios
  Future<List<MeasurementEntity>> searchByMultipleCriteria(SearchFilter filter);
}
