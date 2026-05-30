import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/ph_calculator_service.dart';

void main() {
  final service = PhCalculatorService();

  group('PhCalculatorService - Cálculos Válidos', () {
    const double volume = 56000.0;
    const double alk = 100.0;

    test('Bicarbonato (factor: 0.0982, no usa densidad)', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentPh: 7.0,
        targetPh: 7.4,
        alkalinity: alk,
        productKey: 'bicarbonate',
      );
      // 0.0982 * 56000 * 0.4 * 1.0 = 2199.68
      expect(result, closeTo(2199.68, 0.01));
    });

    test('Carbonato (factor: 0.04117, usa densidad)', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentPh: 7.0,
        targetPh: 7.4,
        alkalinity: alk,
        productKey: 'carbonate',
      );
      // multiplicador de densidad = 100 / 80 = 1.25
      // 0.04117 * 56000 * 0.4 * 1.25 = 1152.76
      expect(result, closeTo(1152.76, 0.01));
    });

    test('Sosa Cáustica (factor: 0.03049, usa densidad)', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentPh: 7.0,
        targetPh: 7.4,
        alkalinity: alk,
        productKey: 'caustic',
      );
      // 0.03049 * 56000 * 0.4 * 1.25 = 853.72
      expect(result, closeTo(853.72, 0.01));
    });

    test('Reductor (factor: 0.021335, usa densidad)', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentPh: 7.6,
        targetPh: 7.2,
        alkalinity: alk,
        productKey: 'reducer',
      );
      // 0.021335 * 56000 * 0.4 * 1.25 = 597.38
      expect(result, closeTo(597.38, 0.01));
    });

    test('Alcalinidad 0 con producto basado en densidad', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentPh: 7.6,
        targetPh: 7.2,
        alkalinity: 0,
        productKey: 'reducer',
      );
      // multiplicador de densidad = 0 / 80 = 0
      expect(result, 0.0);
    });

    test('Una diferencia de 0 debería devolver 0', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentPh: 7.4,
        targetPh: 7.4,
        alkalinity: alk,
        productKey: 'bicarbonate',
      );
      expect(result, 0.0);
    });
  });

  group('PhCalculatorService - Validaciones', () {
    test('Debe lanzar ArgumentError si el volumen es <= 0', () {
      expect(
        () => service.calculate(
          volumeLiters: 0,
          currentPh: 7.0,
          targetPh: 7.4,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: -100,
          currentPh: 7.0,
          targetPh: 7.4,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError si la alcalinidad es negativa', () {
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: 7.0,
          targetPh: 7.4,
          alkalinity: -1,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError para valores de pH negativos', () {
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: -1.0,
          targetPh: 7.4,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: 7.0,
          targetPh: -1.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError para un producto desconocido', () {
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: 7.0,
          targetPh: 7.4,
          alkalinity: 100,
          productKey: 'magic_powder',
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError al usar reductor para aumentar el pH', () {
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: 7.0,
          targetPh: 7.5,
          alkalinity: 100,
          productKey: 'reducer',
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError al usar un incrementador para disminuir el pH', () {
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: 7.5,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 1000,
          currentPh: 7.5,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'carbonate',
        ),
        throwsArgumentError,
      );
    });
  });
}
