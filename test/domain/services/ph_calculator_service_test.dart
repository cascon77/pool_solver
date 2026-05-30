import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/ph_calculator_service.dart';

void main() {
  final service = PhCalculatorService();

  group('Test start, calculo de ph con bicarbonato', () {
    test('Todo correcto', () {
      final result = service.calculate(
        volumeLiters: 56000,
        currentPh: 3.0,
        targetPh: 7.0,
        alkalinity: 100,
        productKey: 'bicarbonate',
      );
      expect(result, 21996.8);
    });
    test('Debería lanzar ArgumentError si el volumen es 0 o negativo', () {
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
    test('Debería lanzar ArgumentError si la alcalinidad negativa', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: 7.0,
          alkalinity: -10,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });
    test('Alcalinidad con valor 0', () {
      final resultado = service.calculate(
        volumeLiters: 56000,
        currentPh: 3.0,
        targetPh: 7.0,
        alkalinity: 0,
        productKey: 'bicarbonate',
      );
      expect(resultado, 21996.8);
    });
    test('Deberia lanzar ArgumentError si el producto no existe', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'no existo',
        ),
        throwsArgumentError,
      );
    });
    test('Deberia lanzar ArgumentError si el ph es negativo', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: -3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
      expect(
            () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: -7.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });
  });
}
