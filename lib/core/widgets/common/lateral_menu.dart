import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/l10n/app_localizations.dart';


class LateralMenu extends StatelessWidget {
  const LateralMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final appBarColor = Theme.of(context).appBarTheme.backgroundColor ?? AppColors.primaryDark;
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
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
          ),
          _buildMenuItem(
            context,
            icon: Icons.home_rounded,
            title: l10n.homePools,
            onTap: () => Navigator.pop(context),
          ),
          _buildMenuItem(
            context,
            icon: Icons.history_rounded,
            title: 'Historial Global',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.school_rounded,
            title: 'Curso de Piscinas',
            onTap: () {},
          ),
          const Divider(indent: 20, endIndent: 20),
          _buildMenuItem(
            context,
            icon: Icons.settings_rounded,
            title: l10n.homeConfiguration,
            onTap: () {
              Navigator.pop(context);
              context.push('/configuration');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required IconData icon, 
    required String title, 
    required VoidCallback onTap
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryAccent),
      title: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : AppColors.primaryDark,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
