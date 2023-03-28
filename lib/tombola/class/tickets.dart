import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/type_ticket_simple.dart';
import 'package:myecl/user/class/list_users.dart';

class Ticket {
  Ticket({
    required this.typeTicket,
    required this.user,
    required this.lot,
    required this.id,
  });
  late final TypeTicketSimple typeTicket;
  late final SimpleUser user;
  late final Lot? lot;
  late final String id;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeTicket = TypeTicketSimple.fromJson(json['type_ticket']);
    user = SimpleUser.fromJson(json['user']);
    lot = json['lot'] != null ? Lot.fromJson(json['lot']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeTicket.id;
    data['user_id'] = user.id;
    data['lot'] = lot != null ? lot!.id : null;
    data['id'] = id;
    return data;
  }

  Ticket copyWith({
    TypeTicketSimple? typeTicket,
    SimpleUser? user,
    Lot? lot,
    String? id,
    int? unitPrice,
    int? nbTicket,
  }) =>
      Ticket(
          typeTicket: typeTicket ?? this.typeTicket,
          user: user ?? this.user,
          lot: lot,
          id: id ?? this.id,);

  Ticket.empty() {
    typeTicket = TypeTicketSimple.empty();
    user = SimpleUser.empty();
    lot = null;
    id = '';
  }

  @override
  String toString() {
    return 'Ticket(typeTicket: $typeTicket, user: $user, lot: $lot, id: $id)';
  }
}
