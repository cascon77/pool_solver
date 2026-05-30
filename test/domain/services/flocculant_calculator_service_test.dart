import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/services/flocculant_calculator_service.dart';

void main() {
  late FlocculantCalculatorService service;

  setUp(() {
    service = FlocculantCalculatorService();
  });

  group('FlocculantCalculatorService', () {
    const double volume = 10000;

    group('Sulfato de Aluminio (g)', () {
      test('debe calcular 300g para turbidez baja (0.03 g/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'sulfato',
          turbidity: 'low',
        );
        expect(result, 300.0);
      });

      test('debe calcular 400g para turbidez media (0.04 g/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'sulfato',
          turbidity: 'medium',
        );
        expect(result, 400.0);
      });

      test('debe calcular 500g para turbidez alta (0.05 g/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'sulfato',
          turbidity: 'high',
        );
        expect(result, 500.0);
      });
    });

    group('Floculante Líquido (L)', () {
      test('debe calcular 0.3L para turbidez baja (0.00003 L/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'liquid',
          turbidity: 'low',
        );
        expect(result, closeTo(0.3, 0.0001));
      });

      test('debe calcular 0.4L para turbidez media (0.00004 L/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'liquid',
          turbidity: 'medium',
        );
        expect(result, closeTo(0.4, 0.0001));
      });

      test('debe calcular 0.5L para turbidez alta (0.00005 L/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'liquid',
          turbidity: 'high',
        );
        expect(result, closeTo(0.5, 0.0001));
      });
    });

    group('Clarificante Concentrado (L)', () {
      test('debe calcular 0.075L para turbidez baja (0.0000075 L/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'clarificante',
          turbidity: 'low',
        );
        expect(result, closeTo(0.075, 0.0000001));
      });

      test('debe calcular 0.1L para turbidez media (0.00001 L/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'clarificante',
          turbidity: 'medium',
        );
        expect(result, closeTo(0.1, 0.0000001));
      });

      test('debe calcular 0.125L para turbidez alta (0.0000125 L/L)', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'clarificante',
          turbidity: 'high',
        );
        expect(result, closeTo(0.125, 0.0000001));
      });
    });

    group('Validaciones y Errores', () {
      test('debe lanzar ArgumentError para producto no válido', () {
        expect(
          () => service.calculate(
            volumeLiters: volume,
            productKey: 'desconocido',
            turbidity: 'low',
          ),
          throwsArgumentError,
        );
      });

      test('debe lanzar ArgumentError para turbidez no válida', () {
        expect(
          () => service.calculate(
            volumeLiters: volume,
            productKey: 'sulfato',
            turbidity: 'extrema',
          ),
          throwsArgumentError,
        );
      });

      test('debe ser insensible a mayúsculas/minúsculas en los inputs', () {
        final result = service.calculate(
          volumeLiters: volume,
          productKey: 'LiQuId',
          turbidity: 'MEDIUM',
        );
        expect(result, closeTo(0.4, 0.0001));
      });
    });
  });
}
