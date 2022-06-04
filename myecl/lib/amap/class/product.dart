class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.category,
  });
  late final String id;
  late final String name;
  late final double price;
  late final int quantity;
  late final String category;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = 0;
    category = json['category'];
  }

  Product copyWith({id, name, price, quantity, category}) => Product(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
      );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['category'] = category;
    return _data;
  }
}
