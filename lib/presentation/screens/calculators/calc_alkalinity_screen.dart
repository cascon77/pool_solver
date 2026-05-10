import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/core/widgets/common/header_calc.dart';
import 'package:pool_solution/core/widgets/common/numeric_step_input.dart';
import 'package:pool_solution/core/widgets/common/volume_info_card.dart';
import 'package:pool_solution/core/widgets/common/result_card.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/services/alkalinity_calculator_service.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class CalcAlkalinityScreen extends StatefulWidget {
  final PoolEntity pool;
  const CalcAlkalinityScreen({super.key, required this.pool});

  @override
  State<CalcAlkalinityScreen> createState() => _CalcAlkalinityScreenState();
}

class _CalcAlkalinityScreenState extends State<CalcAlkalinityScreen> {
  double _currentAlk = 80.0;
  double _targetAlk = 100.0;
  double? _result;

  late TextEditingController _currentController;
  late TextEditingController _targetController;

  @override
  void initState() {
    super.initState();
    _currentController = TextEditingController(text: _currentAlk.toStringAsFixed(0));
    _targetController = TextEditingController(text: _targetAlk.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _currentController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final volumeLiters = widget.pool.volumeLiters ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.alkalinity),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: [
            HeaderCalc(
              img: "assets/images/alkalinity.png",
              desc: l10n.alkalinityDesc,
            ),
            
            VolumeInfoCard(volumeLiters: volumeLiters),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  NumericStepInput(
                    label: l10n.alkalinityCurrentPpm,
                    value: _currentAlk,
                    step: 5,
                    min: 0,
                    max: 500,
                    controller: _currentController,
                    onChanged: (val) => setState(() => _currentAlk = val),
                    isInteger: true,
                  ),

                  const SizedBox(height: 20),
                  
                  NumericStepInput(
                    label: l10n.alkalinityTargetPpm,
                    value: _targetAlk,
                    step: 5,
                    min: 0,
                    max: 500,
                    controller: _targetController,
                    onChanged: (val) => setState(() => _targetAlk = val),
                    isInteger: true,
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

                  if (_result != null) 
                    ResultCard(
                      result: _result!, 
                      label: l10n.sodiumBicarbonate,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculate() {
    final service = AlkalinityCalculatorService();
    setState(() {
      _result = service.calculate(
        volumeLiters: widget.pool.volumeLiters ?? 0.0,
        currentAlkalinity: _currentAlk,
        targetAlkalinity: _targetAlk,
      );
    });
    FocusScope.of(context).unfocus();
  }
}
