import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/core/widgets/common/header_calc.dart';
import 'package:pool_solution/core/widgets/common/numeric_step_input.dart';
import 'package:pool_solution/core/widgets/common/volume_info_card.dart';
import 'package:pool_solution/core/widgets/common/result_card.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/services/ph_calculator_service.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class CalcPhScreen extends StatefulWidget {
  final PoolEntity pool;
  const CalcPhScreen({super.key, required this.pool});

  @override
  State<CalcPhScreen> createState() => _CalcPhScreenState();
}

class _CalcPhScreenState extends State<CalcPhScreen> {
  double _currentPh = 7.0;
  double _targetPh = 7.4;
  double _alkalinity = 80.0;
  String? _selectedProduct;
  double? _result;

  late TextEditingController _currentPhController;
  late TextEditingController _targetPhController;
  late TextEditingController _alkalinityController;

  @override
  void initState() {
    super.initState();
    _currentPhController = TextEditingController(text: _currentPh.toStringAsFixed(1));
    _targetPhController = TextEditingController(text: _targetPh.toStringAsFixed(1));
    _alkalinityController = TextEditingController(text: _alkalinity.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _currentPhController.dispose();
    _targetPhController.dispose();
    _alkalinityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final volumeLiters = widget.pool.volumeLiters ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("${l10n.calculator} pH"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: [
            HeaderCalc(
              img: "assets/images/ph.png",
              desc: l10n.phCalcDescription,
            ),
            
            VolumeInfoCard(volumeLiters: volumeLiters),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: NumericStepInput(
                          label: l10n.initialPh,
                          value: _currentPh,
                          step: 0.1,
                          min: 0.0,
                          max: 14.0,
                          controller: _currentPhController,
                          onChanged: (val) => setState(() {
                            _currentPh = val;
                            _handlePhChange();
                          }),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NumericStepInput(
                          label: l10n.targetPh,
                          value: _targetPh,
                          step: 0.1,
                          min: 0.0,
                          max: 14.0,
                          controller: _targetPhController,
                          onChanged: (val) => setState(() {
                            _targetPh = val;
                            _handlePhChange();
                          }),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  
                  NumericStepInput(
                    label: l10n.currentAlkalinity,
                    value: _alkalinity,
                    step: 5,
                    min: 0,
                    max: 500,
                    controller: _alkalinityController,
                    onChanged: (val) => setState(() => _alkalinity = val),
                    isInteger: true,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    l10n.selectProduct,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildProductSelector(l10n, isDark),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calculateTreatment,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primaryAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                      child: Text(l10n.calculate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (_result != null) 
                    ResultCard(
                      result: _result!, 
                      label: l10n.resultAmount,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSelector(AppLocalizations l10n, bool isDark) {
    final isDecreasing = _targetPh < _currentPh;
    
    final allProducts = {
      'bicarbonate': {'name': l10n.sodiumBicarbonate, 'color': Colors.blue},
      'carbonate': {'name': l10n.sodiumCarbonate, 'color': Colors.orange},
      'caustic': {'name': l10n.causticSoda, 'color': Colors.red},
      'reducer': {'name': l10n.phReducer, 'color': Colors.purple},
    };

    final products = Map.fromEntries(
      allProducts.entries.where((e) => isDecreasing ? e.key == 'reducer' : e.key != 'reducer')
    );

    return Column(
      children: products.entries.map((entry) {
        final isSelected = _selectedProduct == entry.key;
        final color = entry.value['color'] as Color;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () => setState(() => _selectedProduct = entry.key),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? color.withValues(alpha: 0.1) : (isDark ? AppColors.surfaceDark : Colors.white),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? color : (isDark ? AppColors.borderDark : AppColors.borderLight),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: isSelected ? color : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.value['name'] as String,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? color : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _calculateTreatment() {
    if (_selectedProduct == null) return;

    final service = PhCalculatorService();
    
    final grams = service.calculate(
      volumeLiters: widget.pool.volumeLiters ?? 0.0,
      currentPh: _currentPh,
      targetPh: _targetPh,
      alkalinity: _alkalinity,
      productKey: _selectedProduct!,
    );

    setState(() {
      _result = grams;
    });
    
    FocusScope.of(context).unfocus();
  }

  void _handlePhChange() {
    final isDecreasing = _targetPh < _currentPh;
    if (isDecreasing) {
      _selectedProduct = 'reducer';
    } else {
      if (_selectedProduct == 'reducer') {
        _selectedProduct = null;
      }
    }
  }
}
