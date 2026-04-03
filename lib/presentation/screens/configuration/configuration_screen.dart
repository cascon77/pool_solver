import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/presentation/providers/locale_provider.dart';
import 'package:pool_solution/presentation/providers/theme_provider.dart';


class ConfigurationScreen extends ConsumerWidget {
  const ConfigurationScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeConfiguration, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader(l10n.homeConfiguration.toUpperCase()),
          const SizedBox(height: 16),
          _buildThemeSelector(context, ref, themeMode, isDark),
          const SizedBox(height: 32),
          _buildSectionHeader(l10n.language),
          const SizedBox(height: 16),
          _buildLanguageDropdown(context, ref, locale, isDark),
          const Divider(height: 64),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded, color: AppColors.primaryAccent),
            title: Text(l10n.version),
            subtitle: Text(l10n.versionNumber),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryAccent,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildThemeSelector(BuildContext context, WidgetRef ref, ThemeMode currentMode, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          _buildSegmentButton(
            context,
            ref,
            icon: Icons.brightness_auto_rounded,
            label: l10n.auto,
            isSelected: currentMode == ThemeMode.system,
            onTap: () => ref.read(themeModeProvider.notifier).state = ThemeMode.system,
          ),
          _buildSegmentButton(
            context,
            ref,
            icon: Icons.light_mode_rounded,
            label: l10n.light,
            isSelected: currentMode == ThemeMode.light,
            onTap: () => ref.read(themeModeProvider.notifier).state = ThemeMode.light,
          ),
          _buildSegmentButton(
            context,
            ref,
            icon: Icons.dark_mode_rounded,
            label: l10n.dark,
            isSelected: currentMode == ThemeMode.dark,
            onTap: () => ref.read(themeModeProvider.notifier).state = ThemeMode.dark,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, WidgetRef ref, Locale currentLocale, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    final Map<String, String> languages = {
      'es': l10n.spanish,
      'en': l10n.english,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryAccent.withValues(alpha: 0.2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLocale.languageCode,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryAccent),
          dropdownColor: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(15),
          items: languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Icon(
                    Icons.language_rounded, 
                    size: 20, 
                    color: currentLocale.languageCode == entry.key ? AppColors.primaryAccent : AppColors.textSecondary
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.value,
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.primaryDark,
                      fontWeight: currentLocale.languageCode == entry.key ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (String? newCode) {
            if (newCode != null) {
              ref.read(localeProvider.notifier).state = Locale(newCode);
            }
          },
        ),
      ),
    );
  }

  Widget _buildSegmentButton(
    BuildContext context,
    WidgetRef ref, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryAccent : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Icon(
                icon, 
                color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.textSecondary)
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : (isDark ? Colors.white70 : AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
