class Product {
  String? id;
  String? name;
  double? price;
  String? category;

  Product({this.id, this.name, this.price, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['category'] = category;
    return data;
  }
}