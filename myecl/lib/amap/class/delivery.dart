import 'package:myecl/amap/class/product.dart';
import 'package:myecl/amap/tools/functions.dart';

class Delivery {
  Delivery({
    required this.deliveryDate,
    required this.products,
    required this.id,
    this.expanded = false
  });
  late final bool expanded;
  late final DateTime deliveryDate;
  late final List<Product> products;
  late final String id;

  Delivery.fromJson(Map<String, dynamic> json) {
    deliveryDate = DateTime.parse(json['delivery_date']);
    products =
        List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    id = json['id'];
    expanded = false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['delivery_date'] = processDate(deliveryDate);
    _data['products_ids'] = products.map((e) => e.id).toList();
    return _data;
  }

  Delivery copyWith({deliveryDate, products, expanded, id}) {
    return Delivery(
        deliveryDate: deliveryDate ?? this.deliveryDate,
        products: products ?? this.products,
        expanded: expanded ?? this.expanded,
        id: id ?? this.id);
  }
}
