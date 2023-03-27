import 'package:myecl/tombola/class/raffle.dart';

class TypeTicket {
  TypeTicket({
    required this.raffle,
    required this.price,
    required this.value,
    required this.id,
  });
  late final Raffle raffle;
  late final int price;
  late final int value;
  late final String id;

  TypeTicket.fromJson(Map<String, dynamic> json) {
    raffle = Raffle.fromJson(json['raffle']);
    price = json['price'];
    value = json['nb_valueticket'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffle.toJson();
    data['price'] = price;
    data['value'] = value;
    data['id'] = id;
    return data;
  }

  TypeTicket copyWith({
    Raffle? raffle,
    int? price,
    int? value,
    String? id,
  }) =>
      TypeTicket(
          raffle: raffle ?? this.raffle,
          price: price ?? this.price,
          value: value ?? this.value,
          id: id ?? this.id);

  TypeTicket.empty() {
    raffle = Raffle.empty();
    price = 0;
    value = 0;
    id = '';
  }

  @override
  String toString() {
    return 'TypeTicket(raffle: $raffle, price: $price, value: $value, id: $id)';
  }
}
