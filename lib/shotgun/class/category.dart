class Category {
  Category({
    required this.id,
    required this.name,
    required this.price,
    required this.quota,
    required this.requiredMembership,
  });
  late final String id;
  late final String name;
  late final int price;
  late final int? quota;
  late final String? requiredMembership;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // Price is stored in cents in the backend, convert to euros for the app
    final priceInCents = (json['price'] as num?)?.toInt() ?? 0;
    price = priceInCents ~/ 100;
    quota = json['quota'];
    requiredMembership = json['required_membership'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    // Convert euros back to cents for the backend
    data['price'] = price * 100;
    data['quota'] = quota;
    data['required_membership'] = requiredMembership;
    return data;
  }

  Category copyWith({String? id, String? name, int? price}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quota: quota,
      requiredMembership: requiredMembership,
    );
  }

  Category.empty() {
    id = '';
    name = '';
    price = 0;
    quota = null;
    requiredMembership = null;
  }

  @override
  String toString() {
    return 'Category{id : $id, name: $name, price: $price, quota: $quota, requiredMembership: $requiredMembership}';
  }
}
