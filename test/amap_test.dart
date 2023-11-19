import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/information.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/providers/delivery_list_provider.dart';
import 'package:myecl/amap/providers/delivery_product_list_provider.dart';
import 'package:myecl/amap/providers/information_provider.dart';
import 'package:myecl/amap/providers/orders_by_delivery_provider.dart';
import 'package:myecl/amap/providers/product_list_provider.dart';
import 'package:myecl/amap/providers/user_amount_provider.dart';
import 'package:myecl/amap/providers/user_order_list_provider.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/amap/repositories/cash_repository.dart';
import 'package:myecl/amap/repositories/delivery_list_repository.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';
import 'package:myecl/amap/repositories/information_repository.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/amap/repositories/product_repository.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class MockAmapUserRespository extends Mock implements AmapUserRepository {}

class MockCashRepository extends Mock implements CashRepository {}

class MockDeliveryListRepository extends Mock
    implements DeliveryListRepository {}

class MockDeliveryProductListRepository extends Mock
    implements DeliveryProductListRepository {}

class MockInformationRepository extends Mock implements InformationRepository {}

class MockOrderListRepository extends Mock implements OrderListRepository {}

class MockProductListRepository extends Mock implements ProductListRepository {}

void main() {
  group('Testing Cash class', () {
    test('Should return a cash', () async {
      final cash = Cash.empty();
      expect(cash, isA<Cash>());
    });

    test('Should return a cash with a null balance and empty user', () async {
      final cash = Cash.empty();
      expect(cash.balance, 0);
      expect(cash.user, isA<SimpleUser>());
    });

    test('Should update with new values', () async {
      final cash = Cash.empty();
      Cash newCash = cash.copyWith(balance: 1);
      expect(newCash.balance, 1);
      newCash = cash.copyWith(user: SimpleUser.empty().copyWith(name: 'Name'));
      expect(newCash.user.name, 'Name');
    });

    test('Should print properly', () async {
      final cash = Cash.empty();
      expect(cash.toString(),
          'Cash{balance: 0.0, user: SimpleUser {name: Nom, firstname: Prénom, nickname: null, id: }}');
    });

    test('Should parse a Cash from json', () async {
      final cash = Cash.fromJson({
        "balance": 0.0,
        "user": {
          "name": "Name",
          "firstname": "Firstname",
          "nickname": null,
          "id": "id",
          "birthday": "1999-01-01",
          "created_on": "2021-01-01",
          "email": "email",
          "floor": "floor",
          "groups": [],
          "phone": "phone",
          "promo": null
        }
      });
      expect(cash, isA<Cash>());
      expect(cash.balance, 0);
      expect(cash.user.name, 'Name');
      expect(cash.user.nickname, null);
    });

    test('Should return correct json', () async {
      final cash = Cash.fromJson({
        "balance": 0.0,
        "user": {
          "name": "Name",
          "firstname": "Firstname",
          "nickname": null,
          "id": "id",
        }
      });
      expect(cash.toJson(), {
        "balance": 0.0,
      });
    });
  });

  group('Testing Delivery class', () {
    test('Should return a delivery', () async {
      final delivery = Delivery.empty();
      expect(delivery, isA<Delivery>());
    });

    test('Should parse an Delivery from json', () async {
      final delivery = Delivery.fromJson({
        "delivery_date": "2021-01-01",
        "products": [
          {
            "id": "id",
            "name": "name",
            "price": 0.0,
            "category": "category",
            "quantity": 0,
          }
        ],
        "id": "id",
        "status": "creation",
      });
      expect(delivery, isA<Delivery>());
    });

    test('Should update with new values', () {
      final delivery = Delivery.empty();
      final newProduct = Product.empty().copyWith(name: 'New name');
      Delivery newDelivery = delivery.copyWith(
        deliveryDate: DateTime.parse('2021-01-01'),
      );
      expect(newDelivery.deliveryDate, DateTime.parse('2021-01-01'));
      newDelivery = delivery.copyWith(
        products: [newProduct],
      );
      expect(newDelivery.products, [newProduct]);
      newDelivery = delivery.copyWith(
        id: 'id',
      );
      expect(newDelivery.id, 'id');
      newDelivery = delivery.copyWith(
        status: DeliveryStatus.delivered,
      );
      expect(newDelivery.status, DeliveryStatus.delivered);
      newDelivery = delivery.copyWith(
        expanded: true,
      );
      expect(newDelivery.expanded, true);
    });

    test('Should print properly', () async {
      final delivery = Delivery.empty().copyWith(
        deliveryDate: DateTime.parse('2021-01-01'),
        products: [
          Product.empty().copyWith(name: 'Name'),
        ],
        id: 'id',
        status: DeliveryStatus.creation,
      );
      expect(delivery.toString(),
          'Delivery{deliveryDate: 2021-01-01 00:00:00.000, products: [Product{id: , name: Name, price: 0.0, quantity: 0, category: }], id: id, status: DeliveryStatus.creation, expanded: false}');
    });

    test('Should return correct json', () async {
      final delivery = Delivery.fromJson({
        "delivery_date": "2021-01-01",
        "products": [
          {
            "id": "id",
            "name": "name",
            "price": 0.0,
            "category": "category",
            "quantity": 0,
          }
        ],
        "id": "id",
        "status": "creation",
      });
      expect(delivery.toJson(), {
        "delivery_date": "2021-01-01",
        "products_ids": ["id"],
        "id": "id",
        "status": "creation",
      });
    });
  });

  group('Testing Order class', () {
    test('Should return a order', () async {
      final order = Order.empty();
      expect(order, isA<Order>());
    });

    test('Should update with new values', () {
      final order = Order.empty();
      final newProduct = Product.empty().copyWith(id: 'id', quantity: 1);
      Order newOrder = order.copyWith(
        id: 'id',
      );
      expect(newOrder.id, 'id');
      newOrder = order.copyWith(
        deliveryId: 'id',
      );
      expect(newOrder.deliveryId, 'id');
      newOrder = order.copyWith(
        amount: 1,
      );
      expect(newOrder.amount, 1);
      newOrder = order.copyWith(
        products: [newProduct],
      );
      expect(newOrder.products, [newProduct]);
      expect(newOrder.productsDetail, ['id']);
      expect(newOrder.productsQuantity, [1]);
      newOrder = order.copyWith(
        collectionSlot: CollectionSlot.midi,
      );
      expect(newOrder.collectionSlot, CollectionSlot.midi);
      newOrder = order.copyWith(
        user: SimpleUser.empty().copyWith(name: 'Name'),
      );
      expect(newOrder.user.name, 'Name');
      newOrder = order.copyWith(
        orderingDate: DateTime.parse('2021-01-01'),
      );
      expect(newOrder.orderingDate, DateTime.parse('2021-01-01'));
      newOrder = order.copyWith(
        deliveryDate: DateTime.parse('2021-01-01'),
      );
      expect(newOrder.deliveryDate, DateTime.parse('2021-01-01'));
    });

    test('Should print properly', () async {
      final order = Order.empty().copyWith(
        id: 'id',
        deliveryId: 'delivery_id',
        amount: 0,
        products: [
          Product.empty()
              .copyWith(id: 'id', name: 'name', price: 0, quantity: 0),
        ],
        collectionSlot: CollectionSlot.midi,
        user: SimpleUser.empty().copyWith(name: 'Name'),
        orderingDate: DateTime.parse('2021-01-01'),
        deliveryDate: DateTime.parse('2021-01-01'),
      );
      expect(order.toString(),
          'Order{id: id, orderingDate: 2021-01-01 00:00:00.000, deliveryDate: 2021-01-01 00:00:00.000, productsDetail: [id], productsQuantity: [0], deliveryId: delivery_id, products: [Product{id: id, name: name, price: 0.0, quantity: 0, category: }], amount: 0.0, lastAmount: 0.0, collectionSlot: CollectionSlot.midi, user: SimpleUser {name: Name, firstname: Prénom, nickname: null, id: }, expanded: false}');
    });

    test('Should parse an Order from json', () async {
      final order = Order.fromJson({
        "order_id": "id",
        "delivery_id": "delivery_id",
        "amount": 0.0,
        "productsdetail": [
          {
            "id": "id",
            "name": "name",
            "price": 0.0,
            "category": "category",
            "quantity": 0,
          }
        ],
        "collection_slot": "midi",
        "user": {
          "name": "Name",
          "firstname": "Firstname",
          "nickname": null,
          "id": "id",
        },
        "ordering_date": "2021-01-01",
        "delivery_date": "2021-01-01",
      });
      expect(order, isA<Order>());
    });

    test('Should return correct json', () async {
      final order = Order.fromJson({
        "order_id": "id",
        "delivery_id": "delivery_id",
        "amount": 0.0,
        "productsdetail": [
          {
            "id": "id",
            "name": "name",
            "price": 0.0,
            "category": "category",
            "quantity": 0,
          }
        ],
        "collection_slot": "midi",
        "user": {
          "name": "Name",
          "firstname": "Firstname",
          "nickname": null,
          "id": "id",
        },
        "ordering_date": "2021-01-01",
        "delivery_date": "2021-01-01",
      });
      expect(order.toJson(), {
        "order_id": "id",
        "delivery_id": "delivery_id",
        "amount": 0.0,
        "products_ids": ["id"],
        "products_quantity": [0],
        "collection_slot": "midi",
        "user_id": "id",
        "ordering_date": "2021-01-01",
        "delivery_date": "2021-01-01",
      });
    });
  });

  group('Testing Information class', () {
    test('Should return a information', () async {
      final information = Information.empty().copyWith(manager: "Manager");
      expect(information, isA<Information>());
    });

    test('Should parse an Information from json', () async {
      final information = Information.fromJson({
        "manager": "manager",
        "link": "link",
        "description": "description",
      });
      expect(information, isA<Information>());
    });

    test('Should update with new values', () {
      final information = Information.empty();
      Information newInformation = information.copyWith(
        manager: "Manager",
      );
      expect(newInformation.manager, "Manager");
      newInformation = information.copyWith(
        link: "Link",
      );
      expect(newInformation.link, "Link");
      newInformation = information.copyWith(
        description: "Description",
      );
      expect(newInformation.description, "Description");
    });

    test('Should print properly', () async {
      final information = Information.empty().copyWith(
        manager: "Manager",
        link: "Link",
        description: "Description",
      );
      expect(information.toString(),
          'Information{manager: Manager, link: Link, description: Description}');
    });

    test('Should return correct json', () async {
      final information = Information.fromJson({
        "manager": "manager",
        "link": "link",
        "description": "description",
      });
      expect(information.toJson(), {
        "manager": "manager",
        "link": "link",
        "description": "description",
      });
    });
  });

  group('Testing Product class', () {
    test('Should return a product', () async {
      final product = Product.empty();
      expect(product, isA<Product>());
    });

    test('Should parse an Product from json', () async {
      final product = Product.fromJson({
        "id": "id",
        "name": "name",
        "price": 0.0,
        "category": "category",
      });
      expect(product, isA<Product>());
    });

    test('Should parse an Product from json with quantity', () async {
      final product = Product.fromJson({
        "quantity": 1,
        "product": {
          "id": "id",
          "name": "name",
          "price": 0.0,
          "category": "category",
        }
      });
      expect(product, isA<Product>());
    });

    test('Should update with new values', () {
      final product = Product.empty();
      Product newProduct = product.copyWith(
        id: "id",
      );
      expect(newProduct.id, "id");
      newProduct = product.copyWith(
        name: "name",
      );
      expect(newProduct.name, "name");
      newProduct = product.copyWith(
        price: 0.0,
      );
      expect(newProduct.price, 0.0);
      newProduct = product.copyWith(
        category: "category",
      );
      expect(newProduct.category, "category");
      newProduct = product.copyWith(
        quantity: 0,
      );
      expect(newProduct.quantity, 0);
    });

    test('Should print properly', () async {
      final product = Product.empty().copyWith(
        id: "id",
        name: "name",
        price: 0.0,
        category: "category",
        quantity: 0,
      );
      expect(product.toString(),
          'Product{id: id, name: name, price: 0.0, quantity: 0, category: category}');
    });

    test('Should return correct json', () async {
      final product = Product.fromJson({
        "id": "id",
        "name": "name",
        "price": 0.0,
        "category": "category",
        "quantity": 0,
      });
      expect(product.toJson(), {
        "id": "id",
        "name": "name",
        "price": 0.0,
        "category": "category",
        "quantity": 0,
      });
    });
  });

  group('Testing functions', () {
    test('Should return a string', () async {
      expect(collectionSlotToString(CollectionSlot.midi), "midi");
      expect(collectionSlotToString(CollectionSlot.soir), "soir");
    });
    test('Should return a CollectionSlot', () async {
      expect(stringToCollectionSlot("midi"), CollectionSlot.midi);
      expect(stringToCollectionSlot("soir"), CollectionSlot.soir);
      expect(stringToCollectionSlot("test"), CollectionSlot.midi);
    });

    test('Should return a string', () async {
      expect(deliveryStatusToString(DeliveryStatus.creation), "creation");
      expect(deliveryStatusToString(DeliveryStatus.orderable), "orderable");
      expect(deliveryStatusToString(DeliveryStatus.locked), "locked");
      expect(deliveryStatusToString(DeliveryStatus.delivered), "delivered");
    });

    test('Should return a DeliveryStatus', () async {
      expect(stringToDeliveryStatus("creation"), DeliveryStatus.creation);
      expect(stringToDeliveryStatus("orderable"), DeliveryStatus.orderable);
      expect(stringToDeliveryStatus("locked"), DeliveryStatus.locked);
      expect(stringToDeliveryStatus("delivered"), DeliveryStatus.delivered);
      expect(stringToDeliveryStatus("test"), DeliveryStatus.creation);
    });
  });

  group('Testing DeliveryListNotifier : loadDeliveriesList', () {
    test('Should return a list of deliveries', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      final deliveryList = await deliveryListNotifier.loadDeliveriesList();
      expect(deliveryList, isA<AsyncData<List<Delivery>>>());
      expect(
          deliveryList.when(
              data: (data) => data.length,
              loading: () => 0,
              error: (error, stackTrace) => 0),
          1);
    });

    test('Should return an error', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenThrow(Exception());
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      final deliveryList = await deliveryListNotifier.loadDeliveriesList();
      expect(deliveryList, isA<AsyncError<List<Delivery>>>());
      expect(
          deliveryList.when(
              data: (data) => data,
              loading: () => [],
              error: (error, stackTrace) => []),
          []);
    });
  });

  group('Testing DeliveryListNotifier : addDelivery', () {
    test('Should create a deivery', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.createDelivery(newDelivery))
          .thenAnswer((_) async => newDelivery);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList = await deliveryListNotifier.addDelivery(newDelivery);
      expect(deliveryList, true);
    });

    test('Should return an error if delivery list is not loaded', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.createDelivery(newDelivery))
          .thenThrow(Exception());
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      final deliveryList = await deliveryListNotifier.addDelivery(newDelivery);
      expect(deliveryList, false);
    });

    test('Should return an error if delivery is not created', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenThrow(Exception());
      when(() => mockDeliveryListRepository.createDelivery(newDelivery))
          .thenAnswer((_) async => newDelivery);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList = await deliveryListNotifier.addDelivery(newDelivery);
      expect(deliveryList, false);
    });
  });

  group('Testing DeliveryListNotifier : updateDelivery', () {
    test('Should update a deivery', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.updateDelivery(newDelivery))
          .thenAnswer((_) async => true);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList =
          await deliveryListNotifier.updateDelivery(newDelivery);
      expect(deliveryList, true);
    });

    test('Should return an error if delivery list is not loaded', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.updateDelivery(newDelivery))
          .thenThrow(Exception());
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      final deliveryList =
          await deliveryListNotifier.updateDelivery(newDelivery);
      expect(deliveryList, false);
    });

    test('Should return an error if delivery is not updated', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenThrow(Exception());
      when(() => mockDeliveryListRepository.updateDelivery(newDelivery))
          .thenAnswer((_) async => true);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList =
          await deliveryListNotifier.updateDelivery(newDelivery);
      expect(deliveryList, false);
    });

    test('Should return an error if delivery is not found', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.updateDelivery(newDelivery))
          .thenThrow(Exception());
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList =
          await deliveryListNotifier.updateDelivery(newDelivery);
      expect(deliveryList, false);
    });
  });

  group('Testing DeliveryListNotifier : deleteDelivery', () {
    test('Should delete a deivery', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.deleteDelivery(newDelivery.id))
          .thenAnswer((_) async => true);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList =
          await deliveryListNotifier.deleteDelivery(newDelivery);
      expect(deliveryList, true);
    });

    test('Should return an error if delivery list is not loaded', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.deleteDelivery(newDelivery.id))
          .thenThrow(Exception());
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      final deliveryList =
          await deliveryListNotifier.deleteDelivery(newDelivery);
      expect(deliveryList, false);
    });

    test('Should return an error if delivery is not deleted', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenThrow(Exception());
      when(() => mockDeliveryListRepository.deleteDelivery(newDelivery.id))
          .thenAnswer((_) async => true);
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList =
          await deliveryListNotifier.deleteDelivery(newDelivery);
      expect(deliveryList, false);
    });

    test('Should return an error if delivery is not found', () async {
      final mockDeliveryListRepository = MockDeliveryListRepository();
      final newDelivery = Delivery.empty();
      when(() => mockDeliveryListRepository.getDeliveryList())
          .thenAnswer((_) async => [Delivery.empty()]);
      when(() => mockDeliveryListRepository.deleteDelivery(newDelivery.id))
          .thenThrow(Exception());
      final deliveryListNotifier = DeliveryListNotifier(
          deliveriesListRepository: mockDeliveryListRepository);
      await deliveryListNotifier.loadDeliveriesList();
      final deliveryList =
          await deliveryListNotifier.deleteDelivery(newDelivery);
      expect(deliveryList, false);
    });
  });

  group('Testing DeliveryProductListNotifier : loadProductsList', () {
    test('Should load a list of products', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productsList = await productListNotifier
          .loadProductList([Product.empty(), Product.empty(), Product.empty()]);
      expect(productsList, isA<AsyncData<List<Product>>>());
      expect(
          productsList.when(
              data: (data) => data.length,
              loading: () => 0,
              error: (error, stackTrace) => 0),
          3);
    });
  });

  group('Testing DeliveryProductListNotifier : addProduct', () {
    test('Should add a product', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.createProduct(
          "delivery_id", newProduct)).thenAnswer((_) async => newProduct);
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      await productListNotifier
          .loadProductList([Product.empty(), Product.empty(), Product.empty()]);
      final productList =
          await productListNotifier.addProduct(newProduct, "delivery_id");
      expect(productList, true);
    });

    test('Should return an error if product list is not loaded', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.createProduct(
          "delivery_id", newProduct)).thenThrow(Exception());
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productList =
          await productListNotifier.addProduct(newProduct, "delivery_id");
      expect(productList, false);
    });

    test('Should return an error if product is not added', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.createProduct(
          "delivery_id", newProduct)).thenAnswer((_) async => newProduct);
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productList =
          await productListNotifier.addProduct(newProduct, "delivery_id");
      expect(productList, false);
    });
  });

  group('Testing DeliveryProductListNotifier : updateProduct', () {
    test('Should update a product', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.updateProduct(
          "delivery_id", newProduct)).thenAnswer((_) async => true);
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      await productListNotifier
          .loadProductList([Product.empty(), Product.empty(), Product.empty()]);
      final productList =
          await productListNotifier.updateProduct(newProduct, "delivery_id");
      expect(productList, true);
    });

    test('Should return an error if product list is not loaded', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.updateProduct(
          "delivery_id", newProduct)).thenThrow(Exception());
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productList =
          await productListNotifier.updateProduct(newProduct, "delivery_id");
      expect(productList, false);
    });

    test('Should return an error if product is not updated', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.updateProduct(
          "delivery_id", newProduct)).thenAnswer((_) async => false);
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productList =
          await productListNotifier.updateProduct(newProduct, "delivery_id");
      expect(productList, false);
    });

    test('Should return an error if product is not found', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.updateProduct(
          "delivery_id", newProduct)).thenThrow(Exception());
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productList =
          await productListNotifier.updateProduct(newProduct, "delivery_id");
      expect(productList, false);
    });
  });

  group('Testing DeliveryProductListNotifier : deleteProduct', () {
    test('Should delete a product', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.deleteProduct(
          "delivery_id", newProduct.id)).thenAnswer((_) async => true);
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      await productListNotifier
          .loadProductList([Product.empty(), Product.empty(), Product.empty()]);
      final productList =
          await productListNotifier.deleteProduct(newProduct, "delivery_id");
      expect(productList, true);
    });

    test('Should return an error if product list is not loaded', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.deleteProduct(
          "delivery_id", newProduct.id)).thenThrow(Exception());
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      final productList =
          await productListNotifier.deleteProduct(newProduct, "delivery_id");
      expect(productList, false);
    });

    test('Should return an error if product is not deleted', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty().copyWith(id: "id");
      when(() => mockProductListRepository.deleteProduct(
          "delivery_id", newProduct.id)).thenAnswer((_) async => false);
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      await productListNotifier
          .loadProductList([Product.empty(), Product.empty(), Product.empty()]);
      final productList =
          await productListNotifier.deleteProduct(newProduct, "delivery_id");
      expect(productList, false);
    });

    test('Should return an error if product is not found', () async {
      final mockProductListRepository = MockDeliveryProductListRepository();
      final newProduct = Product.empty();
      when(() => mockProductListRepository.deleteProduct(
          "delivery_id", newProduct.id)).thenThrow(Exception());
      final productListNotifier = DeliveryProductListNotifier(
          productListRepository: mockProductListRepository);
      await productListNotifier
          .loadProductList([Product.empty(), Product.empty(), Product.empty()]);
      final productList =
          await productListNotifier.deleteProduct(newProduct, "delivery_id");
      expect(productList, false);
    });
  });

  group('Testing InformationNotifier : loadInformation', () {
    test('Should load information', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      final informationLoaded = await informationNotifier.loadInformation();
      expect(informationLoaded, isA<AsyncData<Information>>());
      expect(
          informationLoaded.when(
              data: (Information data) => data,
              error: (Object error, StackTrace stackTrace) => null,
              loading: () => null),
          information);
    });

    test('Should return an error if information is not loaded', () async {
      final mockInformationRepository = MockInformationRepository();
      when(() => mockInformationRepository.getInformation())
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      final informationLoaded = await informationNotifier.loadInformation();
      expect(informationLoaded, isA<AsyncError>());
    });
  });

  group('Testing InformationNotifier : updateInformation', () {
    test('Should update information', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.updateInformation(information))
          .thenAnswer((_) async => true);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationUpdated =
          await informationNotifier.updateInformation(information);
      expect(informationUpdated, true);
    });

    test('Should return an error if information is not updated', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.updateInformation(information))
          .thenAnswer((_) async => false);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationUpdated =
          await informationNotifier.updateInformation(information);
      expect(informationUpdated, false);
    });

    test('Should return an error if information is not loaded', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.updateInformation(information))
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      final informationUpdated =
          await informationNotifier.updateInformation(information);
      expect(informationUpdated, false);
    });

    test('Should return an error if information is not found', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.updateInformation(information))
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationUpdated =
          await informationNotifier.updateInformation(information);
      expect(informationUpdated, false);
    });
  });

  group('Testing InformationNotifier : deleteInformation', () {
    test('Should delete information', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.deleteInformation(""))
          .thenAnswer((_) async => true);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationDeleted =
          await informationNotifier.deleteInformation(information);
      expect(informationDeleted, true);
    });

    test('Should return an error if information is not deleted', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.deleteInformation(""))
          .thenAnswer((_) async => false);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationDeleted =
          await informationNotifier.deleteInformation(information);
      expect(informationDeleted, false);
    });

    test('Should return an error if information is not loaded', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.deleteInformation(""))
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      final informationDeleted =
          await informationNotifier.deleteInformation(information);
      expect(informationDeleted, false);
    });

    test('Should return an error if information is not found', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.deleteInformation(""))
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationDeleted =
          await informationNotifier.deleteInformation(information);
      expect(informationDeleted, false);
    });
  });

  group('Testing InformationNotifier : createInformation', () {
    test('Should add information', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.createInformation(information))
          .thenAnswer((_) async => information);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationAdded =
          await informationNotifier.createInformation(information);
      expect(informationAdded, true);
    });

    test('Should return an error if information is not added', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.createInformation(information))
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationAdded =
          await informationNotifier.createInformation(information);
      expect(informationAdded, false);
    });

    test('Should return an error if information is not loaded', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.createInformation(information))
          .thenAnswer((_) async => information);
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      final informationAdded =
          await informationNotifier.createInformation(information);
      expect(informationAdded, false);
    });

    test('Should return an error if information is not found', () async {
      final mockInformationRepository = MockInformationRepository();
      final information = Information.empty().copyWith(manager: "Manager");
      when(() => mockInformationRepository.getInformation())
          .thenAnswer((_) async => information);
      when(() => mockInformationRepository.createInformation(information))
          .thenThrow(Exception());
      final informationNotifier =
          InformationNotifier(informationRepository: mockInformationRepository);
      await informationNotifier.loadInformation();
      final informationAdded =
          await informationNotifier.createInformation(information);
      expect(informationAdded, false);
    });
  });

  group('Testing OrderByDeliveryListNotifier : loadDeliveryOrderList', () {
    test('Should load delivery order list', () async {
      final mockOrderByDeliveryListRepository = MockOrderListRepository();
      final orderByDeliveryList = [
        Order.empty().copyWith(id: "1"),
      ];
      when(() => mockOrderByDeliveryListRepository.getDeliveryOrderList(""))
          .thenAnswer((_) async => orderByDeliveryList);
      final orderByDeliveryListNotifier = OrderByDeliveryListNotifier(
          orderListRepository: mockOrderByDeliveryListRepository);
      final deliveryOrderList =
          await orderByDeliveryListNotifier.loadDeliveryOrderList("");
      expect(deliveryOrderList, isA<AsyncData<List<Order>>>());
      expect(
          deliveryOrderList.when(
              data: (data) => data.length,
              loading: () => 0,
              error: (error, stackTrace) => 0),
          1);
    });

    test('Should return an error if delivery order list is not loaded',
        () async {
      final mockOrderByDeliveryListRepository = MockOrderListRepository();
      when(() => mockOrderByDeliveryListRepository.getDeliveryOrderList(""))
          .thenThrow(Exception());
      final orderByDeliveryListNotifier = OrderByDeliveryListNotifier(
          orderListRepository: mockOrderByDeliveryListRepository);
      final deliveryOrderList =
          await orderByDeliveryListNotifier.loadDeliveryOrderList("");
      expect(deliveryOrderList, isA<AsyncError<List<Order>>>());
    });
  });

  group('Testing ProductListNotifier : loadProductList', () {
    test('Should load product list', () async {
      final mockProductListRepository = MockProductListRepository();
      final productList = [
        Product.empty().copyWith(id: "1"),
      ];
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => productList);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final productListLoaded = await productListNotifier.loadProductList();
      expect(productListLoaded, isA<AsyncData<List<Product>>>());
      expect(
          productListLoaded.when(
              data: (data) => data.length,
              loading: () => 0,
              error: (error, stackTrace) => 0),
          1);
    });

    test('Should return an error if product list is not loaded', () async {
      final mockProductListRepository = MockProductListRepository();
      final productList = [
        Product.empty().copyWith(id: "1"),
      ];
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => productList);
      when(() => mockProductListRepository.getProductList())
          .thenThrow(Exception());
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final productListLoaded = await productListNotifier.loadProductList();
      expect(productListLoaded, isA<AsyncError<List<Product>>>());
    });
  });

  group('Testing ProductListNotifier : createProduct', () {
    test('Should add product', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => [product]);
      when(() => mockProductListRepository.createProduct(product))
          .thenAnswer((_) async => product);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productAdded = await productListNotifier.addProduct(product);
      expect(productAdded, true);
    });

    test('Should return an error if product is not added', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => [product]);
      when(() => mockProductListRepository.createProduct(product))
          .thenThrow(Exception());
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productAdded = await productListNotifier.addProduct(product);
      expect(productAdded, false);
    });

    test('Should return an error if product is not loaded', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.createProduct(product))
          .thenThrow(Exception());
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final productAdded = await productListNotifier.addProduct(product);
      expect(productAdded, false);
    });
  });

  group('Testing ProductListNotifier : updateProduct', () {
    test('Should update product', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => [product]);
      when(() => mockProductListRepository.updateProduct(product))
          .thenAnswer((_) async => true);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productUpdated = await productListNotifier.updateProduct(product);
      expect(productUpdated, true);
    });

    test('Should return an error if product is not updated', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => [product]);
      when(() => mockProductListRepository.updateProduct(product))
          .thenThrow(Exception());
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productUpdated = await productListNotifier.updateProduct(product);
      expect(productUpdated, false);
    });

    test('Should return an error if product is not loaded', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.updateProduct(product))
          .thenThrow(Exception());
      when(() => mockProductListRepository.updateProduct(product))
          .thenAnswer((_) async => true);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final productUpdated = await productListNotifier.updateProduct(product);
      expect(productUpdated, false);
    });

    test('Should return an error if product is not found', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.updateProduct(product))
          .thenAnswer((_) async => true);
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => []);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productUpdated = await productListNotifier.updateProduct(product);
      expect(productUpdated, false);
    });
  });

  group('Testing ProductListNotifier : deleteProduct', () {
    test('Should delete product', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => [product]);
      when(() => mockProductListRepository.deleteProduct(product.id))
          .thenAnswer((_) async => true);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productDeleted = await productListNotifier.deleteProduct(product);
      expect(productDeleted, true);
    });

    test('Should return an error if product is not deleted', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => [product]);
      when(() => mockProductListRepository.deleteProduct(product.id))
          .thenThrow(Exception());
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productDeleted = await productListNotifier.deleteProduct(product);
      expect(productDeleted, false);
    });

    test('Should return an error if product is not loaded', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.deleteProduct(product.id))
          .thenThrow(Exception());
      when(() => mockProductListRepository.deleteProduct(product.id))
          .thenAnswer((_) async => true);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      final productDeleted = await productListNotifier.deleteProduct(product);
      expect(productDeleted, false);
    });

    test('Should return an error if product is not found', () async {
      final mockProductListRepository = MockProductListRepository();
      final product = Product.empty().copyWith(id: "1");
      when(() => mockProductListRepository.deleteProduct(product.id))
          .thenAnswer((_) async => false);
      when(() => mockProductListRepository.getProductList())
          .thenAnswer((_) async => []);
      final productListNotifier =
          ProductListNotifier(productListRepository: mockProductListRepository);
      await productListNotifier.loadProductList();
      final productDeleted = await productListNotifier.deleteProduct(product);
      expect(productDeleted, false);
    });
  });

  group('Testing UserCashNotifier : loadCashByUser', () {
    test('Should load cash by user', () async {
      final mockUserCashRepository = MockAmapUserRespository();
      final userCash =
          Cash.empty().copyWith(user: SimpleUser.empty().copyWith(id: "1"));
      when(() => mockUserCashRepository.getCashByUser(userCash.user.id))
          .thenAnswer((_) async => userCash);
      final userCashNotifier =
          UserCashNotifier(amapUserRepository: mockUserCashRepository);
      final userCashLoaded =
          await userCashNotifier.loadCashByUser(userCash.user.id);
      expect(userCashLoaded, isA<AsyncData<Cash>>());
      expect(
          userCashLoaded.when(
            data: (cash) => cash,
            loading: () => null,
            error: (error, stackTrace) => null,
          ),
          userCash);
    });

    test('Should return an error if cash is not loaded', () async {
      final mockUserCashRepository = MockAmapUserRespository();
      final userCash =
          Cash.empty().copyWith(user: SimpleUser.empty().copyWith(id: "1"));
      when(() => mockUserCashRepository.getCashByUser(userCash.user.id))
          .thenThrow(Exception());
      final userCashNotifier =
          UserCashNotifier(amapUserRepository: mockUserCashRepository);
      final userCashLoaded =
          await userCashNotifier.loadCashByUser(userCash.user.id);
      expect(userCashLoaded, isA<AsyncError<Cash>>());
    });
  });

  group('Testing UserOrderListNotifier : loadOrderList', () {
    test('Should load order list', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final orderList = [
        Order.empty().copyWith(id: "1"),
        Order.empty().copyWith(id: "2"),
      ];
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => orderList);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      final userOrderListLoaded = await userOrderListNotifier.loadOrderList("");
      expect(userOrderListLoaded, isA<AsyncData<List<Order>>>());
      expect(
          userOrderListLoaded.when(
            data: (orderList) => orderList,
            loading: () => null,
            error: (error, stackTrace) => null,
          ),
          orderList);
    });

    test('Should return an error if order list is not loaded', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenThrow(Exception());
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      final userOrderListLoaded = await userOrderListNotifier.loadOrderList("");
      expect(userOrderListLoaded, isA<AsyncError<List<Order>>>());
    });
  });

  group('Testing UserOrderListNotifier : addOrder', () {
    test('Should add order', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      when(() => mockOrderListRepository.createOrder(order))
          .thenAnswer((_) async => order);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderAdded = await userOrderListNotifier.addOrder(order);
      expect(orderAdded, true);
    });

    test('Should return an error if order is not added', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      when(() => mockOrderListRepository.createOrder(order))
          .thenThrow(Exception());
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderAdded = await userOrderListNotifier.addOrder(order);
      expect(orderAdded, false);
    });

    test('Should return an error if order is not loaded', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockOrderListRepository.createOrder(order))
          .thenAnswer((_) async => order);
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      final orderAdded = await userOrderListNotifier.addOrder(order);
      expect(orderAdded, false);
    });
  });

  group('Testing UserOrderListNotifier : deleteOrder', () {
    test('Should delete order', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      when(() => mockOrderListRepository.deleteOrder(order.id))
          .thenAnswer((_) async => true);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderDeleted = await userOrderListNotifier.deleteOrder(order);
      expect(orderDeleted, true);
    });

    test('Should return an error if order is not deleted', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      when(() => mockOrderListRepository.deleteOrder(order.id))
          .thenThrow(Exception());
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderDeleted = await userOrderListNotifier.deleteOrder(order);
      expect(orderDeleted, false);
    });

    test('Should return an error if order is not loaded', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockOrderListRepository.deleteOrder(order.id))
          .thenAnswer((_) async => true);
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      final orderDeleted = await userOrderListNotifier.deleteOrder(order);
      expect(orderDeleted, false);
    });

    test('Should return an error if order is not found', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockOrderListRepository.deleteOrder(order.id))
          .thenAnswer((_) async => true);
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => [order]);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderDeleted = await userOrderListNotifier.deleteOrder(order);
      expect(orderDeleted, true);
    });
  });

  group('Testing UserOrderListNotifier : updateOrder', () {
    test('Should update order', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => [order]);
      when(() => mockOrderListRepository.updateOrder(order))
          .thenAnswer((_) async => true);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderUpdated = await userOrderListNotifier.updateOrder(order);
      expect(orderUpdated, true);
    });

    test('Should return an error if order is not updated', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => [order]);
      when(() => mockOrderListRepository.updateOrder(order))
          .thenThrow(Exception());
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderUpdated = await userOrderListNotifier.updateOrder(order);
      expect(orderUpdated, false);
    });

    test('Should return an error if order is not loaded', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockOrderListRepository.updateOrder(order))
          .thenAnswer((_) async => true);
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => [order]);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      final orderUpdated = await userOrderListNotifier.updateOrder(order);
      expect(orderUpdated, false);
    });

    test('Should return an error if order is not found', () async {
      final mockUserOrderListRepository = MockAmapUserRespository();
      final mockOrderListRepository = MockOrderListRepository();
      final order = Order.empty().copyWith(id: "1");
      when(() => mockOrderListRepository.updateOrder(order))
          .thenAnswer((_) async => true);
      when(() => mockUserOrderListRepository.getOrderList(""))
          .thenAnswer((_) async => []);
      final userOrderListNotifier = UserOrderListNotifier(
          orderListRepository: mockOrderListRepository,
          userRepository: mockUserOrderListRepository);
      await userOrderListNotifier.loadOrderList("");
      final orderUpdated = await userOrderListNotifier.updateOrder(order);
      expect(orderUpdated, false);
    });
  });
}
