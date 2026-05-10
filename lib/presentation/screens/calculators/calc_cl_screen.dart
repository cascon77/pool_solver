import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/core/widgets/common/header_calc.dart';
import 'package:pool_solution/core/widgets/common/numeric_step_input.dart';
import 'package:pool_solution/core/widgets/common/volume_info_card.dart';
import 'package:pool_solution/core/widgets/common/result_card.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/services/cl_calculator_service.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class CalcClScreen extends StatefulWidget {
  final PoolEntity pool;
  const CalcClScreen({super.key, required this.pool});

  @override
  State<CalcClScreen> createState() => _CalcClScreenState();
}

class _CalcClScreenState extends State<CalcClScreen> {
  double _currentCl = 0.5;
  double _targetCl = 2.0;
  int _bathers = 0;
  double _concentration = 10.0;
  int _tabletGrams = 200;
  String? _selectedProduct;
  double? _result;

  late TextEditingController _currentClController;
  late TextEditingController _targetClController;
  late TextEditingController _bathersController;
  late TextEditingController _concentrationController;
  late TextEditingController _tabletGramsController;

  @override
  void initState() {
    super.initState();
    _currentClController = TextEditingController(text: _currentCl.toStringAsFixed(1));
    _targetClController = TextEditingController(text: _targetCl.toStringAsFixed(1));
    _bathersController = TextEditingController(text: _bathers.toString());
    _concentrationController = TextEditingController(text: _concentration.toStringAsFixed(0));
    _tabletGramsController = TextEditingController(text: _tabletGrams.toString());
  }

  @override
  void dispose() {
    _currentClController.dispose();
    _targetClController.dispose();
    _bathersController.dispose();
    _concentrationController.dispose();
    _tabletGramsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final volumeLiters = widget.pool.volumeLiters ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("${l10n.calculator} ${l10n.chlorine}"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: [
            HeaderCalc(
              img: "assets/images/cloro.png",
              desc: l10n.cloroCalcDescription,
            ),
            
            VolumeInfoCard(volumeLiters: volumeLiters),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  if (_selectedProduct != 'tablets') ...[
                    Row(
                      children: [
                        Expanded(
                          child: NumericStepInput(
                            label: l10n.initialCl,
                            value: _currentCl,
                            step: 0.1,
                            min: 0.0,
                            max: 10.0,
                            controller: _currentClController,
                            onChanged: (val) => setState(() => _currentCl = val),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: NumericStepInput(
                            label: l10n.targetCl,
                            value: _targetCl,
                            step: 0.1,
                            min: 0.0,
                            max: 10.0,
                            controller: _targetClController,
                            onChanged: (val) => setState(() => _targetCl = val),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],

                  NumericStepInput(
                    label: l10n.bathers,
                    value: _bathers.toDouble(),
                    step: 1,
                    min: 0,
                    max: 100,
                    controller: _bathersController,
                    onChanged: (val) => setState(() => _bathers = val.toInt()),
                    isInteger: true,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    l10n.selectProduct,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildProductSelector(l10n, isDark),

                  if (_selectedProduct == 'liquid') ...[
                    const SizedBox(height: 16),
                    NumericStepInput(
                      label: l10n.concentration,
                      value: _concentration,
                      step: 1,
                      min: 1,
                      max: 100,
                      controller: _concentrationController,
                      onChanged: (val) => setState(() => _concentration = val),
                      isInteger: true,
                    ),
                  ],

                  if (_selectedProduct == 'tablets') ...[
                    const SizedBox(height: 16),
                    NumericStepInput(
                      label: l10n.tabletSize,
                      value: _tabletGrams.toDouble(),
                      step: 10,
                      min: 10,
                      max: 1000,
                      controller: _tabletGramsController,
                      onChanged: (val) => setState(() => _tabletGrams = val.toInt()),
                      isInteger: true,
                    ),
                  ],

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
                      label: _selectedProduct == 'tablets' ? l10n.resultTablets : (_selectedProduct == 'liquid' ? l10n.resultLiters : l10n.resultAmount),
                      unit: _selectedProduct == 'tablets' ? "" : (_selectedProduct == 'liquid' ? "L" : "g"),
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
    final products = {
      'tricloro': {'name': l10n.productTricloroGranulado, 'color': Colors.blue},
      'tablets': {'name': l10n.productTricloroTabletas, 'color': Colors.blueGrey},
      'dicloro': {'name': l10n.productDicloro, 'color': Colors.cyan},
      'hipoclorito': {'name': l10n.productHipocloritoCalcio, 'color': Colors.indigo},
      'liquid': {'name': l10n.productCloroLiquido, 'color': Colors.teal},
    };

    return Column(
      children: products.entries.map((entry) {
        final isSelected = _selectedProduct == entry.key;
        final color = entry.value['color'] as Color;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: InkWell(
            onTap: () => setState(() {
              _selectedProduct = entry.key;
              _result = null;
            }),
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
                  Expanded(
                    child: Text(
                      entry.value['name'] as String,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? color : null,
                      ),
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

    final service = ClCalculatorService();
    final liters = widget.pool.volumeLiters ?? 0.0;
    double res = 0;

    switch (_selectedProduct) {
      case 'tricloro':
        res = service.calculateTricloroGranulado(liters: liters, currentCl: _currentCl, targetCl: _targetCl, bathers: _bathers);
        break;
      case 'dicloro':
        res = service.calculateDicloro(liters: liters, currentCl: _currentCl, targetCl: _targetCl, bathers: _bathers);
        break;
      case 'hipoclorito':
        res = service.calculateHipocloritoCalcio(liters: liters, currentCl: _currentCl, targetCl: _targetCl, bathers: _bathers);
        break;
      case 'liquid':
        res = service.calculateCloroLiquido(liters: liters, currentCl: _currentCl, targetCl: _targetCl, concentration: _concentration, bathers: _bathers);
        break;
      case 'tablets':
        res = service.calculateTricloroTabletas(liters: liters, tabletGrams: _tabletGrams, bathers: _bathers);
        break;
    }

    setState(() {
      _result = res;
    });
    
    FocusScope.of(context).unfocus();
  }
}
