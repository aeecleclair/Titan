class TypeTicket {
  TypeTicket({
    required this.raffleId,
    required this.price,
    required this.value,
    required this.id,
  });
  late final String raffleId;
  late final double price;
  late final int value;
  late final String id;

  TypeTicket.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['value'] = value;
    data['id'] = id;
    return data;
  }

  TypeTicket copyWith({
    String? raffleId,
    double? price,
    int? value,
    String? id,
  }) =>
      TypeTicket(
          raffleId: raffleId ?? this.raffleId,
          price: price ?? this.price,
          value: value ?? this.value,
          id: id ?? this.id);

  TypeTicket.empty() {
    raffleId = '';
    price = 0;
    value = 0;
    id = '';
  }

  @override
  String toString() {
    return 'TypeTicketSimple(raffleId: $raffleId, price: $price, value: $value, id: $id)';
  }
}
