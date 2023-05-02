import 'package:myecl/tombola/class/prize.dart';
import 'package:myecl/tombola/class/pack_ticket.dart';
import 'package:myecl/user/class/list_users.dart';

class Ticket {
  Ticket({
    required this.packTicket,
    required this.user,
    required this.lot,
    required this.id,
  });
  late final PackTicket packTicket;
  late final SimpleUser user;
  late final Prize? lot;
  late final String id;

  Ticket.fromJson(Map<String, dynamic> json) {
    packTicket = PackTicket.fromJson(json['type_ticket']);
    user = SimpleUser.fromJson(json['user']);
    lot = json['lot'] != null ? Prize.fromJson(json['lot']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = packTicket.id;
    data['user_id'] = user.id;
    data['lot'] = lot != null ? lot!.id : null;
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
          lot: lot,
          id: id ?? this.id,);

  Ticket.empty() {
    packTicket = PackTicket.empty();
    user = SimpleUser.empty();
    lot = null;
    id = '';
  }

  @override
  String toString() {
    return 'Ticket(packTicket: $packTicket, user: $user, lot: $lot, id: $id)';
  }
}
