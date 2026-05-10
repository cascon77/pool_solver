class FlocculantCalculatorService {
  double calculate({
    required double volumeLiters,
    required String productKey,
    required String turbidity,
  }) {
    final t = turbidity.toLowerCase();

    switch (productKey) {
      case 'sulfato':
        return _calcSulfato(volumeLiters, t);
      case 'liquid':
        return _calcLiquid(volumeLiters, t);
      case 'clarificante':
        return _calcClarificante(volumeLiters, t);
      default:
        return 0;
    }
  }

  double _calcSulfato(double litros, String t) {
    if (t == 'low') return litros * 0.03;
    if (t == 'medium') return litros * 0.04;
    if (t == 'high') return litros * 0.05;
    return 0;
  }

  double _calcLiquid(double litros, String t) {
    if (t == 'low') return litros * 0.00003;
    if (t == 'medium') return litros * 0.00004;
    if (t == 'high') return litros * 0.00005;
    return 0;
  }

  double _calcClarificante(double litros, String t) {
    if (t == 'low') return litros * 0.0000075;
    if (t == 'medium') return litros * 0.00001;
    if (t == 'high') return litros * 0.0000125;
    return 0;
  }
}
