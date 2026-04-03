import 'package:flutter/material.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/presentation/screens/screens.dart';

class PoolSetupScreen extends StatelessWidget {
  final PoolEntity pool;

  const PoolSetupScreen({
    super.key,
    required this.pool,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(pool.name ?? l10n.noName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewPoolScreen(pool: pool),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _PoolInfoTile(
            label: l10n.poolName,
            value: pool.name ?? l10n.notAvailable,
            icon: Icons.pool,
          ),
          _PoolInfoTile(
            label: l10n.volumeLiters,
            value: pool.volumeLiters != null
                ? '${pool.volumeLiters}${l10n.liters}'
                : l10n.notAvailable,
            icon: Icons.water_drop,
          ),
          _PoolInfoTile(
            label: l10n.waterType,
            value: _getWaterTypeText(context, pool.waterType),
            icon: Icons.science,
          ),
          _PoolInfoTile(
            label: l10n.filterType,
            value: _getFilterTypeText(context, pool.filterType),
            icon: Icons.filter_alt,
          ),
          _PoolInfoTile(
            label: l10n.poolShape,
            value: pool.shape ?? l10n.notAvailable,
            icon: Icons.shape_line,
          ),
        ],
      ),
    );
  }

  String _getWaterTypeText(BuildContext context, WaterType? type) {
    final l10n = AppLocalizations.of(context)!;
    if (type == null) return l10n.notAvailable;
    switch (type) {
      case WaterType.chlorine:
        return l10n.chlorine;
      case WaterType.salt:
        return l10n.salt;
    }
  }

  String _getFilterTypeText(BuildContext context, FilterType? type) {
    final l10n = AppLocalizations.of(context)!;
    if (type == null) return l10n.notAvailable;
    switch (type) {
      case FilterType.sand:
        return l10n.sand;
      case FilterType.cartridge:
        return l10n.cartridge;
      case FilterType.glass:
        return l10n.glass;
    }
  }
}

class _PoolInfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _PoolInfoTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
