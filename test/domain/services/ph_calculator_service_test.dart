import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/ph_calculator_service.dart';

void main() {
  final service = PhCalculatorService();

  group('Test start, calculo de ph con bicarbonato', () {
    test('volumen positivo todo correcto', () {
      final result = service.calculate(
        volumeLiters: 56000,
        currentPh: 3.0,
        targetPh: 7.0,
        alkalinity: 100,
        productKey: 'bicarbonate',
      );
      expect(result, 21996.8);
    });
    test('debería lanzar ArgumentError si el volumen es 0 o negativo', () {
      expect(
        () => service.calculate(
          volumeLiters: -56000,
          currentPh: 3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 0,
          currentPh: 3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });
  });
}
