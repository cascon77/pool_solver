import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';

class ParameterCard extends StatelessWidget {
  final String title;
  final String? target;
  final String? value;
  final String unit;
  final Color? color;
  final bool isTemperature;
  final VoidCallback? onTap;

  const ParameterCard({
    super.key,
    required this.title,
    this.target,
    this.value,
    required this.unit,
    this.color,
    this.isTemperature = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accentColor = color ?? AppColors.primaryAccent;

    return Expanded(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
        color: isDark ? AppColors.surfaceDark : Colors.white,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _CardLayout(
              title: title,
              target: target,
              value: value,
              unit: unit,
              accentColor: accentColor,
              isTemperature: isTemperature,
              isDark: isDark,
              showChevron: onTap != null,
            ),
          ),
        ),
      ),
    );
  }
}

class _CardLayout extends StatelessWidget {
  final String title;
  final String? target;
  final String? value;
  final String unit;
  final Color accentColor;
  final bool isTemperature;
  final bool isDark;
  final bool showChevron;

  const _CardLayout({
    required this.title,
    this.target,
    this.value,
    required this.unit,
    required this.accentColor,
    required this.isTemperature,
    required this.isDark,
    required this.showChevron,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleSection(title: title),
              _TargetSection(target: target, isTemperature: isTemperature),
              const SizedBox(height: 4),
              _ValueSection(
                value: value,
                unit: unit,
                accentColor: accentColor,
                isTemperature: isTemperature,
                isDark: isDark,
              ),
            ],
          ),
        ),
        if (showChevron) const _ChevronIcon(),
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  final String title;
  const _TitleSection({required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.labelMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TargetSection extends StatelessWidget {
  final String? target;
  final bool isTemperature;

  const _TargetSection({this.target, required this.isTemperature});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      isTemperature ? "target" : "target: ${target ?? "N/A"}",
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.labelMedium?.copyWith(
        color: isTemperature ? Colors.transparent : AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ValueSection extends StatelessWidget {
  final String? value;
  final String unit;
  final Color accentColor;
  final bool isTemperature;
  final bool isDark;

  const _ValueSection({
    this.value,
    required this.unit,
    required this.accentColor,
    required this.isTemperature,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ParameterIcon(accentColor: accentColor, isTemperature: isTemperature),
        const SizedBox(width: 8),
        _ValueDisplay(value: value, unit: unit, isDark: isDark),
      ],
    );
  }
}

class _ParameterIcon extends StatelessWidget {
  final Color accentColor;
  final bool isTemperature;

  const _ParameterIcon({required this.accentColor, required this.isTemperature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accentColor.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isTemperature ? Icons.thermostat : Icons.science,
        color: accentColor,
        size: 20,
      ),
    );
  }
}

class _ValueDisplay extends StatelessWidget {
  final String? value;
  final String unit;
  final bool isDark;

  const _ValueDisplay({this.value, required this.unit, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value ?? "N/A",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              unit,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChevronIcon extends StatelessWidget {
  const _ChevronIcon();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.chevron_right,
      size: 18,
      color: AppColors.textSecondary,
    );
  }
}
