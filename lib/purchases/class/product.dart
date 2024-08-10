class Product {
  Product({
    required this.id,
    required this.nameFR,
    required this.nameEN,
    this.descriptionFR = "",
    this.descriptionEN = "",
  });

  late final String id;
  late final String nameFR;
  late final String nameEN;
  late final String descriptionFR;
  late final String descriptionEN;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameFR = json['name_fr'];
    nameEN = json['name_en'];
    descriptionFR = json['description_fr'] ?? "";
    descriptionEN = json['description_en'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'name_fr': nameFR,
      'name_en': nameEN,
      'description_fr': descriptionFR,
      'description_en': descriptionEN,
    };
    return data;
  }

  Product copyWith({
    String? id,
    String? nameFR,
    String? nameEN,
    String? descriptionFR,
    String? descriptionEN,
  }) {
    return Product(
      id: id ?? this.id,
      nameFR: nameFR ?? this.nameFR,
      nameEN: nameEN ?? this.nameEN,
      descriptionFR: descriptionFR ?? this.descriptionFR,
      descriptionEN: descriptionEN ?? this.descriptionEN,
    );
  }

  Product.empty() {
    id = "";
    nameFR = "";
    nameEN = "";
    descriptionFR = "";
    descriptionEN = "";
  }

  @override
  String toString() {
    return 'Product(id: $id, nameFR: $nameFR, nameEN: $nameEN, descriptionFR: $descriptionFR, descriptionEN: $descriptionEN)';
  }
}
