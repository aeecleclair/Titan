import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class ScannerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/sellers/";

  Future<Ticket> scanTicket(
    String sellerId,
    String productId,
    String ticketSecret,
    String generatorId,
  ) async {
    return Ticket.fromJson(
      await getOne(
        "",
        suffix:
            "$sellerId/products/$productId/tickets/$generatorId/$ticketSecret/",
      ),
    );
  }

  Future<bool> consumeTicket(
    String sellerId,
    Ticket ticket,
    String generatorId,
    String tag,
  ) async {
    return await update(
      {"tag": tag},
      "",
      suffix:
          "$sellerId/products/${ticket.productVariant.productId}/tickets/$generatorId/${ticket.qrCodeSecret}/",
    );
  }
}
