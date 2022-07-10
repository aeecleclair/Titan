import 'package:myecl/amap/class/product.dart';

class Delivery {
  Delivery({
    required this.deliveryDate,
    required this.products,
    required this.id,
  });
  late final String deliveryDate;
  late final List<Product> products;
  late final String id;

  Delivery.fromJson(Map<String, dynamic> json) {
    deliveryDate = json['delivery_date'];
    products =
        List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['delivery_date'] = deliveryDate;
    _data['products_ids'] = products.map((e) => e.id).toList();
    return _data;
  }
}
