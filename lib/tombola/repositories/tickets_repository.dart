import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tools/repository/repository.dart';

class TicketRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/tickets";

  Future<List<Ticket>> getTicketsListbyRaffleId(String raffleId) async {
    return List<Ticket>.from(
        (await getList(suffix: "/$raffleId/")).map((x) => Ticket.fromJson(x)));
  }

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

  Future<Ticket> buyTicket(Ticket ticket, String userId) async {
    return Ticket.fromJson(
        await create(ticket, suffix: "/buy/${ticket.typeTicket.id}"));
  }
}
