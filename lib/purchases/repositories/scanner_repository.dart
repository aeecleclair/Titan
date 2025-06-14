import 'package:titan/purchases/class/ticket.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/class/simple_users.dart';

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

  Future<List<String>> getTags(
    String sellerId,
    String productId,
    String generatorId,
  ) async {
    return List<String>.from(
      await getList(suffix: "$sellerId/products/$productId/tags/$generatorId/"),
    ).where((tag) => tag.isNotEmpty).toList();
  }

  Future<List<SimpleUser>> getUsersList(
    String sellerId,
    String productId,
    String generatorId,
    String tag,
  ) async {
    return List<SimpleUser>.from(
      (await getList(
        suffix:
            "$sellerId/products/$productId/tickets/$generatorId/lists/$tag/",
      )).map((x) => SimpleUser.fromJson(x)),
    );
  }
}
