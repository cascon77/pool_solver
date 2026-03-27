import 'package:drift/drift.dart';
import 'package:pool_solution/data/datasources/sqlite/app_database.dart';
import 'package:pool_solution/domain/entities/chemical_entity.dart';
import 'package:pool_solution/domain/entities/search_filter.dart';
import 'package:pool_solution/domain/repository_interfaces/chemical_repository.dart';

class ChemicalRepositoryImpl implements ChemicalRepository {
  final AppDatabase db;

  ChemicalRepositoryImpl(this.db);

  @override
  Future<List<ChemicalEntity>> getAllChemicals() async {
    return await db.select(db.chemicals).get();
  }

  @override
  Future<ChemicalEntity?> getChemicalById(int id) async {
    return await (db.select(db.chemicals)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  @override
  Future<int> insertChemical(ChemicalEntity chemical) {
    return db.into(db.chemicals).insert(ChemicalsCompanion.insert(
      name: Value(chemical.name),
      chemicalTypeId: Value(chemical.chemicalTypeId),
      format: Value(chemical.format),
      concentration: Value(chemical.concentration),
      unit: Value(chemical.unit),
    ));
  }

  @override
  Future<bool> updateChemical(ChemicalEntity chemical) {
    return db.update(db.chemicals).replace(ChemicalsCompanion(
      id: Value(chemical.id!),
      name: Value(chemical.name),
      chemicalTypeId: Value(chemical.chemicalTypeId),
      format: Value(chemical.format),
      concentration: Value(chemical.concentration),
      unit: Value(chemical.unit),
    ));
  }

  @override
  Future<bool> deleteChemical(int id) async {
    final count = await (db.delete(db.chemicals)..where((t) => t.id.equals(id))).go();
    return count > 0;
  }

  @override
  Future<List<ChemicalEntity>> searchByName(String name) async {
    return await (db.select(db.chemicals)
          ..where((t) => t.name.like('%$name%')))
        .get();
  }

  @override
  Future<List<ChemicalEntity>> filterByChemicalType(int chemicalTypeId) async {
    return await (db.select(db.chemicals)
          ..where((t) => t.chemicalTypeId.equals(chemicalTypeId)))
        .get();
  }

  @override
  Future<List<ChemicalEntity>> filterByFormat(String format) async {
    return await (db.select(db.chemicals)
          ..where((t) => t.format.equals(format)))
        .get();
  }

  @override
  Future<List<ChemicalEntity>> searchByMultipleCriteria(SearchFilter filter) async {
    var query = db.select(db.chemicals);

    if (filter.searchTerm != null && filter.searchTerm!.isNotEmpty) {
      query = query..where((t) => t.name.like('%${filter.searchTerm!}%'));
    }

    if (filter.foreignKeyId != null) {
      query = query..where((t) => t.chemicalTypeId.equals(filter.foreignKeyId!));
    }

    if (filter.format != null && filter.format!.isNotEmpty) {
      query = query..where((t) => t.format.equals(filter.format!));
    }

    if (filter.limit != null) {
      query = query..limit(filter.limit!, offset: filter.offset ?? 0);
    }

    return await query.get();
  }
}
