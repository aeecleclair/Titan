import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/providers/product_provider.dart';

void main() {
  group('ProductNotifier', () {
    late ProductNotifier productNotifier;

    setUp(() {
      productNotifier = ProductNotifier();
    });

    test('initial state is empty product', () {
      expect(productNotifier.state, isA<Product>());
      expect(productNotifier.state.id, Product.empty().id);
    });

    test('setProduct updates state', () {
      final product = Product.empty().copyWith(name: 'Test Product', price: 10);
      productNotifier.setProduct(product);
      expect(productNotifier.state, product);
    });
  });

  group('productProvider', () {
    test('returns ProductNotifier', () {
      final container = ProviderContainer();
      final productNotifier = container.read(productProvider.notifier);
      expect(productNotifier, isA<ProductNotifier>());
    });

    test('returns empty product initially', () {
      final container = ProviderContainer();
      final product = container.read(productProvider);
      expect(product, isA<Product>());
      expect(product.id, Product.empty().id);
    });

    test('setProduct updates product', () {
      final container = ProviderContainer();
      final product = Product.empty().copyWith(name: 'Test Product', price: 10);
      container.read(productProvider.notifier).setProduct(product);
      expect(container.read(productProvider), product);
    });
  });
}
