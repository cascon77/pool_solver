import 'package:flutter/material.dart';
import 'package:pool_solution/core/theme/app_colors.dart';
import 'package:pool_solution/core/widgets/common/header_calc.dart';
import 'package:pool_solution/core/widgets/common/volume_info_card.dart';
import 'package:pool_solution/core/widgets/common/result_card.dart';
import 'package:pool_solution/domain/entities/entities.dart';
import 'package:pool_solution/domain/services/flocculant_calculator_service.dart';
import 'package:pool_solution/l10n/app_localizations.dart';

class CalcFlocculantScreen extends StatefulWidget {
  final PoolEntity pool;
  const CalcFlocculantScreen({super.key, required this.pool});

  @override
  State<CalcFlocculantScreen> createState() => _CalcFlocculantScreenState();
}

class _CalcFlocculantScreenState extends State<CalcFlocculantScreen> {
  String _selectedTurbidity = 'medium'; // 'low', 'medium', 'high'
  String _selectedProduct = 'liquid'; // 'sulfato', 'liquid', 'clarificante'
  double? _result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final volumeLiters = widget.pool.volumeLiters ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Floculante"),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 60),
          children: [
            HeaderCalc(
              img: "assets/images/flocculant.png",
              desc: l10n.flocculantDesc,
            ),
            
            VolumeInfoCard(volumeLiters: volumeLiters),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  
                  Text(
                    l10n.turbidityLevel,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildTurbiditySelector(l10n, isDark),

                  const SizedBox(height: 24),

                  Text(
                    l10n.selectProduct,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildProductSelector(l10n, isDark),

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
                        elevation: 4,
                      ),
                      child: Text(l10n.calculate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (_result != null) 
                    ResultCard(
                      result: _result!, 
                      label: _getProductName(_selectedProduct, l10n),
                      unit: _selectedProduct == 'sulfato' ? "g" : "L",
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTurbiditySelector(AppLocalizations l10n, bool isDark) {
    final options = [
      {'key': 'low', 'label': l10n.low},
      {'key': 'medium', 'label': l10n.medium},
      {'key': 'high', 'label': l10n.high},
    ];

    final selectedIndex = options.indexWhere((opt) => opt['key'] == _selectedTurbidity);

    return LayoutBuilder(builder: (context, constraints) {
      final itemWidth = (constraints.maxWidth - 8) / 3;

      return Container(
        height: 54,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.grey[100],
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              left: selectedIndex * itemWidth,
              child: Container(
                width: itemWidth,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.primaryAccent,
                  borderRadius: BorderRadius.circular(23),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryAccent.withValues(alpha: 0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: options.map((opt) {
                final isSelected = _selectedTurbidity == opt['key'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _selectedTurbidity = opt['key']!;
                      _result = null;
                    }),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: Text(
                        opt['label']!,
                        style: TextStyle(
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black54),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProductSelector(AppLocalizations l10n, bool isDark) {
    final products = {
      'liquid': {'name': l10n.productFloculanteLiquido, 'color': Colors.blue},
      'sulfato': {'name': l10n.productSulfatoAluminio, 'color': Colors.indigo},
      'clarificante': {'name': l10n.productClarificante, 'color': Colors.cyan},
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

  String _getProductName(String key, AppLocalizations l10n) {
    switch (key) {
      case 'sulfato': return l10n.productSulfatoAluminio;
      case 'liquid': return l10n.productFloculanteLiquido;
      case 'clarificante': return l10n.productClarificante;
      default: return "";
    }
  }

  void _calculate() {
    final service = FlocculantCalculatorService();
    setState(() {
      _result = service.calculate(
        volumeLiters: widget.pool.volumeLiters ?? 0.0,
        productKey: _selectedProduct,
        turbidity: _selectedTurbidity,
      );
    });
    FocusScope.of(context).unfocus();
  }
}
