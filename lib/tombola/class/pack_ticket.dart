import 'package:myecl/tombola/class/raffle.dart';

class PackTicket {
  PackTicket({
    required this.raffleId,
    required this.price,
    required this.value,
    required this.id,
    required this.packSize,
    required this.probaWin,
  });
  late final String raffleId;
  late final double price;
  late final int value;
  late final String id;
  late final double packSize;
  late final double probaWin;

  PackTicket.fromJson(Map<String, dynamic> json) {
    raffleId = json['raffle_id'];
    price = json['price'];
    packSize = json['packSize'];
    probaWin = json['probaWin'];
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['raffle_id'] = raffleId;
    data['price'] = price;
    data['value'] = value;
    data['id'] = id;
    data['packSize'] = packSize;
    data['probaWin'] = probaWin;
    return data;
  }

  PackTicket copyWith({
    String? raffleId,
    double? price,
    int? value,
    String? id,
    double? packSize,
    double? probaWin,
  }) =>
      PackTicket(
          raffleId: raffleId ?? this.raffleId,
          price: price ?? this.price,
          value: value ?? this.value,
          id: id ?? this.id,
          packSize: packSize ?? this.packSize,
          probaWin: probaWin ?? this.probaWin);

  PackTicket.empty() {
    raffleId = "";
    price = 0;
    value = 0;
    id = '';
    packSize = 0;
    probaWin = 0;
  }

  @override
  String toString() {
    return 'PackTicket(raffleId: $raffleId, price: $price, value: $value, id: $id, packSize: $packSize, probaWin: $probaWin)';
  }
}
