class TypeTicketSimple {
  TypeTicketSimple({
    required this.raffleId,
    required this.price,
    required this.packSize,
    required this.id,
  });
  late final String raffleId;
  late final double price;
  late final int packSize;
  late final String id;

  TypeTicketSimple.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    packSize = json['pack_size'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['pack_size'] = packSize;
    data['id'] = id;
    return data;
  }

  TypeTicketSimple copyWith({
    String? raffleId,
    double? price,
    int? packSize,
    String? id,
  }) =>
      TypeTicketSimple(
          raffleId: raffleId ?? this.raffleId,
          price: price ?? this.price,
          packSize: packSize ?? this.packSize,
          id: id ?? this.id);

  TypeTicketSimple.empty() {
    raffleId = '';
    price = 0;
    packSize = 0;
    id = '';
  }

  @override
  String toString() {
    return 'TypeTicketSimpleSimple(raffleId: $raffleId, price: $price, packSize: $packSize, id: $id)';
  }
}
