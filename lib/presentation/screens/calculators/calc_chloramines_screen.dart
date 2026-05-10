import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/core/widgets/common/header_calc.dart';
import 'package:pool_solution/core/widgets/common/numeric_step_input.dart';
import 'package:pool_solution/core/widgets/common/volume_info_card.dart';
import 'package:pool_solution/core/widgets/common/result_card.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/services/chloramines_calculator_service.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class CalcChloraminesScreen extends StatefulWidget {
  final PoolEntity pool;
  const CalcChloraminesScreen({super.key, required this.pool});

  @override
  State<CalcChloraminesScreen> createState() => _CalcChloraminesScreenState();
}

class _CalcChloraminesScreenState extends State<CalcChloraminesScreen> {
  double _totalCl = 1.5;
  double _freeCl = 1.0;
  double? _combinedCl;
  double? _shockDose;

  late TextEditingController _totalController;
  late TextEditingController _freeController;

  @override
  void initState() {
    super.initState();
    _totalController = TextEditingController(text: _totalCl.toStringAsFixed(1));
    _freeController = TextEditingController(text: _freeCl.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _totalController.dispose();
    _freeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final volumeLiters = widget.pool.volumeLiters ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.chloramines),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: [
            HeaderCalc(
              img: "assets/images/chloramines.png",
              desc: l10n.chloraminesDesc,
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
                          label: l10n.chloraminesTotal,
                          value: _totalCl,
                          step: 0.1,
                          min: 0.0,
                          max: 10.0,
                          controller: _totalController,
                          onChanged: (val) => setState(() => _totalCl = val),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NumericStepInput(
                          label: l10n.chloraminesFree,
                          value: _freeCl,
                          step: 0.1,
                          min: 0.0,
                          max: 10.0,
                          controller: _freeController,
                          onChanged: (val) => setState(() => _freeCl = val),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _calculate,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.primaryAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(l10n.calculate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (_combinedCl != null) ...[
                    Text(
                      "${l10n.chloraminesCombined}: ${_combinedCl!.toStringAsFixed(2).replaceAll('.', ',')} ppm",
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: _combinedCl! > 0.5 ? Colors.red : Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_shockDose! > 0)
                      ResultCard(
                        result: _shockDose!, 
                        label: l10n.shockDoseLabel,
                      )
                    else
                      Card(
                        color: Colors.green.withValues(alpha: 0.1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.green),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle, color: Colors.green),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  l10n.chloraminesAcceptable,
                                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculate() {
    final service = ChloraminesCalculatorService();
    setState(() {
      _combinedCl = service.calculateCombinedChlorine(_totalCl, _freeCl);
      _shockDose = service.calculateShockDose(
        volumeLiters: widget.pool.volumeLiters ?? 0.0,
        combinedCl: _combinedCl!,
      );
    });
    FocusScope.of(context).unfocus();
  }
}
