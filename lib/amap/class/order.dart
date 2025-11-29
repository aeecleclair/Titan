import 'package:titan/amap/class/product.dart';
import 'package:titan/amap/tools/functions.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/user/class/simple_users.dart';

enum CollectionSlot { midDay, evening }

class Order {
  Order({
    required this.id,
    required this.deliveryId,
    required this.orderingDate,
    required this.deliveryDate,
    required this.productsDetail,
    required this.amount,
    required this.lastAmount,
    required this.collectionSlot,
    required this.user,
    this.productsQuantity = const <int>[],
    this.products = const [],
    this.expanded = false,
  });
  late final SimpleUser user;
  late final CollectionSlot collectionSlot;
  late final String id;
  late final DateTime orderingDate;
  late final DateTime deliveryDate;
  late final String deliveryId;
  late final List<String> productsDetail;
  late final bool expanded;
  late final List<Product> products;
  late final int amount, lastAmount;
  late final List<int> productsQuantity;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['order_id'];
    deliveryId = json['delivery_id'];
    amount = json['amount'];
    lastAmount = amount;
    products = List<Product>.from(
      json['productsdetail'].map((x) => Product.fromJson(x)),
    );
    expanded = false;
    productsDetail = List<String>.from(
      products.map((element) => element.id).toList(),
    );
    productsQuantity = List<int>.from(
      products.map((element) => element.quantity).toList(),
    );
    collectionSlot = apiStringToCollectionSlot(json['collection_slot']);
    user = SimpleUser.fromJson(json['user']);
    orderingDate = processDateFromAPI(json['ordering_date']);
    deliveryDate = processDateFromAPIWithoutHour(json['delivery_date']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['order_id'] = id;
    data['delivery_id'] = deliveryId;
    data['amount'] = amount;
    data['ordering_date'] = processDateToAPI(orderingDate);
    data['delivery_date'] = processDateToAPIWithoutHour(deliveryDate);
    data['products_ids'] = productsDetail;
    data['collection_slot'] = apiCollectionSlotToString(collectionSlot);
    data['products_quantity'] = products.map((e) => e.quantity).toList();
    data['user_id'] = user.id;
    return data;
  }

  Order copyWith({
    String? id,
    DateTime? orderingDate,
    DateTime? deliveryDate,
    List<Product>? products,
    bool? expanded,
    String? deliveryId,
    int? amount,
    int? lastAmount,
    CollectionSlot? collectionSlot,
    SimpleUser? user,
  }) {
    return Order(
      id: id ?? this.id,
      orderingDate: orderingDate ?? this.orderingDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      productsDetail: products != null
          ? List<String>.from(products.map((element) => element.id).toList())
          : productsDetail,
      productsQuantity: products != null
          ? List<int>.from(products.map((element) => element.quantity).toList())
          : productsQuantity,
      deliveryId: deliveryId ?? this.deliveryId,
      products: products ?? this.products,
      amount: amount ?? this.amount,
      lastAmount: lastAmount ?? this.lastAmount,
      collectionSlot: collectionSlot ?? this.collectionSlot,
      expanded: expanded ?? this.expanded,
      user: user ?? this.user,
    );
  }

  static Order empty() {
    return Order(
      id: '',
      orderingDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      productsDetail: [],
      productsQuantity: [],
      deliveryId: '',
      products: [],
      amount: 0,
      lastAmount: 0,
      collectionSlot: CollectionSlot.midDay,
      expanded: false,
      user: SimpleUser.empty(),
    );
  }

  @override
  String toString() {
    return 'Order{id: $id, orderingDate: $orderingDate, deliveryDate: $deliveryDate, productsDetail: $productsDetail, productsQuantity: $productsQuantity, deliveryId: $deliveryId, products: $products, amount: $amount, lastAmount: $lastAmount, collectionSlot: $collectionSlot, user: $user, expanded: $expanded}';
  }
}
