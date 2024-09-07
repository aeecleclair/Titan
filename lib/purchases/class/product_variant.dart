class ProductVariant {
  ProductVariant({
    required this.id,
    required this.productId,
    required this.nameFR,
    this.nameEN = "",
    this.descriptionFR = "",
    this.descriptionEN = "",
    required this.price,
  });

  late final String id;
  late final String productId;
  late final String nameFR;
  late final String nameEN;
  late final String descriptionFR;
  late final String descriptionEN;
  late final int price;

  ProductVariant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    nameFR = json['name_fr'];
    nameEN = json['name_en'] ?? "";
    descriptionFR = json['description_fr'] ?? "";
    descriptionEN = json['description_en'] ?? "";
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'product_id': productId,
      'name_fr': nameFR,
      'name_en': nameEN,
      'description_fr': descriptionFR,
      'description_en': descriptionEN,
      'price': price,
    };
    return data;
  }

  ProductVariant copyWith({
    String? id,
    String? productId,
    String? nameFR,
    String? nameEN,
    String? descriptionFR,
    String? descriptionEN,
    int? price,
  }) {
    return ProductVariant(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      nameFR: nameFR ?? this.nameFR,
      nameEN: nameEN ?? this.nameEN,
      descriptionFR: descriptionFR ?? this.descriptionFR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
      price: price ?? this.price,
    );
  }

  ProductVariant.empty() {
    id = "";
    productId = "";
    nameFR = "";
    nameEN = "";
    descriptionFR = "";
    descriptionEN = "";
    price = 0;
  }

  @override
  String toString() {
    return 'ProductVariant(id: $id, productId: $productId, nameFR: $nameFR, nameEN: $nameEN, descriptionFR: $descriptionFR, descriptionEN: $descriptionEN, price: $price)';
  }
}
