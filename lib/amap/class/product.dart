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
    if (json.containsKey("product")) {
      quantity = json["quantity"];
      id = json["product"]['id'];
      name = json["product"]['name'];
      price = json["product"]['price'];
      category = json["product"]['category'];
    } else {
      id = json['id'];
      name = json['name'];
      price = json['price'];
      quantity = 0;
      category = json['category'];
    }
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? category,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    category: category ?? this.category,
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['category'] = category;
    return data;
  }

  static Product empty() {
    return Product(id: "", name: "", price: 0, quantity: 0, category: "");
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, quantity: $quantity, category: $category}';
  }
}
