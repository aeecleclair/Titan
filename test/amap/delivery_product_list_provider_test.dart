import 'package:chopper/chopper.dart' as chopper;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';

class MockDeliveryProductListRepository extends Mock implements Openapi {}

void main() {
  group('DeliveryProductListNotifier', () {
    final products = [
      AppModulesAmapSchemasAmapProductComplete(
        id: '1',
        name: 'Product 1',
        category: 'Category 1',
        price: 10,
      ),
      AppModulesAmapSchemasAmapProductComplete(
        id: '2',
        name: 'Product 2',
        category: 'Category 2',
        price: 20,
      ),
    ];

    final product = AppModulesAmapSchemasAmapProductComplete(
      id: '3',
      name: 'New Product',
      category: 'Category 3',
      price: 30,
    );

    // final productToAdd = DeliveryProductsUpdate(
    //   productsIds: [product.id],
    // );

    test(
        'loadProductList should return AsyncValue with provided list of products',
        () async {
      final productListRepository = MockDeliveryProductListRepository();
      final notifier = DeliveryProductListNotifier(
        productListRepository: productListRepository,
      );

      final result = await notifier.loadProductList(products);

      expect(result, AsyncValue.data(products));
    });

    // test('addProduct should add product to list and return true', () async {
    //   final productListRepository = MockDeliveryProductListRepository();
    //   final notifier = DeliveryProductListNotifier(
    //     productListRepository: productListRepository,
    //   );

    //   when(
    //     () => productListRepository.amapDeliveriesDeliveryIdProductsPost(
    //       deliveryId: any(named: 'deliveryId'),
    //       body: any(named: 'body'),
    //     ),
    //   ).thenAnswer(
    //     (_) async => chopper.Response(http.Response('[]', 200), product),
    //   );

    //   notifier.state = AsyncValue.data(products.sublist(0));
    //   final result = await notifier.addProduct(productToAdd, 'deliveryId');

    //   expect(result, true);
    //   expect(
    //     notifier.state.when(
    //       data: (data) => data,
    //       error: (e, s) => [],
    //       loading: () => [],
    //     ),
    //     [...products, product],
    //   );
    // });

    test('deleteProduct should remove product from list and return true',
        () async {
      final productListRepository = MockDeliveryProductListRepository();
      final notifier = DeliveryProductListNotifier(
        productListRepository: productListRepository,
      );

      notifier.state = AsyncValue.data([...products, product]);

      when(
        () => productListRepository.amapDeliveriesDeliveryIdProductsDelete(
          deliveryId: any(named: 'deliveryId'),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => chopper.Response(http.Response('[]', 200), true),
      );

      notifier.state = AsyncValue.data([...products, product]);
      final result = await notifier.deleteProduct(product, 'deliveryId');

      expect(result, true);
      expect(
        notifier.state.when(
          data: (data) => data,
          error: (e, s) => [],
          loading: () => [],
        ),
        products,
      );
    });
  });
}
