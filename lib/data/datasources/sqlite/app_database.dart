import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:pool_solution/domain/entities/chemical_entity.dart';
import 'package:pool_solution/domain/entities/chemical_type.dart';
import 'package:pool_solution/domain/entities/enums.dart';
import 'package:pool_solution/domain/entities/inventory_entity.dart';
import 'package:pool_solution/domain/entities/measurement_entity.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/domain/entities/problem_entity.dart';
import 'package:pool_solution/domain/entities/problem_step_entity.dart';
import 'package:pool_solution/domain/entities/treatment_entity.dart';


part 'app_database.g.dart';

@UseRowClass(PoolEntity)
class Pools extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  RealColumn get volumeLiters => real().nullable()();
  TextColumn get waterType => textEnum<WaterType>().nullable()();
  TextColumn get filterType => textEnum<FilterType>().nullable()();
  TextColumn get shape => text().nullable()();
  DateTimeColumn get createdAt => dateTime().nullable()();
}

@UseRowClass(ChemicalType)
class ChemicalTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get parameterTarget => text().nullable()();
}

@UseRowClass(ChemicalEntity)
class Chemicals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  IntColumn get chemicalTypeId =>
      integer().nullable().references(ChemicalTypes, #id)();
  TextColumn get format => textEnum<ChemicalFormat>().nullable()();
  IntColumn get concentration => integer().nullable()();
  TextColumn get unit => textEnum<Unit>().nullable()();
}

@UseRowClass(InventoryEntity)
class Inventories extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chemicalId => integer().nullable().references(Chemicals, #id)();
  IntColumn get stock => integer().nullable()();
  IntColumn get minStock => integer().nullable()();
  TextColumn get notes => text().nullable()();
}

@UseRowClass(MeasurementEntity)
class Measurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get poolId => integer().nullable().references(Pools, #id)();
  DateTimeColumn get date => dateTime().nullable()();
  RealColumn get ph => real().nullable()();
  RealColumn get chlorine => real().nullable()();
  RealColumn get alkalinity => real().nullable()();
  RealColumn get stabilizer => real().nullable()();
  RealColumn get salt => real().nullable()();
  RealColumn get calciumHardness => real().nullable()();
  TextColumn get notes => text().nullable()();
}

@UseRowClass(ProblemEntity)
class Problems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text().nullable()();
  TextColumn get languageCode => text().withDefault(const Constant('es'))(); // Idioma base (default: español)
}

@UseRowClass(ProblemStepEntity)
class ProblemSteps extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get problemId => integer().nullable().references(Problems, #id)();
  IntColumn get stepOrder => integer().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get requiresCalculation => boolean().nullable()();
  TextColumn get languageCode => text().withDefault(const Constant('es'))(); // Idioma base (default: español)
}

@UseRowClass(TreatmentEntity)
class Treatments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get poolId => integer().nullable().references(Pools, #id)();
  IntColumn get chemicalId => integer().nullable().references(Chemicals, #id)();
  IntColumn get measurementId =>
      integer().nullable().references(Measurements, #id)();
  IntColumn get problemId => integer().nullable().references(Problems, #id)();
  DateTimeColumn get date => dateTime().nullable()();
  RealColumn get amountUsed => real().nullable()();
  TextColumn get unit => textEnum<Unit>().nullable()();
  TextColumn get notes => text().nullable()();
}

@DriftDatabase(tables: [
  Pools,
  ChemicalTypes,
  Chemicals,
  Inventories,
  Measurements,
  Problems,
  ProblemSteps,
  Treatments,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pool_solver.sqlite'));
    return NativeDatabase(file);
  });
}
