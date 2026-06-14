class Category {
  Category({
    required this.id,
    required this.name,
    required this.price,
    required this.quota,
    required this.requiredMembership,
    this.soldOut = false,
    this.disabled = false,
  });
  late final String id;
  late final String name;
  late final int price;
  late final int? quota;
  late final String? requiredMembership;
  late final bool soldOut;
  late final bool disabled;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    final priceInCents = (json['price'] as num?)?.toInt() ?? 0;
    price = priceInCents ~/ 100;
    quota = json['quota'];
    requiredMembership = json['required_membership']?.toString();
    soldOut = json['sold_out'] ?? false;
    disabled = json['disabled'] ?? false;
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

  Category copyWith({
    String? id,
    String? name,
    int? price,
    int? quota,
    String? requiredMembership,
    bool? soldOut,
    bool? disabled,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quota: quota ?? this.quota,
      requiredMembership: requiredMembership ?? this.requiredMembership,
      soldOut: soldOut ?? this.soldOut,
      disabled: disabled ?? this.disabled,
    );
  }

  Category.empty() {
    id = '';
    name = '';
    price = 0;
    quota = null;
    requiredMembership = null;
    soldOut = false;
    disabled = false;
  }

  @override
  String toString() {
    return 'Category{id : $id, name: $name, price: $price, quota: $quota, requiredMembership: $requiredMembership, soldOut: $soldOut, disabled: $disabled}';
  }
}
