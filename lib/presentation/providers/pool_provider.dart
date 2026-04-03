import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/data/repositories/pool_repository_impl.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/pool_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final poolRepositoryProvider = Provider<PoolRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PoolRepositoryImpl(db);
});

final poolsListProvider = FutureProvider<List<PoolEntity>>((ref) async {
  final repository = ref.watch(poolRepositoryProvider);
  return repository.getAllPools();
});

final poolDetailProvider =
    FutureProvider.family<PoolEntity?, int>((ref, poolId) async {
  final repository = ref.watch(poolRepositoryProvider);
  return repository.getPoolById(poolId);
});

final savePoolProvider = FutureProvider.family<void, PoolEntity>((ref, pool) async {
  final repository = ref.watch(poolRepositoryProvider);
  
  if (pool.id == null) {
    // Crear nuevo pool
    final newId = await repository.insertPool(pool);
    pool.id = newId;
  } else {
    // Actualizar pool existente
    await repository.updatePool(pool);
  }
  
  // Invalidar la lista de pools para refrescar
  ref.invalidate(poolsListProvider);
});

final deletePoolProvider = FutureProvider.family<void, int>((ref, poolId) async {
  final repository = ref.watch(poolRepositoryProvider);
  await repository.deletePool(poolId);
  // Invalidar la lista de pools para refrescar
  ref.invalidate(poolsListProvider);
});
