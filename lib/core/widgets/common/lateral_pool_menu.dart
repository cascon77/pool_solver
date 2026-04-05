import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pool_solution/core/theme/theme.dart';
import 'package:pool_solution/core/widgets/common/build_menu_item.dart';
import 'package:pool_solution/core/widgets/common/logo_drawer_header.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/routes/routes.dart';

class LateralPoolMenu extends StatelessWidget {
  final PoolEntity pool;
  final bool isPoolSetupScreen;
  final bool isProblemScreen;
  final bool isCalculatorScreen;
  final bool isInventoryScreen;
  final bool isHistoryScreen;
  const LateralPoolMenu({super.key,
    required this.pool,
    this.isPoolSetupScreen = false,
    this.isProblemScreen=false,
    this.isCalculatorScreen=false,
    this.isInventoryScreen=false,
    this.isHistoryScreen=false
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            LogoDrawerHeader(),
            if (!isPoolSetupScreen)
              BuildMenuItem(
                icon: Icons.pool,
                title: pool.name ?? l10n.noName,
                onTap: () {
                  Navigator.pop(context);
                  context.pushNamed(Routes.poolSetup, extra: pool);
                },
              ),
            if (!isProblemScreen)
              BuildMenuItem(
                icon: Icons.build,
                title: l10n.problems,
                onTap: () {
                  Navigator.pop(context);
                  context.pushNamed(Routes.configuration);
                },
              ),
            if (!isCalculatorScreen)
              BuildMenuItem(
                icon: Icons.calculate,
                title: l10n.calculator,
                onTap: () {
                  Navigator.pop(context);
                  context.pushNamed(Routes.configuration);
                },
              ),
            if (!isInventoryScreen)
              BuildMenuItem(
                icon: Icons.inventory,
                title: l10n.inventory,
                onTap: () {
                  Navigator.pop(context);
                  context.pushNamed(Routes.configuration);
                },
              ),
            if (!isHistoryScreen)
              BuildMenuItem(
                icon: Icons.history,
                title: l10n.history,
                onTap: () {
                  Navigator.pop(context);
                  context.pushNamed(Routes.configuration);
                },
              ),
            const Divider(indent: 15, endIndent: 15),
            BuildMenuItem(
                icon: Icons.home_filled,
                title: l10n.homePools,
                onTap: (){
                  Navigator.pop(context);
                  context.pushReplacementNamed(Routes.home);
                }
            ),
            BuildMenuItem(
              icon: Icons.lightbulb,
              title: l10n.homeTips,
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(Routes.tips);
              },
            ),
            const Divider(indent: 15, endIndent: 15),
            BuildMenuItem(
              icon: Icons.settings_rounded,
              title: l10n.homeConfiguration,
              onTap: () {
                Navigator.pop(context);
                context.pushNamed(Routes.configuration);
              },
            ),

          ],
        ),
    );
  }
}
