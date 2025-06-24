import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/providers/delivery_product_list_provider.dart';

import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/repositories/delivery_product_list_repository.dart';

class MockDeliveryProductListRepository extends Mock
    implements DeliveryProductListRepository {}

void main() {
  group('DeliveryProductListNotifier', () {
    test(
      'loadProductList should return AsyncValue with provided list of products',
      () async {
        final productListRepository = MockDeliveryProductListRepository();
        final notifier = DeliveryProductListNotifier(
          productListRepository: productListRepository,
        );
        final products = [
          Product.empty().copyWith(id: '1', name: 'Product 1'),
          Product.empty().copyWith(id: '2', name: 'Product 2'),
        ];

        final result = await notifier.loadProductList(products);

        expect(result, AsyncValue.data(products));
      },
    );

    test('addProduct should add product to list and return true', () async {
      final productListRepository = MockDeliveryProductListRepository();
      final notifier = DeliveryProductListNotifier(
        productListRepository: productListRepository,
      );

      final product = Product.empty().copyWith(
        name: 'New Product',
        quantity: 1,
      );
      final products = [
        Product.empty().copyWith(id: '1', name: 'Product 1'),
        Product.empty().copyWith(id: '2', name: 'Product 2'),
      ];

      when(
        () => productListRepository.createProduct('deliveryId', product),
      ).thenAnswer((_) async => product);

      notifier.state = AsyncValue.data(products.sublist(0));
      final result = await notifier.addProduct(product, 'deliveryId');

      expect(result, true);
      expect(
        notifier.state.when(
          data: (data) => data,
          error: (e, s) => [],
          loading: () => [],
        ),
        [...products, product],
      );
    });

    test(
      'updateProduct should update product in list and return true',
      () async {
        final productListRepository = MockDeliveryProductListRepository();
        final notifier = DeliveryProductListNotifier(
          productListRepository: productListRepository,
        );

        final product1 = Product.empty().copyWith(id: '1', name: 'Product 1');
        final product2 = Product.empty().copyWith(id: '1', name: 'Product 2');

        notifier.state = AsyncValue.data([product1]);

        when(
          () => productListRepository.updateProduct('deliveryId', product2),
        ).thenAnswer((_) async => true);

        final result = await notifier.updateProduct(product2, 'deliveryId');

        expect(result, true);
        expect(
          notifier.state.when(
            data: (data) => data,
            error: (e, s) => [],
            loading: () => [],
          ),
          [product2],
        );
      },
    );

    test(
      'deleteProduct should remove product from list and return true',
      () async {
        final productListRepository = MockDeliveryProductListRepository();
        final notifier = DeliveryProductListNotifier(
          productListRepository: productListRepository,
        );

        final product1 = Product.empty().copyWith(id: '1', name: 'Product 1');
        final product2 = Product.empty().copyWith(id: '2', name: 'Product 2');

        notifier.state = AsyncValue.data([product1, product2]);

        when(
          () => productListRepository.deleteProduct('deliveryId', product1.id),
        ).thenAnswer((_) async => true);

        final result = await notifier.deleteProduct(product1, 'deliveryId');

        expect(result, true);
        expect(
          notifier.state.when(
            data: (data) => data,
            error: (e, s) => [],
            loading: () => [],
          ),
          [product2],
        );
      },
    );

    test(
      'setQuantity should update quantity of product in list and return true',
      () async {
        final productListRepository = MockDeliveryProductListRepository();
        final notifier = DeliveryProductListNotifier(
          productListRepository: productListRepository,
        );

        final product1 = Product.empty().copyWith(
          id: '1',
          name: 'Product 1',
          quantity: 1,
        );
        final product2 = Product.empty().copyWith(
          id: '2',
          name: 'Product 2',
          quantity: 2,
        );

        notifier.state = AsyncValue.data([product1, product2]);

        final result = await notifier.setQuantity(product1, 3);

        expect(result, true);
        expect(
          notifier.state
              .when(
                data: (data) => data,
                error: (e, s) => [],
                loading: () => [],
              )
              .first
              .quantity,
          3,
        );
      },
    );
  });
}
