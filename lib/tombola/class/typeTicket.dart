class TypeTicket {
  TypeTicket({
    required this.raffleId,
    required this.price,
    required this.nbTicket,
  });
  late final String raffleId;
  late final int price;
  late final int nbTicket;
  
  TypeTicket.fromJson(Map<String, dynamic> json){
    raffleId = json['raffle_id'];
    price = json['price'];
    nbTicket = json['nb_ticket'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['raffle_id'] = raffleId;
    _data['price'] = price;
    _data['nb_ticket'] = nbTicket;
    return _data;
  }
}