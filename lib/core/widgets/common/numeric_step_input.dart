import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';

class NumericStepInput extends StatelessWidget {
  final String label;
  final double value;
  final double step;
  final double min;
  final double max;
  final TextEditingController controller;
  final ValueChanged<double> onChanged;
  final bool isInteger;

  const NumericStepInput({
    super.key,
    required this.label,
    required this.value,
    required this.step,
    required this.min,
    required this.max,
    required this.controller,
    required this.onChanged,
    this.isInteger = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.primaryAccent.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              _buildStepButton(Icons.remove_rounded, () {
                final newValue = (value - step).clamp(min, max);
                onChanged(newValue);
                controller.text = isInteger
                    ? newValue.toStringAsFixed(0)
                    : newValue.toStringAsFixed(1);
              }),
              Expanded(
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: !isInteger,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryAccent,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (val) {
                    final parsed = double.tryParse(val);
                    if (parsed != null) {
                      onChanged(parsed);
                    }
                  },
                  onEditingComplete: () {
                    controller.text = isInteger
                        ? value.toStringAsFixed(0)
                        : value.toStringAsFixed(1);
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              _buildStepButton(Icons.add_rounded, () {
                final newValue = (value + step).clamp(min, max);
                onChanged(newValue);
                controller.text = isInteger
                    ? newValue.toStringAsFixed(0)
                    : newValue.toStringAsFixed(1);
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStepButton(IconData icon, VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: AppColors.primaryAccent, size: 24),
        ),
      ),
    );
  }
}
