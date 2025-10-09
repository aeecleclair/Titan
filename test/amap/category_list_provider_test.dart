import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/providers/category_list_provider.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/amap/repositories/product_repository.dart';

class MockProductListRepository extends Mock implements ProductListRepository {}

void main() {
  group('categoryListProvider', () {
    test('returns a list of categories when productListProvider is loaded', () {
      final productListRepository = MockProductListRepository();
      final productListNotifier = ProductListNotifier(
        productListRepository: productListRepository,
      );
      productListNotifier.state = AsyncValue.data([
        Product.empty().copyWith(
          id: '1',
          name: 'Product A',
          category: 'Category A',
          price: 10,
        ),
        Product.empty().copyWith(
          id: '2',
          name: 'Product B',
          category: 'Category B',
          price: 20,
        ),
        Product.empty().copyWith(
          id: '3',
          name: 'Product C',
          category: 'Category A',
          price: 30,
        ),
      ]);
      final container = ProviderContainer(
        overrides: [
          productListProvider.overrideWith((ref) => productListNotifier),
        ],
      );

      final result = container.read(categoryListProvider);

      expect(result, ['Category A', 'Category B']);
    });

    test('returns an empty list when productListProvider is loading', () {
      final productListRepository = MockProductListRepository();
      final productListNotifier = ProductListNotifier(
        productListRepository: productListRepository,
      );
      productListNotifier.state = const AsyncValue.loading();
      final container = ProviderContainer(
        overrides: [
          productListProvider.overrideWith((ref) => productListNotifier),
        ],
      );

      final result = container.read(categoryListProvider);

      expect(result, []);
    });

    test('returns an empty list when productListProvider has an error', () {
      final productListRepository = MockProductListRepository();
      final productListNotifier = ProductListNotifier(
        productListRepository: productListRepository,
      );
      productListNotifier.state = const AsyncValue.error(
        "test",
        StackTrace.empty,
      );
      final container = ProviderContainer(
        overrides: [
          productListProvider.overrideWith((ref) => productListNotifier),
        ],
      );

      final result = container.read(categoryListProvider);

      expect(result, []);
    });
  });
}
