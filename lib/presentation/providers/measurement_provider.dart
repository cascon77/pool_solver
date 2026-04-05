import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/repositories/measurement_repository_impl.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/measurement_repository.dart';
import 'package:pool_solution/presentation/providers/pool_provider.dart';

final measurementRepositoryProvider = Provider<MeasurementRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return MeasurementRepositoryImpl(db);
});

final measurementsListProvider =
    FutureProvider<List<MeasurementEntity>>((ref) async {
  return ref.watch(measurementRepositoryProvider).getAllMeasurements();
});

final measurementsByPoolProvider =
    FutureProvider.family<List<MeasurementEntity>, int>((ref, poolId) async {
  return ref.watch(measurementRepositoryProvider).getByPoolId(poolId);
});

final latestMeasurementByPoolProvider =
    FutureProvider.family<MeasurementEntity?, int>((ref, poolId) async {
  final measurements = await ref.watch(measurementsByPoolProvider(poolId).future);
  if (measurements.isEmpty) return null;
  // Assuming they are ordered by date or ID in the repository, 
  // otherwise we should sort them here.
  measurements.sort((a, b) => (b.date ?? DateTime(0)).compareTo(a.date ?? DateTime(0)));
  return measurements.first;
});

final saveMeasurementProvider =
    FutureProvider.family<int, MeasurementEntity>((ref, measurement) async {
  final repo = ref.watch(measurementRepositoryProvider);
  if (measurement.id == null) {
    final newId = await repo.insertMeasurement(measurement);
    ref.invalidate(measurementsListProvider);
    return newId;
  } else {
    await repo.updateMeasurement(measurement);
    ref.invalidate(measurementsListProvider);
    return measurement.id!;
  }
});

final deleteMeasurementProvider =
    FutureProvider.family<void, int>((ref, id) async {
  await ref.watch(measurementRepositoryProvider).deleteMeasurement(id);
  ref.invalidate(measurementsListProvider);
});
