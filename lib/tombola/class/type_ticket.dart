class TypeTicket {
  TypeTicket({
    required this.raffleId,
    required this.price,
    required this.nbTicket,
  });
  late final String raffleId;
  late final int price;
  late final int nbTicket;

  TypeTicket.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    nbTicket = json['nb_ticket'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['nb_ticket'] = nbTicket;
    return data;
  }

  TypeTicket.copyWith({
    String? raffleId,
    int? price,
    int? nbTicket,
  }) {
    this.raffleId = raffleId ?? this.raffleId;
    this.price = price ?? this.price;
    this.nbTicket = nbTicket ?? this.nbTicket;
  }

  TypeTicket.empty() {
    raffleId = '';
    price = 0;
    nbTicket = 0;
  }

  @override
  String toString() {
    return 'TypeTicket{raffleId: $raffleId, price: $price, nbTicket: $nbTicket}';
  }
}
