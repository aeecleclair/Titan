import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';
import 'package:myecl/user/class/list_users.dart';

class Ticket {
  Ticket({
    required this.typeTicket,
    required this.user,
    required this.prize,
    required this.id,
  });
  late final TypeTicketSimple typeTicket;
  late final SimpleUser user;
  late final Prize? prize;
  late final String id;

  Ticket.fromJson(Map<String, dynamic> json) {
    typeTicket = TypeTicketSimple.fromJson(json['type_ticket']);
    user = SimpleUser.fromJson(json['user']);
    prize = json['lot'] != null ? Prize.fromJson(json['lot']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = typeTicket.id;
    data['user_id'] = user.id;
    data['lot'] = prize != null ? prize!.id : null;
    data['id'] = id;
    return data;
  }

  Ticket copyWith({
    TypeTicketSimple? typeTicket,
    SimpleUser? user,
    Prize? lot,
    String? id,
  }) =>
      Ticket(
          typeTicket: typeTicket ?? this.typeTicket,
          user: user ?? this.user,
          prize: lot,
          id: id ?? this.id,);

  Ticket.empty() {
    typeTicket = TypeTicketSimple.empty();
    user = SimpleUser.empty();
    prize = null;
    id = '';
  }

  @override
  String toString() {
    return 'Ticket(typeTicket: $typeTicket, user: $user, lot: $prize, id: $id)';
  }
}
