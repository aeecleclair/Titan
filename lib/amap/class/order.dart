import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/functions.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

enum CollectionSlot { midi, soir }

class Order {
  Order(
      {required this.id,
      required this.deliveryId,
      required this.orderingDate,
      required this.productsDetail,
      required this.amount,
      required this.lastAmount,
      required this.collectionSlot,
      required this.user,
      this.productsQuantity = const <int>[],
      this.products = const [],
      this.expanded = false});
  late final SimpleUser user;
  late final CollectionSlot collectionSlot;
  late final String id;
  late final DateTime orderingDate;
  late final String deliveryId;
  late final List<String> productsDetail;
  late final bool expanded;
  late final List<Product> products;
  late final double amount, lastAmount;
  late final List<int> productsQuantity;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['order_id'];
    deliveryId = json['delivery_id'];
    amount = json['amount'];
    lastAmount = amount;
    products = List<Product>.from(
        json['productsdetail'].map((x) => Product.fromJson(x)));
    expanded = false;
    productsDetail =
        List<String>.from(products.map((element) => element.id).toList());
    productsQuantity =
        List<int>.from(products.map((element) => element.quantity).toList());
    collectionSlot = stringToCollectionSlot(json['collection_slot']);
    user = SimpleUser.fromJson(json['user']);
    orderingDate = DateTime.parse(json['ordering_date']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_id'] = id;
    data['delivery_id'] = deliveryId;
    data['amount'] = amount;
    data['ordering_date'] = processDateToAPIWitoutHour(orderingDate);
    data['products_ids'] = productsDetail;
    data['collection_slot'] = collectionSlotToString(collectionSlot);
    data['products_quantity'] = products.map((e) => e.quantity).toList();
    data['user_id'] = user.id;
    return data;
  }

  Order copyWith(
      {id,
      orderingDate,
      products,
      expanded,
      deliveryId,
      amount,
      lastAmount,
      collectionSlot,
      user}) {
    return Order(
        id: id ?? this.id,
        orderingDate: orderingDate ?? this.orderingDate,
        productsDetail: products != null
            ? List<String>.from(products.map((element) => element.id).toList())
            : productsDetail,
        productsQuantity: products != null
            ? List<int>.from(
                products.map((element) => element.quantity).toList())
            : productsQuantity,
        deliveryId: deliveryId ?? this.deliveryId,
        products: products ?? this.products,
        amount: amount ?? this.amount,
        lastAmount: lastAmount ?? this.lastAmount,
        collectionSlot: collectionSlot ?? this.collectionSlot,
        expanded: expanded ?? this.expanded,
        user: user ?? this.user);
  }

  void setProducts(List<Product> products) {
    this.products = products
        .where((element) => productsDetail.contains(element.id))
        .toList();
    productsQuantity = products.map((element) => element.quantity).toList();
  }

  static Order empty() {
    return Order(
        id: '',
        orderingDate: DateTime.now(),
        productsDetail: [],
        productsQuantity: [],
        deliveryId: '',
        products: [],
        amount: 0,
        lastAmount: 0,
        collectionSlot: CollectionSlot.midi,
        expanded: false,
        user: SimpleUser.empty());
  }
}
