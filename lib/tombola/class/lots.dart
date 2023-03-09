class Lot {
  Lot({
    required this.id,
    required this.raffleId,
    required this.description,
    required this.quantity,
  });
  late final String id;
  late final String raffleId;
  late final String description;
  late final int quantity;

  Lot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    raffleId = json['raffle_id'];
    description = json['description'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['raffle_id'] = raffleId;
    data['description'] = description;
    data['quantity'] = quantity;
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
  }

  @override
  String toString() {
    return 'Lots{id: $id, raffleId: $raffleId, description: $description, quantity: $quantity}';
  }
}
