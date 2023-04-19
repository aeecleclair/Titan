import 'package:myecl/tombola/class/raffle.dart';

class PackTicket {
  PackTicket({
    required this.raffle,
    required this.price,
    required this.value,
    required this.id,
    required this.packSize,
    required this.probaWin,
  });
  late final Raffle raffle;
  late final double price;
  late final int value;
  late final String id;
  late final double packSize;
  late final double probaWin;

  PackTicket.fromJson(Map<String, dynamic> json) {
    raffle = json['raffle_id'];
    price = json['price'];
    packSize = json['packSize'];
    probaWin = json['probaWin'];
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffle;
    data['price'] = price;
    data['value'] = value;
    data['id'] = id;
    data['packSize'] = packSize;
    data['probaWin'] = probaWin;
    return data;
  }

  PackTicket copyWith({
    Raffle? raffle,
    double? price,
    int? value,
    String? id,
    double? packSize,
    double? probaWin,
  }) =>
      PackTicket(
          raffle: raffle ?? this.raffle,
          price: price ?? this.price,
          value: value ?? this.value,
          id: id ?? this.id,
          packSize: packSize ?? this.packSize,
          probaWin: probaWin ?? this.probaWin);

  PackTicket.empty() {
    raffle = Raffle.empty();
    price = 0;
    value = 0;
    id = '';
    packSize = 0;
    probaWin = 0;
  }

  @override
  String toString() {
    return 'PackTicket(raffle: $raffle, price: $price, value: $value, id: $id, packSize: $packSize, probaWin: $probaWin)';
  }
}
