
import 'package:pool_solution/domain/entities/treatment_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';

abstract class TreatmentRepository {
  Future<List<TreatmentEntity>> getAllTreatments();
  Future<TreatmentEntity?> getTreatmentById(int id);
  Future<int> insertTreatment(TreatmentEntity treatment);
  Future<bool> updateTreatment(TreatmentEntity treatment);
  Future<bool> deleteTreatment(int id);

  /// Obtener tratamientos por piscina (clave secundaria)
  Future<List<TreatmentEntity>> getByPoolId(int poolId);

  /// Obtener tratamientos por químico (clave secundaria)
  Future<List<TreatmentEntity>> getByChemicalId(int chemicalId);

  /// Obtener tratamientos por problema (clave secundaria)
  Future<List<TreatmentEntity>> getByProblemId(int problemId);

  /// Obtener tratamientos por medición (clave secundaria)
  Future<List<TreatmentEntity>> getByMeasurementId(int measurementId);

  /// Filtrar tratamientos por rango de fechas
  Future<List<TreatmentEntity>> filterByDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Obtener tratamientos de una piscina en un rango de fechas
  Future<List<TreatmentEntity>> getByPoolAndDateRange(
    int poolId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Búsqueda avanzada combinando múltiples criterios
  /// (piscina, químico, problema, rango de fechas)
  Future<List<TreatmentEntity>> searchByMultipleCriteria(SearchFilter filter);
}
