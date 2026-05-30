class FlocculantCalculatorService {
  static const Set<String> validProducts = {'sulfato', 'liquid', 'clarificante'};
  static const Set<String> validTurbidities = {'low', 'medium', 'high'};

  double calculate({
    required double volumeLiters,
    required String productKey,
    required String turbidity,
  }) {
    final t = turbidity.toLowerCase();
    if (!validTurbidities.contains(t)) {
      throw ArgumentError('Nivel de turbidez no válido: $turbidity. Valores válidos: $validTurbidities');
    }

    final p = productKey.toLowerCase();
    if (!validProducts.contains(p)) {
      throw ArgumentError('Producto no reconocido: $productKey. Casos válidos: $validProducts');
    }
        switch (p) {
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
    return litros * 0.05; // 'high'
  }

  double _calcLiquid(double litros, String t) {
    if (t == 'low') return litros * 0.00003;
    if (t == 'medium') return litros * 0.00004;
    return litros * 0.00005; // 'high'
  }

  double _calcClarificante(double litros, String t) {
    if (t == 'low') return litros * 0.0000075;
    if (t == 'medium') return litros * 0.00001;
    return litros * 0.0000125; // 'high'
  }
}
