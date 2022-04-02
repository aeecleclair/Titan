import 'package:myecl/amap/models/product.dart';

class Order {
  String? user;
  String? id;
  List<Product>? products;
  double? amount;
  String? collectionSlot;
  DateTime? orderingDate;
  DateTime? deliveryDate;

  Order(
      {this.user,
      this.id,
      this.products,
      this.amount,
      this.collectionSlot,
      this.orderingDate,
      this.deliveryDate});

  Order.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    id = json['id'];
    if (json['products'].isNotEmpty) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    amount = json['amount'];
    collectionSlot = json['collectionSlot'];
    if (json['orderingDate'] != null) {
      orderingDate = DateTime.parse(json['orderingDate']);
    } else {
      orderingDate = null;
    }
    if (json['deliveryDate'] != null) {
      deliveryDate = DateTime.parse(json['deliveryDate']);
    } else {
      deliveryDate = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['id'] = id;
    if (products!.isNotEmpty) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['amount'] = amount;
    data['collectionSlot'] = collectionSlot;
    data['orderingDate'] = orderingDate.toString();
    data['deliveryDate'] = deliveryDate.toString();
    return data;
  }
}
