class Lots {
  Lots({
    required this.id,
    required this.raffleId,
    required this.description,
    required this.quantity,
  });
  late final String id;
  late final String raffleId;
  late final String description;
  late final int quantity;
  
  Lots.fromJson(Map<String, dynamic> json){
    id = json['id'];
    raffleId = json['raffle_id'];
    description = json['description'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['raffle_id'] = raffleId;
    _data['description'] = description;
    _data['quantity'] = quantity;
    return _data;
  }
}