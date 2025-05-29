class Seller {
  Seller({required this.id, required this.name, required this.order});

  late final String id;
  late final String name;
  late final int order;

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{'id': id, 'name': name, 'order': order};
    return data;
  }

  Seller copyWith({String? id, String? name, int? order}) {
    return Seller(
      id: id ?? this.id,
      name: name ?? this.name,
      order: order ?? this.order,
    );
  }

  Seller.empty() {
    id = "";
    name = "";
    order = 0;
  }

  @override
  String toString() {
    return 'Seller(id: $id, name: $name, order: $order)';
  }
}
