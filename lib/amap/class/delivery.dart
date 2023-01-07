import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/functions.dart';

class Delivery {
  Delivery(
      {required this.deliveryDate,
      required this.products,
      required this.id,
      required this.locked,
      this.expanded = false});
  late final bool expanded;
  late final bool locked;
  late final DateTime deliveryDate;
  late final List<Product> products;
  late final String id;

  Delivery.fromJson(Map<String, dynamic> json) {
    deliveryDate = DateTime.parse(json['delivery_date']);
    products =
        List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    id = json['id'];
    locked = json['locked'];
    expanded = false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['delivery_date'] = processDateToAPIWitoutHour(deliveryDate);
    data['products_ids'] = products.map((e) => e.id).toList();
    data['locked'] = locked;
    data['id'] = id;
    return data;
  }

  Delivery copyWith({deliveryDate, products, expanded, id, locked}) {
    return Delivery(
        deliveryDate: deliveryDate ?? this.deliveryDate,
        products: products ?? this.products,
        expanded: expanded ?? this.expanded,
        locked: locked ?? this.locked,
        id: id ?? this.id);
  }

  static Delivery empty() => Delivery(
      deliveryDate: DateTime.now(),
      products: [],
      expanded: false,
      locked: false,
      id: '');
}
