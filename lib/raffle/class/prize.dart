class Prize {
  Prize({
    required this.id,
    required this.name,
    required this.raffleId,
    required this.quantity,
    this.description,
  });
  late final String id;
  late final String name;
  late final String raffleId;
  late final String? description;
  late final int quantity;

  Prize.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    raffleId = json['raffle_id'] as String;
    description = json['description'] as String;
    quantity = json['quantity'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['raffle_id'] = raffleId;
    data['description'] = description;
    data['quantity'] = quantity;
    return data;
  }

  Prize copyWith({
    String? id,
    String? name,
    String? raffleId,
    String? description,
    int? quantity,
  }) =>
      Prize(
        id: id ?? this.id,
        name: name ?? this.name,
        raffleId: raffleId ?? this.raffleId,
        description: description,
        quantity: quantity ?? this.quantity,
      );

  Prize.empty() {
    id = '';
    name = '';
    raffleId = '';
    description = null;
    quantity = 0;
  }

  @override
  String toString() {
    return 'Prize{id: $id, name: $name, raffleId: $raffleId, description: $description, quantity: $quantity}';
  }
}
