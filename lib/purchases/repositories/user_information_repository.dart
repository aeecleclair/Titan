import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserInformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/users/";

  Future<List<Purchase>> getPurchaseList() async {
    return List<Purchase>.from(
      (await getList(suffix: "me/purchases/")).map((x) => Purchase.fromJson(x)),
    );
  }

  Future<List<Seller>> getSellerList() async {
    return List<Seller>.from(
      (await getList(suffix: "me/sellers/")).map((x) => Seller.fromJson(x)),
    );
  }

  Future<List<Ticket>> getTicketList(String userId) async {
    return List<Ticket>.from(
      (await getList(suffix: "$userId/tickets/")).map((x) => Ticket.fromJson(x)),
    );
  }

  Future<Ticket> getTicketQrCodeSecret(Ticket ticket) async {
    String secret = (await getOne(
      "me/tickets/${ticket.id}",
      suffix: "/secret/",
    ))['qr_code_secret'];
    return ticket.copyWith(
      qrCodeSecret: secret,
    );
  }
}
