import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/cl_calculator_service.dart';

void main() {
  final service = ClCalculatorService();

  group('ClCalculatorService - Cálculos Válidos', () {
    const double volume = 10000.0;

    test('Tricloro Granulado: debe calcular correctamente sin bañistas', () {
      final result = service.calculateTricloroGranulado(
        liters: volume,
        currentCl: 1.0,
        targetCl: 2.0,
        bathers: 0,
      );
      // (10000 * 1 * 0.001111) + 0 = 11.11
      expect(result, closeTo(11.11, 0.01));
    });

    test('Tricloro Granulado: debe incluir el extra por bañistas', () {
      final result = service.calculateTricloroGranulado(
        liters: volume,
        currentCl: 1.0,
        targetCl: 2.0,
        bathers: 5,
      );
      // 11.11 + (5 * 3) = 26.11
      expect(result, closeTo(26.11, 0.01));
    });

    test('Dicloro: debe calcular correctamente', () {
      final result = service.calculateDicloro(
        liters: volume,
        currentCl: 1.0,
        targetCl: 2.0,
        bathers: 0,
      );
      // 10000 * 1 * 0.001818 = 18.18
      expect(result, closeTo(18.18, 0.01));
    });

    test('Hipoclorito de Calcio: debe calcular correctamente', () {
      final result = service.calculateHipocloritoCalcio(
        liters: volume,
        currentCl: 1.0,
        targetCl: 2.0,
        bathers: 0,
      );
      // 10000 * 1 * 0.001493 = 14.93
      expect(result, closeTo(14.93, 0.01));
    });

    test('Cloro Líquido: debe calcular correctamente según concentración', () {
      final result = service.calculateCloroLiquido(
        liters: volume,
        currentCl: 1.0,
        targetCl: 2.0,
        concentration: 10.0, // 10%
        bathers: 0,
      );
      // (10000 * 1 * 0.00001) / (10/10) = 0.1 L
      expect(result, closeTo(0.1, 0.001));
    });

    test('Tricloro en Tabletas: debe calcular número de tabletas semanal', () {
      final result = service.calculateTricloroTabletas(
        liters: volume,
        tabletGrams: 200,
        bathers: 0,
      );
      // (10000 * 0.012445) / 200 = 0.62225 tabletas
      expect(result, closeTo(0.622, 0.001));
    });
  });

  group('ClCalculatorService - Validaciones', () {
    test('Debe lanzar ArgumentError si el volumen es <= 0', () {
      expect(
        () => service.calculateTricloroGranulado(
          liters: 0,
          currentCl: 1.0,
          targetCl: 2.0,
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError si el cloro objetivo es menor al actual', () {
      expect(
        () => service.calculateDicloro(
          liters: 10000,
          currentCl: 3.0,
          targetCl: 2.0,
        ),
        throwsArgumentError,
      );
    });

    test('Debe lanzar ArgumentError si el número de bañistas es negativo', () {
      expect(
        () => service.calculateHipocloritoCalcio(
          liters: 10000,
          currentCl: 1.0,
          targetCl: 2.0,
          bathers: -1,
        ),
        throwsArgumentError,
      );
    });
  });
}
