import 'package:myecl/purchases/class/ticket_information.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScannerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/products/";

  Future<TicketInformation> scanTicket(
    String productId,
    String ticketSecret,
  ) async {
    return TicketInformation.fromJson(
      await getOne(productId, suffix: "/tickets/$ticketSecret"),
    );
  }

  Future<bool> consumeTicket(TicketInformation ticket, String tag) async {
    return await update(
      ticket.ticket.toJson(),
      ticket.ticket.id,
      suffix: "/tickets/${ticket.secret}",
    );
  }
}
