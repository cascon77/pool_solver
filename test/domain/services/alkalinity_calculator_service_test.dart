import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/alkalinity_calculator_service.dart';

void main() {
  final service = AlkalinityCalculatorService();
  final volume = 56000.0;
  group('alkalinity calculator service', () {
    test('Debe calcularse correctamente', () {
      final result = service.calculate(
        volumeLiters: volume,
        currentAlkalinity: 100.0,
        targetAlkalinity: 120.0,
      );
      // 56 * 20 * 1.8 = 2016
      expect(result, closeTo(2016.0, 0.01));
    });
  });
  group('AlkalinityCalculatorService - Validaciones', (){
    test('Debe lanzar ArgumentError si el volumen es <= 0', () {
      expect (
        () => service.calculate(
          volumeLiters: 0,
          currentAlkalinity: 100.0,
          targetAlkalinity: 120.0,
        ),
        throwsArgumentError,
      );
    });
    test('Debe lanzar ArgumentError si la alcalinidad es menor a la actual', () {
      expect (
        () => service.calculate(
          volumeLiters: volume,
          currentAlkalinity: 120.0,
          targetAlkalinity: 100.0,
        ),
        throwsArgumentError,
      );
    });
  });
}
