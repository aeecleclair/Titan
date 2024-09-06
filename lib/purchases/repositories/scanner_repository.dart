import 'package:myecl/purchases/class/ticket_information.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScannerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/sellers/";

  Future<TicketInformation> scanTicket(
    String sellerId,
    String productId,
    String ticketSecret,
    String generatorId,
  ) async {
    return TicketInformation.fromJson(
      await getOne(productId,
          suffix:
              "$sellerId/products/$productId/tickets/$generatorId/$ticketSecret/"),
    );
  }

  Future<bool> consumeTicket(String sellerId, TicketInformation ticket,
      String generatorId, String tag) async {
    return await update(
      ticket.ticket.toJson(),
      ticket.ticket.id,
      suffix:
          "$sellerId/products/${ticket.ticket.productVariant.id}/tickets/$generatorId/${ticket.secret}/",
    );
  }
}
