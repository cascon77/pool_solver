import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/repositories/inventory_repository_impl.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/inventory_repository.dart';
import 'package:pool_solution/presentation/providers/pool_provider.dart';

final inventoryRepositoryProvider = Provider<InventoryRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return InventoryRepositoryImpl(db);
});

final inventoryListProvider =
    FutureProvider<List<InventoryEntity>>((ref) async {
  return ref.watch(inventoryRepositoryProvider).getAllInventory();
});

/// Items de inventario con stock por debajo del mínimo
final lowStockProvider = FutureProvider<List<InventoryEntity>>((ref) async {
  final all = await ref.watch(inventoryRepositoryProvider).getAllInventory();
  return all
      .where((i) =>
          i.stock != null &&
          i.minStock != null &&
          i.stock! <= i.minStock!)
      .toList();
});

final saveInventoryProvider =
    FutureProvider.family<void, InventoryEntity>((ref, inventory) async {
  final repo = ref.watch(inventoryRepositoryProvider);
  if (inventory.id == null) {
    await repo.insertInventory(inventory);
  } else {
    await repo.updateInventory(inventory);
  }
  ref.invalidate(inventoryListProvider);
});

final deleteInventoryProvider =
    FutureProvider.family<void, int>((ref, id) async {
  await ref.watch(inventoryRepositoryProvider).deleteInventory(id);
  ref.invalidate(inventoryListProvider);
});
