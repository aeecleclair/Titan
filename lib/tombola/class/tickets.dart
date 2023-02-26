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
  
  Ticket.fromJson(Map<String, dynamic> json){
    typeId = json['type_id'];
    userId = json['user_id'];
    winningLot = json['winning_lot'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type_id'] = typeId;
    _data['user_id'] = userId;
    _data['winning_lot'] = winningLot;
    _data['id'] = id;
    return _data;
  }
}