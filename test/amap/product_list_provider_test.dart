import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/providers/product_list_provider.dart';
import 'package:titan/amap/repositories/product_repository.dart';

class MockProductListRepository extends Mock implements ProductListRepository {}

void main() {
  group('ProductListNotifier', () {
    test('loadProductList', () async {
      final mockProductListRepository = MockProductListRepository();
      final productList = [Product.empty().copyWith(id: "1")];
      when(
        () => mockProductListRepository.getProductList(),
      ).thenAnswer((_) async => productList);
      final productListNotifier = ProductListNotifier(
        productListRepository: mockProductListRepository,
      );
      final productListLoaded = await productListNotifier.loadProductList();
      expect(productListLoaded, isA<AsyncData<List<Product>>>());
      expect(
        productListLoaded.when(
          data: (data) => data.length,
          loading: () => 0,
          error: (error, stackTrace) => 0,
        ),
        1,
      );
    });

    test('createProduct', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(
        () => mockProductListRepository.getProductList(),
      ).thenAnswer((_) async => [product]);
      when(
        () => mockProductListRepository.createProduct(product),
      ).thenAnswer((_) async => product);
      final productListNotifier = ProductListNotifier(
        productListRepository: mockProductListRepository,
      );
      await productListNotifier.loadProductList();
      final productAdded = await productListNotifier.addProduct(product);
      expect(productAdded, true);
    });

    test('updateProduct', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(
        () => mockProductListRepository.getProductList(),
      ).thenAnswer((_) async => [product]);
      when(
        () => mockProductListRepository.updateProduct(product),
      ).thenAnswer((_) async => true);
      final productListNotifier = ProductListNotifier(
        productListRepository: mockProductListRepository,
      );
      await productListNotifier.loadProductList();
      final productUpdated = await productListNotifier.updateProduct(product);
      expect(productUpdated, true);
    });

    test('deleteProduct', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(
        () => mockProductListRepository.getProductList(),
      ).thenAnswer((_) async => [product]);
      when(
        () => mockProductListRepository.deleteProduct(product.id),
      ).thenAnswer((_) async => true);
      final productListNotifier = ProductListNotifier(
        productListRepository: mockProductListRepository,
      );
      await productListNotifier.loadProductList();
      final productDeleted = await productListNotifier.deleteProduct(product);
      expect(productDeleted, true);
    });
  });
}
