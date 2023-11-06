import 'package:myecl/tombola/class/prize.dart';
import 'package:myecl/tombola/class/pack_ticket.dart';
import 'package:myecl/user/class/list_users.dart';

class Ticket {
  Ticket({
    required this.packTicket,
    required this.user,
    required this.prize,
    required this.id,
  });
  late final PackTicket packTicket;
  late final SimpleUser user;
  late final Prize? prize;
  late final String id;

  Ticket.fromJson(Map<String, dynamic> json) {
    packTicket = PackTicket.fromJson(json['pack_ticket']);
    user = SimpleUser.fromJson(json['user']);
    prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = packTicket.id;
    data['user_id'] = user.id;
    data['lot'] = prize != null ? prize!.id : null;
    data['id'] = id;
    return data;
  }

  Ticket copyWith({
    PackTicket? packTicket,
    SimpleUser? user,
    Prize? lot,
    String? id,
  }) =>
      Ticket(
          packTicket: packTicket ?? this.packTicket,
          user: user ?? this.user,
          prize: lot,
          id: id ?? this.id,);

  Ticket.empty() {
    packTicket = PackTicket.empty();
    user = SimpleUser.empty();
    prize = null;
    id = '';
  }

  @override
  String toString() {
    return 'Ticket(packTicket: $packTicket, user: $user, lot: $prize, id: $id)';
  }
}
