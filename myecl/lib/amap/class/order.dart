import 'package:myecl/amap/class/product.dart';

class Order {
  Order({
    required this.id,
    required this.date,
    required this.products,
    this.expanded = false
  });
  late final String id;
  late final DateTime date;
  late final List<Product> products;
  late final bool expanded;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = DateTime.parse(json['date']);
    products = List<Product>.from(json['products'].map((x) => Product.fromJson(x)));
    expanded = false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['date'] = date.toIso8601String();
    _data['products'] = products.map((x) => x.toJson()).toList();
    return _data;
  }

  Order copy({id, date, products, expanded}) => Order(
      id: id ?? this.id,
      date: date ?? this.date,
      products: products ?? this.products,
      expanded: expanded ?? this.expanded);
}