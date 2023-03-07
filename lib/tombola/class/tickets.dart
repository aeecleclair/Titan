class Ticket {
  Ticket({
    required this.typeId,
    required this.userId,
    required this.winningLot,
    required this.id,
  });
  late final String typeId;
  late final String userId;
  late final String winningLot;
  late final String id;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    userId = json['user_id'];
    winningLot = json['winning_lot'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeId;
    data['user_id'] = userId;
    data['winning_lot'] = winningLot;
    data['id'] = id;
    return data;
  }

  Ticket.copyWith({
    String? typeId,
    String? userId,
    String? winningLot,
    String? id,
  }) {
    this.typeId = typeId ?? this.typeId;
    this.userId = userId ?? this.userId;
    this.winningLot = winningLot ?? this.winningLot;
    this.id = id ?? this.id;
  }

  Ticket.empty() {
    typeId = '';
    userId = '';
    winningLot = '';
    id = '';
  }

  @override
  String toString() {
    return 'Ticket{typeId: $typeId, userId: $userId, winningLot: $winningLot, id: $id}';
  }
}
