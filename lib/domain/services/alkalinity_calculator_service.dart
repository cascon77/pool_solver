class AlkalinityCalculatorService {
  /// Grams of Sodium Bicarbonate to increase 1 ppm in 1 m3 (1000 liters)
  static const double bicarbonateFactor = 1.8;

  double calculate({
    required double volumeLiters,
    required double currentAlkalinity,
    required double targetAlkalinity,
  }) {
    if (volumeLiters <= 0 ) {
      throw ArgumentError('El volumen debe ser mayor a cero.');
    }
    if (targetAlkalinity <= currentAlkalinity) {
      throw ArgumentError('La alcalinidad debe ser mayor a la actual.');
    }

    final volumeM3 = volumeLiters / 1000;
    final delta = targetAlkalinity - currentAlkalinity;

    return volumeM3 * delta * bicarbonateFactor;
  }
}
