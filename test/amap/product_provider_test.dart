import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/amap/providers/product_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/builders/empty_models.dart';

void main() {
  group('ProductNotifier', () {
    late ProductNotifier productNotifier;

    final product = AppModulesAmapSchemasAmapProductComplete(
      id: '1',
      name: 'Test Product',
      category: 'Category 1',
      price: 10.0,
    );

    setUp(() {
      productNotifier = ProductNotifier();
    });

    test('initial state is empty product', () {
      expect(
        productNotifier.state,
        isA<AppModulesAmapSchemasAmapProductComplete>(),
      );
      expect(
        productNotifier.state.id,
        EmptyModels.empty<AppModulesAmapSchemasAmapProductComplete>().id,
      );
    });

    test('setProduct updates state', () {
      productNotifier.setProduct(product);
      expect(productNotifier.state, product);
    });
  });

  group('productProvider', () {
    final product = AppModulesAmapSchemasAmapProductComplete(
      id: '1',
      name: 'Test Product',
      category: 'Category 1',
      price: 10.0,
    );

    test('returns ProductNotifier', () {
      final container = ProviderContainer();
      final productNotifier = container.read(productProvider.notifier);
      expect(productNotifier, isA<ProductNotifier>());
    });

    test('returns empty product initially', () {
      final container = ProviderContainer();
      final product = container.read(productProvider);
      expect(product, isA<AppModulesAmapSchemasAmapProductComplete>());
      expect(
        product.id,
        EmptyModels.empty<AppModulesAmapSchemasAmapProductComplete>().id,
      );
    });

    test('setProduct updates product', () {
      final container = ProviderContainer();
      container.read(productProvider.notifier).setProduct(product);
      expect(container.read(productProvider), product);
    });
  });
}
