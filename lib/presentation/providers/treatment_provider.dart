import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/repositories/treatment_repository_impl.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/treatment_repository.dart';
import 'package:pool_solution/presentation/providers/pool_provider.dart';

final treatmentRepositoryProvider = Provider<TreatmentRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TreatmentRepositoryImpl(db);
});

final treatmentsByPoolProvider =
    FutureProvider.family<List<TreatmentEntity>, int>((ref, poolId) async {
  return ref.watch(treatmentRepositoryProvider).getByPoolId(poolId);
});

final treatmentsByMeasurementProvider =
    FutureProvider.family<List<TreatmentEntity>, int>((ref, measurementId) async {
  return ref.watch(treatmentRepositoryProvider).getByMeasurementId(measurementId);
});

final saveTreatmentProvider =
    FutureProvider.family<int, TreatmentEntity>((ref, treatment) async {
  final repo = ref.watch(treatmentRepositoryProvider);
  if (treatment.id == null) {
    return repo.insertTreatment(treatment);
  } else {
    await repo.updateTreatment(treatment);
    return treatment.id!;
  }
});

final deleteTreatmentProvider =
    FutureProvider.family<void, int>((ref, id) async {
  await ref.watch(treatmentRepositoryProvider).deleteTreatment(id);
});
