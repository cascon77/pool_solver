class ClCalculatorService {
  double calculateTricloroGranulado({
    required double liters,
    required double currentCl,
    required double targetCl,
    int bathers = 0,
  }) {
    double delta = targetCl - currentCl;
    if (delta <= 0) return 0;
    return (liters * delta * 0.001111) + (bathers * 3);
  }

  double calculateDicloro({
    required double liters,
    required double currentCl,
    required double targetCl,
    int bathers = 0,
  }) {
    double delta = targetCl - currentCl;
    if (delta <= 0) return 0;
    return (liters * delta * 0.001818) + (bathers * 4);
  }

  double calculateHipocloritoCalcio({
    required double liters,
    required double currentCl,
    required double targetCl,
    int bathers = 0,
  }) {
    double delta = targetCl - currentCl;
    if (delta <= 0) return 0;
    return (liters * delta * 0.001493) + (bathers * 4);
  }

  double calculateCloroLiquido({
    required double liters,
    required double currentCl,
    required double targetCl,
    required double concentration,
    int bathers = 0,
  }) {
    double delta = targetCl - currentCl;
    if (delta <= 0) return 0;
    double litersNeeded = (liters * delta * 0.00001) / (concentration / 10);
    return litersNeeded + (bathers * 0.03);
  }

  double calculateTricloroTabletas({
    required double liters,
    required int tabletGrams,
    int bathers = 0,
  }) {
    double gramsWeek = (liters * 0.012445) + (bathers * 21);
    return gramsWeek / tabletGrams;
  }
}
