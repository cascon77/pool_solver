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
  // Almacenamos como REAL para soportar concentraciones decimales (ej: 35.5%)
  RealColumn get concentration => real().nullable()();
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

/// Tabla de tratamientos — registra cada acción química aplicada.
/// poolId     → piscina tratada
/// chemicalId → producto utilizado (puede ser null si el trat. es manual)
/// measurementId → medición que motivó el tratamiento (opcional)
/// problemId  → id del problema del JSON (ej: 'green_water')
/// amountUsed → cantidad aplicada
/// unit       → unidad de la cantidad (g, ml, kg, l)
/// notes      → texto libre / descripción del tratamiento
@UseRowClass(TreatmentEntity)
class Treatments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get poolId => integer().nullable().references(Pools, #id)();
  IntColumn get chemicalId =>
      integer().nullable().references(Chemicals, #id)();
  IntColumn get measurementId =>
      integer().nullable().references(Measurements, #id)();
  TextColumn get problemId => text().nullable()();
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
  Treatments,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          // v4 → v5: Treatments gana poolId, chemicalId, problemId,
          //           amountUsed, unit, notes y date.
          //           concentration pasa de INTEGER a REAL en Chemicals.
          if (from < 5) {
            await m.addColumn(db.treatments, db.treatments.poolId);
            await m.addColumn(db.treatments, db.treatments.chemicalId);
            await m.addColumn(db.treatments, db.treatments.problemId);
            await m.addColumn(db.treatments, db.treatments.amountUsed);
            await m.addColumn(db.treatments, db.treatments.unit);
            await m.addColumn(db.treatments, db.treatments.notes);
          }
        },
      );

  // Alias útil para evitar conflicto de nombre con el getter `db`
  AppDatabase get db => this;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pool_solver.sqlite'));
    return NativeDatabase(file);
  });
}
