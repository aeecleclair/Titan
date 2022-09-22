import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/user/class/list_users.dart';

class Order {
  Order(
      {required this.id,
      required this.deliveryId,
      required this.deliveryDate,
      required this.productsIds,
      required this.amount,
      required this.collectionSlot,
      required this.user,
      this.productsQuantity = const <int>[],
      this.products = const [],
      this.expanded = false});
  late final SimpleUser user;
  late final String collectionSlot;
  late final String id;
  late final DateTime deliveryDate;
  late final String deliveryId;
  late final List<String> productsIds;
  late final bool expanded;
  late final List<Product> products;
  late final double amount;
  late final List<int> productsQuantity;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['order_id'];
    deliveryDate = DateTime.parse(json['delivery_date']);
    deliveryId = json['delivery_id'];
    amount = json['amount'];
    products =
        List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    expanded = false;
    productsIds =
        List<String>.from(products.map((element) => element.id).toList());
    productsQuantity =
        List<int>.from(products.map((element) => element.quantity).toList());
    collectionSlot = json['collection_slot'];
    user = SimpleUser.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_id'] = id;
    data['delivery_id'] = deliveryId;
    data['delivery_date'] = processDateToAPIWitoutHour(deliveryDate);
    data['products_ids'] = productsIds;
    data['collection_slot'] = collectionSlot;
    data['products_quantity'] = products.map((e) => e.quantity).toList();
    data['user_id'] = user.id;
    return data;
  }

  Order copyWith(
      {id,
      deliveryDate,
      products,
      expanded,
      deliveryId,
      amount,
      collectionSlot,
      user}) {
    return Order(
        id: id ?? this.id,
        deliveryDate: deliveryDate ?? this.deliveryDate,
        productsIds: products != null
            ? List<String>.from(products.map((element) => element.id).toList())
            : productsIds,
        productsQuantity: products != null
            ? List<int>.from(
                products.map((element) => element.quantity).toList())
            : productsQuantity,
        deliveryId: deliveryId ?? this.deliveryId,
        products: products ?? this.products,
        amount: amount ?? this.amount,
        collectionSlot: collectionSlot ?? this.collectionSlot,
        expanded: expanded ?? this.expanded,
        user: user ?? this.user);
  }

  void setProducts(List<Product> products) {
    this.products =
        products.where((element) => productsIds.contains(element.id)).toList();
    productsQuantity = products.map((element) => element.quantity).toList();
  }
}
