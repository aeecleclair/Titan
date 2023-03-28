import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/type_ticket_simple.dart';
import 'package:myecl/user/class/list_users.dart';

class Ticket {
  Ticket({
    required this.typeTicketSimple,
    required this.user,
    required this.winningLot,
    required this.id,
    required this.unitPrice,
    required this.nbTicket,
  });
  late final TypeTicketSimple typeTicketSimple;
  late final SimpleUser user;
  late final Lot? winningLot;
  late final String id;
  late final int unitPrice;
  late final int nbTicket;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeTicketSimple = TypeTicketSimple.fromJson(json['type_id']);
    user = SimpleUser.fromJson(json['user']);
    winningLot = json['winning_lot'] != null ? Lot.fromJson(json['winning_lot']) : null;
    id = json['id'];
    unitPrice = json['unit_rice'];
    nbTicket = json['nb_ticket'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeTicketSimple.toJson();
    data['user_id'] = user.toJson();
    data['winning_lot'] = winningLot != null ? winningLot!.toJson() : null;
    data['id'] = id;
    data['unitPrice'] = unitPrice;
    data['nb_ticket'] = nbTicket;
    return data;
  }

  Ticket copyWith({
    TypeTicketSimple? typeTicketSimple,
    SimpleUser? user,
    Lot? winningLot,
    String? id,
    int? unitPrice,
    int? nbTicket,
  }) =>
      Ticket(
          typeTicketSimple: typeTicketSimple ?? this.typeTicketSimple,
          user: user ?? this.user,
          winningLot: winningLot,
          id: id ?? this.id,
          unitPrice: unitPrice ?? this.unitPrice,
          nbTicket: nbTicket ?? this.nbTicket);

  Ticket.empty() {
    typeTicketSimple = TypeTicketSimple.empty();
    user = SimpleUser.empty();
    winningLot = null;
    id = '';
    unitPrice = 0;
    nbTicket = 0;
  }

  @override
  String toString() {
    return 'Ticket(typeTicketSimple: $typeTicketSimple, user: $user, winningLot: $winningLot, id: $id, unitPrice: $unitPrice, nbTicket: $nbTicket)';
  }
}
