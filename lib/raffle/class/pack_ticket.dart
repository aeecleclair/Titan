class PackTicket {
  PackTicket({
    required this.raffleId,
    required this.price,
    required this.id,
    required this.packSize,
  });
  late final String raffleId;
  late final double price;
  late final String id;
  late final int packSize;

  PackTicket.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    packSize = json['pack_size'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['id'] = id;
    data['pack_size'] = packSize;
    return data;
  }

  PackTicket copyWith({
    String? raffleId,
    double? price,
    String? id,
    int? packSize,
  }) => PackTicket(
    raffleId: raffleId ?? this.raffleId,
    price: price ?? this.price,
    id: id ?? this.id,
    packSize: packSize ?? this.packSize,
  );

  PackTicket.empty() {
    raffleId = "";
    price = 0.0;
    id = '';
    packSize = 0;
  }

  @override
  String toString() {
    return 'PackTicket(raffleId: $raffleId, price: $price, id: $id, packSize: $packSize)';
  }
}
