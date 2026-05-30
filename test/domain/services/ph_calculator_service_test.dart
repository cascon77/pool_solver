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
    test('Deberia lanzar ArgumentError si reduces el ph y con bicarbonato', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: 2.0,
          alkalinity: 100,
          productKey: 'bicarbonate',
        ),
        throwsArgumentError,
      );
    });
  });

  group('Test start, calculo de ph con carbonato', () {
    test('Todo correcto', () {
      final result = service.calculate(
        volumeLiters: 56000,
        currentPh: 3.0,
        targetPh: 7.0,
        alkalinity: 100,
        productKey: 'carbonate',
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
          productKey: 'carbonate',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 0,
          currentPh: 3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'carbonate',
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
          productKey: 'carbonate',
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
        productKey: 'carbonate',
      );
      expect(resultado, 21996.8);
    });
    test('Deberia lanzar ArgumentError si el ph es negativo', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: -3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'carbonate',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: -7.0,
          alkalinity: 100,
          productKey: 'carbonate',
        ),
        throwsArgumentError,
      );
    });
    test('Deberia lanzar ArgumentError si reduces el ph y con bicarbonato', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: 2.0,
          alkalinity: 100,
          productKey: 'carbonate',
        ),
        throwsArgumentError,
      );
    });
  });

  group('Test start, calculo de ph con caustic', () {
    test('Todo correcto', () {
      final result = service.calculate(
        volumeLiters: 56000,
        currentPh: 3.0,
        targetPh: 7.0,
        alkalinity: 100,
        productKey: 'caustic',
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
          productKey: 'caustic',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 0,
          currentPh: 3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'caustic',
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
          productKey: 'caustic',
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
        productKey: 'caustic',
      );
      expect(resultado, 21996.8);
    });
    test('Deberia lanzar ArgumentError si el ph es negativo', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: -3.0,
          targetPh: 7.0,
          alkalinity: 100,
          productKey: 'caustic',
        ),
        throwsArgumentError,
      );
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: -7.0,
          alkalinity: 100,
          productKey: 'caustic',
        ),
        throwsArgumentError,
      );
    });
    test('Deberia lanzar ArgumentError si reduces el ph y con bicarbonato', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 3.0,
          targetPh: 2.0,
          alkalinity: 100,
          productKey: 'caustic',
        ),
        throwsArgumentError,
      );
    });
  });
  group('Test start, calculo de ph con reducer', () {
    test('Todo correcto', () {
      final result = service.calculate(
        volumeLiters: 56000,
        currentPh: 7.0,
        targetPh: 3.0,
        alkalinity: 100,
        productKey: 'reducer',
      );
      expect(result, 21996.8);
    });
    test('Debería lanzar ArgumentError si el volumen es negativo', () {
      expect(
        () => service.calculate(
          volumeLiters: -56000,
          currentPh: 7.0,
          targetPh: 3.0,
          alkalinity: 100,
          productKey: 'reducer',
        ),
        throwsArgumentError,
      );
    });
    test('Debería lanzar ArgumentError si la alcalinidad negativa', () {
      expect(
        () => service.calculate(
          volumeLiters: 56000,
          currentPh: 7.0,
          targetPh: 3.0,
          alkalinity: -10,
          productKey: 'reducer',
        ),
        throwsArgumentError,
      );
    });
    test(
      'Deberia lanzar ArgumentError si se utiliza el reductor para aumentar ph',
      () {
        expect(
          () => service.calculate(
            volumeLiters: 56000,
            currentPh: 7.0,
            targetPh: 8.0,
            alkalinity: 100,
            productKey: 'reducer',
          ),
          throwsArgumentError,
        );
      },
    );
    group('producto no existe', (){
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
    });
  });
}
