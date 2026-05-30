import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/chloramines_calculator_service.dart';

void main() {
  final service = ChloraminesCalculatorService();

  group('ChloraminesCalculatorService - Cálculos Válidos', () {
    test('Debe calcularse correctamente el cloro combinado', () {
      final result = service.calculateCombinedChlorine(5.0, 3.0);
      expect(result, closeTo(2.0, 0.01));
    });

    test('Debe calcularse correctamente la dosis de choque (breakpoint)', () {
      final result = service.calculateShockDose(
        volumeLiters: 10000.0, // 10m3
        combinedCl: 0.5,
      );
      // Incremento objetivo = 0.5 * 10 = 5 ppm
      // Dosis = 10m3 * 5ppm * 1.54 = 77.0g
      expect(result, closeTo(77.0, 0.01));
    });
  });

  group('ChloraminesCalculatorService - Validaciones', () {
    test('Debe lanzar ArgumentError si el cloro libre es mayor o igual al total', () {
      expect(
        () => service.calculateCombinedChlorine(2.0, 2.0),
        throwsArgumentError,
      );
      expect(
        () => service.calculateCombinedChlorine(2.0, 3.0),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError si el volumen es <= 0', () {
      expect(
        () => service.calculateShockDose(volumeLiters: 0, combinedCl: 0.5),
        throwsArgumentError,
      );
      expect(
        () => service.calculateShockDose(volumeLiters: -100, combinedCl: 0.5),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError si el cloro combinado es <= 0', () {
      expect(
        () => service.calculateShockDose(volumeLiters: 10000, combinedCl: 0),
        throwsArgumentError,
      );
      expect(
        () => service.calculateShockDose(volumeLiters: 10000, combinedCl: -0.1),
        throwsArgumentError,
      );
    });
  });
}
