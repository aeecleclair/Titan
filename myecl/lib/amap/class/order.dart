import 'package:myecl/amap/class/product.dart';

class Order {
  Order(
      {required this.id,
      required this.deliveryId,
      required this.deliveryDate,
      required this.productsIds,
      required this.amount,
      this.productsQuantity = const <int>[],
      this.products = const [],
      this.expanded = false});
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
    products = [];
    expanded = false;
    productsIds = [];
    productsQuantity = [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_id'] = id;
    _data['delivery_id'] = deliveryId;
    _data['delivery_date'] = deliveryDate.toIso8601String();
    _data['products_ids'] = productsIds;
    _data['products_quantity'] = products.map((e) => e.quantity).toList();
    return _data;
  }

  Order copyWith({id, deliveryDate, products, expanded, deliveryId, amount}) {
    return Order(
          id: id ?? this.id,
          deliveryDate: deliveryDate ?? this.deliveryDate,
          productsIds:
              products != null ? List<String>.from(products.map((element) => element.id).toList()) : productsIds,
          productsQuantity: products != null ? List<int>.from(products.map((element) => element.quantity).toList()) : productsQuantity,
          deliveryId: deliveryId ?? this.deliveryId,
          products: products ?? this.products,
          amount: amount ?? this.amount,
          expanded: expanded ?? this.expanded);
  }

  void setProducts(List<Product> products) {
    this.products =
        products.where((element) => productsIds.contains(element.id)).toList();
    productsQuantity = products.map((element) => element.quantity).toList();
  }
}
