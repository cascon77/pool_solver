import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/core/widgets/common/lateral_pool_menu.dart';
import 'package:pool_solution/core/widgets/common/parameter_card.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/presentation/providers/measurement_provider.dart';

class PoolSetupScreen extends ConsumerWidget {
  final PoolEntity pool;

  const PoolSetupScreen({super.key, required this.pool});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final latestMeasurementAsync = ref.watch(
      latestMeasurementByPoolProvider(pool.id!),
    );

    return Scaffold(
      drawer: LateralPoolMenu(pool: pool, isPoolSetupScreen: true),
      appBar: AppBar(title: Text(pool.name ?? l10n.noName), centerTitle: true),
      body: latestMeasurementAsync.when(
        data: (measurement) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(6),
              child: Column(
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      ParameterCard(
                        title: "pH",
                        target: "7.2 - 7.6",
                        value:
                            measurement?.ph?.toStringAsFixed(1) ??
                            l10n.notAvailable,
                        unit: "pH",
                        color: Colors.orange,
                        onTap: () {},
                      ),
                      ParameterCard(
                        title: l10n.chlorine,
                        target: "1.0 - 3.0",
                        value:
                            measurement?.chlorine?.toStringAsFixed(1) ??
                            l10n.notAvailable,
                        unit: "ppm",
                        color: Colors.blue,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    spacing: 6,
                    children: [
                      ParameterCard(
                        title: l10n.alkalinity,
                        target: "80 - 120",
                        value:
                            measurement?.alkalinity?.toStringAsFixed(0) ??
                            l10n.notAvailable,
                        unit: "ppm",
                        color: Colors.teal,
                        onTap: () {},
                      ),
                      ParameterCard(
                        title: l10n.temperature,
                        value:
                            measurement?.temperature?.toStringAsFixed(1) ??
                            l10n.notAvailable,
                        unit: "°C",
                        isTemperature: true,
                        color: Colors.redAccent,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    spacing: 6,
                    children: [
                      ParameterCard(
                        title: l10n.stabilizer,
                        target: "30 - 50",
                        value:
                            measurement?.stabilizer?.toStringAsFixed(0) ??
                            l10n.notAvailable,
                        unit: "ppm",
                        color: Colors.purple,
                        onTap: () {},
                      ),
                      ParameterCard(
                        title: l10n.hardness,
                        target: "200 - 400",
                        value:
                            measurement?.calciumHardness?.toStringAsFixed(0) ??
                            l10n.notAvailable,
                        unit: "ppm",
                        color: Colors.brown,
                        onTap: () {},
                      ),
                    ],
                  ),
                  if (pool.waterType == WaterType.salt) ...[
                    const SizedBox(height: 6),
                    Row(
                      spacing: 6,
                      children: [
                        ParameterCard(
                          title: l10n.salt,
                          target: "3000 - 4000",
                          value:
                              measurement?.salt?.toStringAsFixed(0) ??
                              l10n.notAvailable,
                          unit: "ppm",
                          color: Colors.indigo,
                          onTap: () {},
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ],

                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(width: 8),
                          Text(l10n.addMeasurementOrTreatment),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(l10n.error)),
      ),
    );
  }
}
