import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/class/delivery.dart';
import 'package:titan/amap/class/information.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/repositories/amap_user_repository.dart';
import 'package:titan/amap/repositories/cash_repository.dart';
import 'package:titan/amap/repositories/delivery_list_repository.dart';
import 'package:titan/amap/repositories/delivery_product_list_repository.dart';
import 'package:titan/amap/repositories/information_repository.dart';
import 'package:titan/amap/repositories/order_list_repository.dart';
import 'package:titan/amap/repositories/product_repository.dart';
import 'package:titan/amap/tools/constants.dart';
import 'package:titan/amap/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

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
      expect(
        cash.toString(),
        'Cash{balance: 0.0, user: SimpleUser {name: Nom, firstname: Prénom, nickname: null, id: , accountType: external}}',
      );
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
          "account_type": "account_type",
          "floor": "floor",
          "groups": [],
          "phone": "phone",
          "promo": null,
        },
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
          "account_type": "external",
        },
      });
      expect(cash.toJson(), {"balance": 0.0});
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
          },
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
      newDelivery = delivery.copyWith(products: [newProduct]);
      expect(newDelivery.products, [newProduct]);
      newDelivery = delivery.copyWith(id: 'id');
      expect(newDelivery.id, 'id');
      newDelivery = delivery.copyWith(status: DeliveryStatus.delivered);
      expect(newDelivery.status, DeliveryStatus.delivered);
      newDelivery = delivery.copyWith(expanded: true);
      expect(newDelivery.expanded, true);
    });

    test('Should print properly', () async {
      final delivery = Delivery.empty().copyWith(
        deliveryDate: DateTime.parse('2021-01-01'),
        products: [Product.empty().copyWith(name: 'Name')],
        id: 'id',
        status: DeliveryStatus.creation,
      );
      expect(
        delivery.toString(),
        'Delivery{deliveryDate: 2021-01-01 00:00:00.000, products: [Product{id: , name: Name, price: 0.0, quantity: 0, category: }], id: id, status: DeliveryStatus.creation, expanded: false}',
      );
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
          },
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
      Order newOrder = order.copyWith(id: 'id');
      expect(newOrder.id, 'id');
      newOrder = order.copyWith(deliveryId: 'id');
      expect(newOrder.deliveryId, 'id');
      newOrder = order.copyWith(amount: 1);
      expect(newOrder.amount, 1);
      newOrder = order.copyWith(products: [newProduct]);
      expect(newOrder.products, [newProduct]);
      expect(newOrder.productsDetail, ['id']);
      expect(newOrder.productsQuantity, [1]);
      newOrder = order.copyWith(collectionSlot: CollectionSlot.midDay);
      expect(newOrder.collectionSlot, CollectionSlot.midDay);
      newOrder = order.copyWith(
        user: SimpleUser.empty().copyWith(name: 'Name'),
      );
      expect(newOrder.user.name, 'Name');
      newOrder = order.copyWith(orderingDate: DateTime.parse('2021-01-01'));
      expect(newOrder.orderingDate, DateTime.parse('2021-01-01'));
      newOrder = order.copyWith(deliveryDate: DateTime.parse('2021-01-01'));
      expect(newOrder.deliveryDate, DateTime.parse('2021-01-01'));
    });

    test('Should print properly', () async {
      final order = Order.empty().copyWith(
        id: 'id',
        deliveryId: 'delivery_id',
        amount: 0,
        products: [
          Product.empty().copyWith(
            id: 'id',
            name: 'name',
            price: 0,
            quantity: 0,
          ),
        ],
        collectionSlot: CollectionSlot.midDay,
        user: SimpleUser.empty().copyWith(name: 'Name'),
        orderingDate: DateTime.parse('2021-01-01'),
        deliveryDate: DateTime.parse('2021-01-01'),
      );
      expect(
        order.toString(),
        'Order{id: id, orderingDate: 2021-01-01 00:00:00.000, deliveryDate: 2021-01-01 00:00:00.000, productsDetail: [id], productsQuantity: [0], deliveryId: delivery_id, products: [Product{id: id, name: name, price: 0.0, quantity: 0, category: }], amount: 0.0, lastAmount: 0.0, collectionSlot: CollectionSlot.midDay, user: SimpleUser {name: Name, firstname: Prénom, nickname: null, id: , accountType: external}, expanded: false}',
      );
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
          },
        ],
        "collection_slot": "midi",
        "user": {
          "name": "Name",
          "firstname": "Firstname",
          "nickname": null,
          "id": "id",
          "account_type": "external",
        },
        "ordering_date": "2021-01-01",
        "delivery_date": "2021-01-01",
      });
      expect(order, isA<Order>());
    });

    test('Should return correct json', () async {
      final orderingDate = DateTime.utc(2021, 01, 01);
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
          },
        ],
        "collection_slot": "midi",
        "user": {
          "name": "Name",
          "firstname": "Firstname",
          "nickname": null,
          "id": "id",
          "account_type": "external",
        },
        "ordering_date": orderingDate.toIso8601String(),
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
        "ordering_date": orderingDate.toUtc().toIso8601String(),
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
      Information newInformation = information.copyWith(manager: "Manager");
      expect(newInformation.manager, "Manager");
      newInformation = information.copyWith(link: "Link");
      expect(newInformation.link, "Link");
      newInformation = information.copyWith(description: "Description");
      expect(newInformation.description, "Description");
    });

    test('Should print properly', () async {
      final information = Information.empty().copyWith(
        manager: "Manager",
        link: "Link",
        description: "Description",
      );
      expect(
        information.toString(),
        'Information{manager: Manager, link: Link, description: Description}',
      );
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
        },
      });
      expect(product, isA<Product>());
    });

    test('Should update with new values', () {
      final product = Product.empty();
      Product newProduct = product.copyWith(id: "id");
      expect(newProduct.id, "id");
      newProduct = product.copyWith(name: "name");
      expect(newProduct.name, "name");
      newProduct = product.copyWith(price: 0.0);
      expect(newProduct.price, 0.0);
      newProduct = product.copyWith(category: "category");
      expect(newProduct.category, "category");
      newProduct = product.copyWith(quantity: 0);
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
      expect(
        product.toString(),
        'Product{id: id, name: name, price: 0.0, quantity: 0, category: category}',
      );
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
    test('Should return the correct string', () async {
      expect(
        uiCollectionSlotToString(CollectionSlot.midDay),
        AMAPTextConstants.midDay,
      );
      expect(
        uiCollectionSlotToString(CollectionSlot.evening),
        AMAPTextConstants.evening,
      );
    });
    test('Should return a string', () async {
      expect(apiCollectionSlotToString(CollectionSlot.midDay), "midi");
      expect(apiCollectionSlotToString(CollectionSlot.evening), "soir");
    });
    test('Should return a CollectionSlot', () async {
      expect(apiStringToCollectionSlot("midi"), CollectionSlot.midDay);
      expect(apiStringToCollectionSlot("soir"), CollectionSlot.evening);
      expect(apiStringToCollectionSlot("test"), CollectionSlot.midDay);
    });

    test('Should return a string', () async {
      expect(deliveryStatusToString(DeliveryStatus.creation), "creation");
      expect(deliveryStatusToString(DeliveryStatus.available), "orderable");
      expect(deliveryStatusToString(DeliveryStatus.locked), "locked");
      expect(deliveryStatusToString(DeliveryStatus.delivered), "delivered");
    });

    test('Should return a DeliveryStatus', () async {
      expect(stringToDeliveryStatus("creation"), DeliveryStatus.creation);
      expect(stringToDeliveryStatus("orderable"), DeliveryStatus.available);
      expect(stringToDeliveryStatus("locked"), DeliveryStatus.locked);
      expect(stringToDeliveryStatus("delivered"), DeliveryStatus.delivered);
      expect(stringToDeliveryStatus("test"), DeliveryStatus.creation);
    });
  });
}
