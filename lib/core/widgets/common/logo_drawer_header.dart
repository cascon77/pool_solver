import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/theme.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class LogoDrawerHeader extends StatelessWidget {
  const LogoDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appBarColor = Theme.of(context).appBarTheme.backgroundColor ?? AppColors.primaryDark;
    final l10n = AppLocalizations.of(context)!;


    return DrawerHeader(
      decoration: BoxDecoration(
        color: appBarColor,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [AppColors.backgroundDark, AppColors.surfaceDark]
              : [AppColors.primaryDark, AppColors.primaryAccent.withValues(alpha: 0.8)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.pool_rounded, size: 50, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            l10n.appTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Text(
            l10n.description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
