class ChloraminesCalculatorService {
  /// To perform a breakpoint chlorination, you need to add 10x the amount of combined chlorine.
  /// Result in grams of calcium hypochlorite (65%) to reach the breakpoint.
  
  double calculateCombinedChlorine(double totalCl, double freeCl) {
    if (totalCl <= freeCl) return 0;
    return totalCl - freeCl;
  }

  double calculateShockDose({
    required double volumeLiters,
    required double combinedCl,
  }) {
    if (combinedCl <= 0) return 0;
    
    // Dosage rule: 10 * combined chlorine = target ppm increase
    final targetIncrease = combinedCl * 10;
    
    // Using Calcium Hypochlorite (65%) factor: ~1.5g to raise 1ppm in 1m3
    const factor = 1.54;
    final volumeM3 = volumeLiters / 1000;
    
    return volumeM3 * targetIncrease * factor;
  }
}
