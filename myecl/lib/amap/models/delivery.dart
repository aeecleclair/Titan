import 'product.dart';

class Delivery {
  String? id;
  List<Product>? products;
  DateTime? deliveryDate;

  Delivery({this.id, this.products, this.deliveryDate});

  Delivery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['products'].isNotEmpty) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    if (json['delivery_date'] != null) {
      deliveryDate = DateTime.parse(json['delivery_date']);
    } else {
      deliveryDate = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (products!.isNotEmpty) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['deliveryDate'] = deliveryDate.toString();
    return data;
  }
}
