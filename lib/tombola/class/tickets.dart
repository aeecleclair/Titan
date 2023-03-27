class Ticket {
  Ticket({
    required this.typeId,
    required this.userId,
    required this.groupId,
    required this.winningLot,
    required this.id,
    required this.raffleId,
    required this.unitPrice,
    required this.nbTicket,
  });
  late final String typeId;
  late final String userId;
  late final String groupId;
  late final String? winningLot;
  late final String id;
  late final String raffleId;
  late final int unitPrice;
  late final int nbTicket;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    userId = json['user_id'];
    groupId = json['group_id'];
    winningLot = json['winning_lot'];
    id = json['id'];
    raffleId = json['raffle_id'];
    unitPrice = json['unit_rice'];
    nbTicket = json['nb_ticket'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['user_id'] = userId;
    data['group_id'] = groupId;
    data['winning_lot'] = winningLot;
    data['id'] = id;
    data['raffle_id'] = raffleId;
    data['unitPrice'] = unitPrice;
    data['nb_ticket'] = nbTicket;
    return data;
  }

  Ticket copyWith({
    String? typeId,
    String? userId,
    String? groupId,
    String? winningLot,
    String? id,
    String? raffleId,
    int? unitPrice,
    int? nbTicket,
  }) =>
      Ticket(
          typeId: typeId ?? this.typeId,
          userId: userId ?? this.userId,
          groupId: groupId ?? this.groupId,
          winningLot: winningLot,
          id: id ?? this.id,
          raffleId: raffleId ?? this.raffleId,
          unitPrice: unitPrice ?? this.unitPrice,
          nbTicket: nbTicket ?? this.nbTicket);

  Ticket.empty() {
    typeId = '';
    userId = '';
    groupId = '';
    winningLot = null;
    id = '';
    raffleId = '';
    unitPrice = 0;
    nbTicket = 0;
  }

  @override
  String toString() {
    return 'Ticket(typeId: $typeId, userId: $userId, groupId: $groupId, winningLot: $winningLot, id: $id, raffleId: $raffleId, unitPrice: $unitPrice, nbTicket: $nbTicket)';
  }
}
