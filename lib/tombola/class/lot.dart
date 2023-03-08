class Lot {
  Lot({
    required this.id,
    required this.raffleId,
    required this.quantity,
    required this.name,
    this.description,
  });
  late final String id;
  late final String raffleId;
  late final String? description;
  late final int quantity;
  late final String name;

  Lot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    raffleId = json['raffle_id'];
    description = json['description'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['raffle_id'] = raffleId;
    data['description'] = description;
    data['quantity'] = quantity;
    data['name'] = name;
    return data;
  }

  Lot.copyWith({
    String? id,
    String? raffleId,
    String? description,
    int? quantity,
  }) {
    this.id = id ?? this.id;
    this.raffleId = raffleId ?? this.raffleId;
    this.description = description ?? this.description;
    this.quantity = quantity ?? this.quantity;
  }

  Lot.empty() {
    id = '';
    raffleId = '';
    description = '';
    quantity = 0;
    name = '';
  }

  @override
  String toString() {
    return 'Lot{id: $id, raffleId: $raffleId, description: $description, quantity: $quantity}';
  }
}
