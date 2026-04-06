import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class VolumeInfoCard extends StatelessWidget {
  final double volumeLiters;

  const VolumeInfoCard({super.key, required this.volumeLiters});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final volumeM3 = volumeLiters / 1000;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryAccent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryAccent.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildVolumeItem(
            volumeM3.toStringAsFixed(1),
            "m³",
            l10n.poolVolume,
          ),
          Container(
            width: 1,
            height: 30,
            color: AppColors.primaryAccent.withValues(alpha: 0.2),
          ),
          _buildVolumeItem(
            volumeLiters.toStringAsFixed(0),
            "L",
            l10n.poolVolume,
          ),
        ],
      ),
    );
  }

  Widget _buildVolumeItem(String value, String unit, String label) {
    return Column(
      children: [
        Text(
          "$value $unit",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.primaryAccent,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
