import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/adapters/product.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockProductListRepository extends Mock implements Openapi {}

void main() {
  group('ProductListNotifier', () {
    final products = [
      AppModulesAmapSchemasAmapProductComplete(
        id: '1',
        name: 'Product 1',
        category: 'Category 1',
        price: 10,
      ),
    ];

    final product = AppModulesAmapSchemasAmapProductComplete(
      id: '2',
      name: 'Product 2',
      category: 'Category 2',
      price: 10,
    );

    final productToAdd = product.toProductSimple();

    test(
        'loadProductList should return the list of products from the repository',
        () async {
      final mockProductListRepository = MockProductListRepository();
      when(() => mockProductListRepository.amapProductsGet()).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), products),
      );
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final result = await productListNotifier.loadProductList();
      expect(
        result,
        isA<AsyncData<List<AppModulesAmapSchemasAmapProductComplete>>>(),
      );
      expect(
        result.when(
          data: (data) => data.length,
          loading: () => 0,
          error: (error, stackTrace) => 0,
        ),
        1,
      );
    });

    test('createProduct should add a new product to the list', () async {
      final mockProductListRepository = MockProductListRepository();

      when(
        () => mockProductListRepository.amapProductsPost(
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), product),
      );
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final result = await productListNotifier.addProduct(productToAdd);
      expect(result, true);
    });

    test('updateProduct should update an existing product in the list',
        () async {
      final mockProductListRepository = MockProductListRepository();
      final updatedProduct = product.copyWith(name: 'Updated Product 1');
      when(
        () => mockProductListRepository.amapProductsProductIdPatch(
          productId: any(named: 'productId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), updatedProduct),
      );
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final result = await productListNotifier.updateProduct(updatedProduct);
      expect(result, true);
    });

    test('deleteProduct should remove a product from the list', () async {
      final mockProductListRepository = MockProductListRepository();
      when(
        () => mockProductListRepository.amapProductsProductIdDelete(
          productId: any(named: 'productId'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final result = await productListNotifier.deleteProduct(product.id);
      expect(result, true);
    });

    test('loadProductList should handle error', () async {
      final mockProductListRepository = MockProductListRepository();
      when(() => mockProductListRepository.amapProductsGet())
          .thenThrow(Exception('Error'));
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final result = await productListNotifier.loadProductList();
      expect(result, isA<AsyncError>());
    });

    test('createProduct should handle error', () async {
      final mockProductListRepository = MockProductListRepository();
      when(
        () => mockProductListRepository.amapProductsPost(
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final result = await productListNotifier.addProduct(productToAdd);
      expect(result, false);
    });

    test('updateProduct should handle error', () async {
      final mockProductListRepository = MockProductListRepository();
      when(
        () => mockProductListRepository.amapProductsProductIdPatch(
          productId: any(named: 'productId'),
          body: any(named: 'body'),
        ),
      ).thenThrow(Exception('Error'));
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final result = await productListNotifier.updateProduct(product);
      expect(result, false);
    });

    test('deleteProduct should handle error', () async {
      final mockProductListRepository = MockProductListRepository();
      when(
        () => mockProductListRepository.amapProductsProductIdDelete(
          productId: any(named: 'productId'),
        ),
      ).thenThrow(Exception('Error'));
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final result = await productListNotifier.deleteProduct(product.id);
      expect(result, false);
    });
  });
}
