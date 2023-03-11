class Ticket {
  Ticket({
    required this.typeId,
    required this.userId,
    required this.winningLot,
    required this.id,
    required this.raffleId,
    required this.price,
    required this.nbTicket,
  });
  late final String typeId;
  late final String userId;
  late final String winningLot;
  late final String id;
  late final String raffleId;
  late final int price;
  late final int nbTicket;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    userId = json['user_id'];
    winningLot = json['winning_lot'];
    id = json['id'];
    raffleId = json['raffle_id'];
    price = json['price'];
    nbTicket = json['nb_ticket'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['user_id'] = userId;
    data['winning_lot'] = winningLot;
    data['id'] = id;
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['nb_ticket'] = nbTicket;
    return data;
  }

  Ticket copyWith({
    String? typeId,
    String? userId,
    String? winningLot,
    String? id,
    String? raffleId,
    int? price,
    int? nbTicket,
  }) =>
      Ticket(
          typeId: typeId ?? this.typeId,
          userId: userId ?? this.userId,
          winningLot: winningLot ?? this.winningLot,
          id: id ?? this.id,
          raffleId: raffleId ?? this.raffleId,
          price: price ?? this.price,
          nbTicket: nbTicket ?? this.nbTicket);

  Ticket.empty() {
    typeId = '';
    userId = '';
    winningLot = '';
    id = '';
    raffleId = '';
    price = 0;
    nbTicket = 0;
  }

  @override
  String toString() {
    return 'Ticket(typeId: $typeId, userId: $userId, winningLot: $winningLot, id: $id, raffleId: $raffleId, price: $price, nbTicket: $nbTicket)';
  }
}
