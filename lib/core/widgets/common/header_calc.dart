import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';

class HeaderCalc extends StatelessWidget {
  final String? img;
  final String desc;

  const HeaderCalc({super.key, this.img, required this.desc});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (img != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                img!,
                height: 80,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.calculate_rounded,
                  size: 60,
                  color: AppColors.primaryAccent,
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            desc,
            textAlign: TextAlign.justify,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              height: 1.5,
              fontSize: 15,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
