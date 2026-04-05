import 'package:flutter/material.dart';
import 'package:pool_solution/core/widgets/common/lateral_pool_menu.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

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
      drawer: LateralPoolMenu(pool: pool,isPoolSetupScreen: true),
      appBar: AppBar(
        title: Text(pool.name ?? l10n.noName),
        centerTitle: true
      ),
      body: CircularProgressIndicator(),
    );
  }
}