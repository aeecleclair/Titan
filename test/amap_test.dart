import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/delivery.dart';
import 'package:myecl/amap/class/information.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/repositories/amap_user_repository.dart';
import 'package:myecl/amap/repositories/cash_repository.dart';
import 'package:myecl/amap/repositories/delivery_list_repository.dart';
import 'package:myecl/amap/repositories/delivery_product_list_repository.dart';
import 'package:myecl/amap/repositories/information_repository.dart';
import 'package:myecl/amap/repositories/order_list_repository.dart';
import 'package:myecl/amap/repositories/product_repository.dart';
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

    test('Should parse an Cash from json', () async {
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
      final information = Information.empty();
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
        "quantity": 0,
      });
      expect(product, isA<Product>());
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

}
