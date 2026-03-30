import 'package:titan/tools/functions.dart';

class Category {
  Category({required this.id, required this.name, required this.price});
  late final String id;
  late final String name;
  late final int price;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }

  Category copyWith({String? id, String? name, int? price}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Category.empty() {
    id = '';
    name = '';
    price = 0;
  }

  @override
  String toString() {
    return 'Category{id : $id, name: $name, price: $price}';
  }
}
