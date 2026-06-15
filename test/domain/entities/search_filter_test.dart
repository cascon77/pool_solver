import 'package:flutter_test/flutter_test.dart';
import 'package:pool_solution/domain/entities/entities.dart';

void main() {
  group('SearchFilter', () {
    final now = DateTime.now();
    final filter = SearchFilter(
      searchTerm: 'test',
      startDate: now,
      endDate: now,
      exactDate: now,
      foreignKeyId: 1,
      format: 'granulated',
      shape: 'rectangular',
      category: 'general',
      type: 'cloro',
      limit: 50,
      offset: 10,
    );

    test('Debe crear una SearchFilter instance', () {
      expect(filter.searchTerm, 'test');
      expect(filter.startDate, now);
      expect(filter.endDate, now);
      expect(filter.exactDate, now);
      expect(filter.foreignKeyId, 1);
      expect(filter.format, 'granulated');
      expect(filter.shape, 'rectangular');
      expect(filter.category, 'general');
      expect(filter.type, 'cloro');
      expect(filter.limit, 50);
      expect(filter.offset, 10);
    });

    test('Deberían tener valores por defecto para limit y offset', () {
      final defaultFilter = SearchFilter();
      expect(defaultFilter.limit, 100);
      expect(defaultFilter.offset, 0);
    });

    test('copyWith debe devolver una nueva instancia con la actualización de los datos', () {
      final updatedFilter = filter.copyWith(searchTerm: 'updated', limit: 20);

      expect(updatedFilter.searchTerm, 'updated');
      expect(updatedFilter.limit, 20);
      expect(updatedFilter.offset, filter.offset);
      expect(updatedFilter.startDate, filter.startDate);
    });
  });
}
