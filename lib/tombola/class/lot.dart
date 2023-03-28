import 'package:myecl/tombola/class/raffle.dart';

class Lot {
  Lot({
    required this.id,
    required this.name,
    required this.raffle,
    required this.quantity,
    required this.name,
    this.description,
  });
  late final String id;
  late final String name;
  late final Raffle raffle;
  late final String? description;
  late final int quantity;
  late final String name;

  Lot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    raffle = Raffle.fromJson(json['raffle']);
    description = json['description'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['raffle_id'] = raffle.id;
    data['description'] = description;
    data['quantity'] = quantity;
    return data;
  }

  Lot copyWith({
    String? id,
    String? name,
    Raffle? raffle,
    String? description,
    int? quantity,
  }) =>
      Lot(
        id: id ?? this.id,
        name: name ?? this.name,
        raffle: raffle ?? this.raffle,
        description: description,
        quantity: quantity ?? this.quantity,
      );

  Lot.empty() {
    id = '';
    name = '';
    raffle = Raffle.empty();
    description = null;
    quantity = 0;
  }

  @override
  String toString() {
    return 'Lot{id: $id, name: $name, raffle: $raffle, description: $description, quantity: $quantity}';
  }
}
