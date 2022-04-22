import 'package:myecl/amap/class/product.dart';

class Order {
  final String id;

  final DateTime date;

  final List<Product> products;

  final bool expanded;

  Order(
      {required this.id,
      required this.date,
      required this.products,
      this.expanded = false});

  Order copy({id, date, products, expanded}) => Order(
      id: id ?? this.id,
      date: date ?? this.date,
      products: products ?? this.products,
      expanded: expanded ?? this.expanded);
}
