class PhProductConfig {
  final double factor;
  final bool usesDensity;

  const PhProductConfig({
    required this.factor,
    required this.usesDensity,
  });
}

class PhCalculatorService {
  static const Map<String, PhProductConfig> products = {
    'bicarbonate': PhProductConfig(
      factor: 0.0982,
      usesDensity: false,
    ),
    'carbonate': PhProductConfig(
      factor: 0.04117,
      usesDensity: true,
    ),
    'caustic': PhProductConfig(
      factor: 0.03049,
      usesDensity: true,
    ),
    'reducer': PhProductConfig(
      factor: 0.021335,
      usesDensity: true,
    ),
  };

  double calculate({
    required double volumeLiters,
    required double currentPh,
    required double targetPh,
    required double alkalinity,
    required String productKey,
  }) {
    final config = products[productKey];

    if (volumeLiters <= 0) {
      throw ArgumentError('El volumen debe ser mayor a cero.');
    }
    if (alkalinity < 0 ){
      throw ArgumentError('La alcalinidad no puede ser negativa.');
    }
    if(config == null){
      throw ArgumentError('Producto no encontrado.');
    }
    if(currentPh < 0 || targetPh < 0 ){
      throw ArgumentError('Los ph no pueden ser negativos.');
    }

    // Diferencia absoluta (sirve para incrementos y decrementos)
    final difference = (targetPh - currentPh).abs();

    // d / 80 de tu propuesta
    final densityMultiplier = config.usesDensity ? (alkalinity / 80) : 1.0;

    // Resultado en gramos/mililitros
    return config.factor * volumeLiters * difference * densityMultiplier;
  }
}
