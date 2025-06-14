import 'package:titan/raffle/class/tickets.dart';
import 'package:titan/tools/repository/repository.dart';

class TicketRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/tickets";

  Future<Ticket> getTicket(String id) async {
    return Ticket.fromJson(await getOne("/$id"));
  }

  Future<Ticket> createTicket(Ticket ticket) async {
    return Ticket.fromJson(await create(ticket.toJson()));
  }

  Future<bool> updateTicket(Ticket ticket) async {
    return await update(ticket.toJson(), "/${ticket.id}");
  }

  Future<bool> deleteTicket(String id) async {
    return await delete("/$id");
  }

  Future<List<Ticket>> buyTicket(String typeTicketId, String userId) async {
    return List<Ticket>.from(
      (await create(
        {},
        suffix: "/buy/$typeTicketId",
      )).map((e) => Ticket.fromJson(e)),
    );
  }
}
