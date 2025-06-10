import 'package:titan/raffle/class/pack_ticket.dart';
import 'package:titan/raffle/class/prize.dart';
import 'package:titan/user/class/simple_users.dart';

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
    packTicket = PackTicket.fromJson(json['type_ticket']);
    user = SimpleUser.fromJson(json['user']);
    prize = json['lot'] != null ? Prize.fromJson(json['lot']) : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type_id'] = packTicket.id;
    data['user_id'] = user.id;
    data['lot'] = prize?.id;
    data['id'] = id;
    return data;
  }

  Ticket copyWith({
    PackTicket? packTicket,
    SimpleUser? user,
    Prize? lot,
    String? id,
  }) => Ticket(
    packTicket: packTicket ?? this.packTicket,
    user: user ?? this.user,
    prize: lot,
    id: id ?? this.id,
  );

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
