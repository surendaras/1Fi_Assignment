import 'package:flutter_test/flutter_test.dart';
import 'package:onefi_app/repositories/mock_product_repository.dart';

void main() {
  group('MockProductRepository Tests', () {
    late MockProductRepository repository;

    setUp(() {
      repository = MockProductRepository();
    });

    test('Loads categories properly', () async {
      final categories = await repository.getCategories();
      expect(categories.isNotEmpty, true);
      expect(categories.any((c) => c.id == 'smartphones'), true);
      expect(categories.any((c) => c.id == 'laptops'), true);
    });

    test('Filters products by category', () async {
      final phones = await repository.getProducts(categoryId: 'smartphones');
      expect(phones.isNotEmpty, true);
      for (final p in phones) {
        expect(p.categoryId, 'smartphones');
      }
    });

    test('Filters products by search query', () async {
      final results = await repository.getProducts(searchQuery: 'iPhone');
      expect(results.isNotEmpty, true);
      expect(results.first.title.contains('iPhone'), true);
    });

    test('Filters products by brand and No-Cost EMI', () async {
      final results = await repository.getProducts(
        brand: 'Apple',
        noCostEmiOnly: true,
      );
      expect(results.isNotEmpty, true);
      for (final p in results) {
        expect(p.brand, 'Apple');
        expect(p.hasNoCostEmi, true);
      }
    });
  });
}
