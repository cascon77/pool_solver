import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('TipEntity', () {
    const tip = TipEntity(
      id: 1,
      category: 'general',
      poolType: 'lona',
      filterType: 'arena',
      chemicalType: 'cloro',
    );

    test('Debe crear una TipEntity instance', () {
      expect(tip.id, 1);
      expect(tip.category, 'general');
      expect(tip.poolType, 'lona');
      expect(tip.filterType, 'arena');
      expect(tip.chemicalType, 'cloro');
    });

    group('appliesToPool', () {
      test('should return true if configuration matches exactly', () {
        expect(
          tip.appliesToPool(
            poolType: 'lona',
            filterType: 'arena',
            chemicalType: 'cloro',
          ),
          isTrue,
        );
      });

      test('should return false if poolType does not match', () {
        expect(
          tip.appliesToPool(
            poolType: 'obra',
            filterType: 'arena',
            chemicalType: 'cloro',
          ),
          isFalse,
        );
      });

      test('should return true if tip fields are "all"', () {
        const allTip = TipEntity(
          id: 2,
          category: 'general',
          poolType: 'all',
          filterType: 'all',
          chemicalType: 'all',
        );
        expect(
          allTip.appliesToPool(
            poolType: 'any',
            filterType: 'any',
            chemicalType: 'any',
          ),
          isTrue,
        );
      });

      test('should return true if tip fields are null (defaults to all)', () {
        const nullTip = TipEntity(
          id: 3,
          category: 'general',
        );
        expect(
          nullTip.appliesToPool(
            poolType: 'any',
            filterType: 'any',
            chemicalType: 'any',
          ),
          isTrue,
        );
      });

      test('should return false if any specific field does not match', () {
        expect(
          tip.appliesToPool(
            poolType: 'lona',
            filterType: 'cartucho',
            chemicalType: 'cloro',
          ),
          isFalse,
        );
      });
    });
  });
}
