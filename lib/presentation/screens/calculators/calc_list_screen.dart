import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/domain/entities/pool_entity.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/routes/routes.dart';

class CalcListScreen extends StatelessWidget {
  final PoolEntity pool;
  const CalcListScreen({super.key, required this.pool});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> calculators = [
      {
        'title': 'pH',
        'route': Routes.calcPh,
        'icon': Icons.science,
        'color': Colors.purple,
        'desc': '${l10n.phCalcDescription.split('.').first}.',
      },
      {
        'title': l10n.chlorine,
        'route': Routes.calcCl,
        'icon': Icons.water_drop,
        'color': Colors.blue,
        'desc': '${l10n.cloroCalcDescription.split('.').first}.',
      },
      {
        'title': l10n.alkalinity,
        'route': Routes.calcAlkalinity,
        'icon': Icons.balance,
        'color': Colors.teal,
        'desc': '${l10n.alkalinityDesc.split('.').first}.',
      },
      {
        'title': 'Floculante',
        'route': Routes.calcFlocculant,
        'icon': Icons.auto_fix_high,
        'color': Colors.cyan,
        'desc': '${l10n.flocculantDesc.split('.').first}.',
      },
      {
        'title': l10n.chloramines,
        'route': Routes.calcChloramines,
        'icon': Icons.warning_amber_rounded,
        'color': Colors.orange,
        'desc': '${l10n.chloraminesDesc.split('.').first}.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.calculator),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: calculators.length,
        itemBuilder: (context, index) {
          final calc = calculators[index];
          return _buildCalcCard(context, calc, isDark);
        },
      ),
    );
  }

  Widget _buildCalcCard(BuildContext context, Map<String, dynamic> calc, bool isDark) {
    final color = calc['color'] as Color;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: isDark ? AppColors.surfaceDark : Colors.white,
      child: InkWell(
        onTap: () => context.pushNamed(calc['route'], extra: pool),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(calc['icon'] as IconData, color: color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      calc['title'] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      calc['desc'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
