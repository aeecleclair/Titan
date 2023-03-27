import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/user/class/list_users.dart';

class Ticket {
  Ticket({
    required this.typeTicket,
    required this.user,
    required this.winningLot,
    required this.id,
    required this.unitPrice,
    required this.nbTicket,
  });
  late final TypeTicket typeTicket;
  late final SimpleUser user;
  late final Lot? winningLot;
  late final String id;
  late final int unitPrice;
  late final int nbTicket;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeTicket = TypeTicket.fromJson(json['type_id']);
    user = SimpleUser.fromJson(json['user']);
    winningLot = json['winning_lot'] != null ? Lot.fromJson(json['winning_lot']) : null;
    id = json['id'];
    unitPrice = json['unit_rice'];
    nbTicket = json['nb_ticket'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeTicket.toJson();
    data['user_id'] = user.toJson();
    data['winning_lot'] = winningLot != null ? winningLot!.toJson() : null;
    data['id'] = id;
    data['unitPrice'] = unitPrice;
    data['nb_ticket'] = nbTicket;
    return data;
  }

  Ticket copyWith({
    TypeTicket? typeTicket,
    SimpleUser? user,
    Lot? winningLot,
    String? id,
    int? unitPrice,
    int? nbTicket,
  }) =>
      Ticket(
          typeTicket: typeTicket ?? this.typeTicket,
          user: user ?? this.user,
          winningLot: winningLot,
          id: id ?? this.id,
          unitPrice: unitPrice ?? this.unitPrice,
          nbTicket: nbTicket ?? this.nbTicket);

  Ticket.empty() {
    typeTicket = TypeTicket.empty();
    user = SimpleUser.empty();
    winningLot = null;
    id = '';
    unitPrice = 0;
    nbTicket = 0;
  }

  @override
  String toString() {
    return 'Ticket(typeTicket: $typeTicket, user: $user, winningLot: $winningLot, id: $id, unitPrice: $unitPrice, nbTicket: $nbTicket)';
  }
}
