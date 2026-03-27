import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/chemical_type.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/chemical_type_repository.dart';

class ChemicalTypeRepositoryImpl implements ChemicalTypeRepository {
  final AppDatabase db;

  ChemicalTypeRepositoryImpl(this.db);

  @override
  Future<List<ChemicalType>> getAllChemicalTypes() async {
    return await db.select(db.chemicalTypes).get();
  }

  @override
  Future<ChemicalType?> getChemicalTypeById(int id) async {
    return await (db.select(db.chemicalTypes)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertChemicalType(ChemicalType chemicalType) {
    return db.into(db.chemicalTypes).insert(ChemicalTypesCompanion.insert(
      name: Value(chemicalType.name),
      parameterTarget: Value(chemicalType.parameterTarget),
    ));
  }

  @override
  Future<bool> updateChemicalType(ChemicalType chemicalType) {
    return db.update(db.chemicalTypes).replace(ChemicalTypesCompanion(
      id: Value(chemicalType.id!),
      name: Value(chemicalType.name),
      parameterTarget: Value(chemicalType.parameterTarget),
    ));
  }

  @override
  Future<bool> deleteChemicalType(int id) async {
    final count = await (db.delete(db.chemicalTypes)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<ChemicalType>> searchByName(String name) async {
    return await (db.select(db.chemicalTypes)
          ..where((t) => t.name.like('%$name%')))
        .get();
  }

  @override
  Future<List<ChemicalType>> filterByParameterTarget(String parameterTarget) async {
    return await (db.select(db.chemicalTypes)
          ..where((t) => t.parameterTarget.equals(parameterTarget)))
        .get();
  }

  @override
  Future<List<ChemicalType>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.chemicalTypes);

    if (filter.searchTerm != null && filter.searchTerm!.isNotEmpty) {
      query = query..where((t) => t.name.like('%${filter.searchTerm!}%'));
    }

    if (filter.type != null && filter.type!.isNotEmpty) {
      query = query..where((t) => t.parameterTarget.equals(filter.type!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }
}
