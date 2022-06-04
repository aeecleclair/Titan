import 'package:myecl/amap/class/product.dart';

class Delivery {
  Delivery({
    required this.daliveryDate,
    required this.products,
    required this.id,
  });
  late final String daliveryDate;
  late final List<Product> products;
  late final String id;

  Delivery.fromJson(Map<String, dynamic> json) {
    daliveryDate = json['daliveryDate'];
    products = List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['daliveryDate'] = daliveryDate;
    _data['products'] = products;
    _data['id'] = id;
    return _data;
  }
}
