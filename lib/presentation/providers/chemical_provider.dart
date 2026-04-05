import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/data/repositories/chemical_repository_impl.dart';
import 'package:pool_solution/data/repositories/chemical_type_repository_impl.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/repository_interfaces/chemical_repository.dart';
import 'package:pool_solution/domain/repository_interfaces/chemical_type_repository.dart';
import 'package:pool_solution/presentation/providers/pool_provider.dart';

final chemicalRepositoryProvider = Provider<ChemicalRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ChemicalRepositoryImpl(db);
});

final chemicalTypeRepositoryProvider = Provider<ChemicalTypeRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ChemicalTypeRepositoryImpl(db);
});

final chemicalsListProvider =
    FutureProvider<List<ChemicalEntity>>((ref) async {
  return ref.watch(chemicalRepositoryProvider).getAllChemicals();
});

final chemicalTypesListProvider =
    FutureProvider<List<ChemicalType>>((ref) async {
  return ref.watch(chemicalTypeRepositoryProvider).getAllChemicalTypes();
});

final saveChemicalProvider =
    FutureProvider.family<void, ChemicalEntity>((ref, chemical) async {
  final repo = ref.watch(chemicalRepositoryProvider);
  if (chemical.id == null) {
    await repo.insertChemical(chemical);
  } else {
    await repo.updateChemical(chemical);
  }
  ref.invalidate(chemicalsListProvider);
});

final deleteChemicalProvider =
    FutureProvider.family<void, int>((ref, id) async {
  await ref.watch(chemicalRepositoryProvider).deleteChemical(id);
  ref.invalidate(chemicalsListProvider);
});
