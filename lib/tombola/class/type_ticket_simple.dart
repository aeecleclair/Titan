class TypeTicketSimple {
  TypeTicketSimple({
    required this.raffleId,
    required this.price,
    required this.value,
    required this.id,
  });
  late final String raffleId;
  late final int price;
  late final int value;
  late final String id;

  TypeTicketSimple.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    value = json['nb_valueticket'];
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

  TypeTicketSimple copyWith({
    String? raffleId,
    int? price,
    int? value,
    String? id,
  }) =>
      TypeTicketSimple(
          raffleId: raffleId ?? this.raffleId,
          price: price ?? this.price,
          value: value ?? this.value,
          id: id ?? this.id);

  TypeTicketSimple.empty() {
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
