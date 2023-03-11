class TypeTicket {
  TypeTicket({
    required this.raffleId,
    required this.price,
    required this.nbTicket,
    required this.id,
  });
  late final String raffleId;
  late final int price;
  late final int nbTicket;
  late final String id;

  TypeTicket.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    nbTicket = json['nb_ticket'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['nb_ticket'] = nbTicket;
    data['id'] = id;
    return data;
  }

  TypeTicket copyWith({
    String? raffleId,
    int? price,
    int? nbTicket,
    String? id,
  }) =>
      TypeTicket(
          raffleId: raffleId ?? this.raffleId,
          price: price ?? this.price,
          nbTicket: nbTicket ?? this.nbTicket,
          id: id ?? this.id);

  TypeTicket.empty() {
    raffleId = '';
    price = 0;
    nbTicket = 0;
    id = '';
  }

  @override
  String toString() {
    return 'TypeTicket(raffleId: $raffleId, price: $price, nbTicket: $nbTicket, id: $id)';
  }
}
