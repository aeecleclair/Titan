class Category {
  Category({
    required this.id,
    required this.name,
    required this.price,
    required this.quota,
    required this.requiredMembership,
    this.disabled = false,
    this.ticketsInCheckout = 0,
    this.ticketsSold = 0,
    this.soldOut = false,
  });
  late final String id;
  late final String name;
  late final int price;
  late final int? quota;
  late final String? requiredMembership;
  late final bool disabled;
  late final int ticketsInCheckout;
  late final int ticketsSold;
  late final bool soldOut;

  bool get hasSales => ticketsInCheckout + ticketsSold > 0;

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    name = json['name']?.toString() ?? '';
    final priceInCents = (json['price'] as num?)?.toInt() ?? 0;
    price = priceInCents ~/ 100;
    quota = json['quota'];
    requiredMembership = json['required_membership']?.toString();
    disabled = json['disabled'] ?? false;
    ticketsInCheckout = (json['tickets_in_checkout'] as num?)?.toInt() ?? 0;
    ticketsSold = (json['tickets_sold'] as num?)?.toInt() ?? 0;
    soldOut = json['sold_out'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    // Convert euros back to cents for the backend
    data['price'] = price * 100;
    data['quota'] = quota;
    data['required_membership'] = requiredMembership;
    data['disabled'] = disabled;
    return data;
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'name': name,
      'price': price * 100,
      'quota': quota,
      'required_membership': requiredMembership,
    };
  }

  Category copyWith({
    String? id,
    String? name,
    int? price,
    int? quota,
    String? requiredMembership,
    bool? disabled,
    int? ticketsInCheckout,
    int? ticketsSold,
    bool? soldOut,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quota: quota ?? this.quota,
      requiredMembership: requiredMembership ?? this.requiredMembership,
      disabled: disabled ?? this.disabled,
      ticketsInCheckout: ticketsInCheckout ?? this.ticketsInCheckout,
      ticketsSold: ticketsSold ?? this.ticketsSold,
      soldOut: soldOut ?? this.soldOut,
    );
  }

  Category.empty() {
    id = '';
    name = '';
    price = 0;
    quota = null;
    requiredMembership = null;
    disabled = false;
    ticketsInCheckout = 0;
    ticketsSold = 0;
    soldOut = false;
  }

  @override
  String toString() {
    return 'Category{id : $id, name: $name, price: $price, quota: $quota, requiredMembership: $requiredMembership, soldOut: $soldOut, disabled: $disabled}';
  }
}
