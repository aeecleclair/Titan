import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class TicketRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/me/tickets/";

  Future<List<Ticket>> getTicketList() async {
    return List<Ticket>.from(
      (await getList()).map((x) => Ticket.fromJson(x)),
    );
  }

  Future<Ticket> getTicketQrCodeSecret(Ticket ticket) async {
    String secret =
        (await getOne(ticket.id, suffix: "/secret"))['qr_code_secret'];
    return ticket.copyWith(
      qrCodeSecret: secret,
    );
  }

  Future<bool> consumeTicket(Ticket ticket) async {
    return await update(
      ticket.toJson(),
      ticket.id,
    );
  }
}
