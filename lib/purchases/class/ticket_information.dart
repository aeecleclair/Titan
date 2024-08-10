import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/user/class/user.dart';

class TicketInformation {
  TicketInformation({
    required this.ticket,
    required this.user,
    this.secret = "",
  });

  late final Ticket ticket;
  late final User user;
  late final String secret;

  TicketInformation.fromJson(Map<String, dynamic> json) {
    ticket = Ticket.fromJson(json['ticket']);
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'ticket': ticket.toJson(),
      'user': user.toJson(),
    };
    return data;
  }

  TicketInformation copyWith({
    Ticket? ticket,
    User? user,
    String? secret,
  }) {
    return TicketInformation(
      ticket: ticket ?? this.ticket,
      user: user ?? this.user,
      secret: secret ?? this.secret,
    );
  }

  TicketInformation.empty() {
    ticket = Ticket.empty();
    user = User.empty();
    secret = "";
  }

  @override
  String toString() {
    return 'TicketInformation(ticket: $ticket, user: $user, secret: $secret)';
  }
}
