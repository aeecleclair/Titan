import 'package:titan/purchases/class/seller.dart';
import 'package:titan/purchases/class/ticket.dart';
import 'package:titan/tools/repository/repository.dart';

class UserInformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/users/me/";

  Future<List<Seller>> getSellerList() async {
    return List<Seller>.from(
      (await getList(suffix: "sellers/")).map((x) => Seller.fromJson(x)),
    );
  }

  Future<List<Ticket>> getTicketList() async {
    return List<Ticket>.from(
      (await getList(suffix: "tickets/")).map((x) => Ticket.fromJson(x)),
    );
  }

  Future<Ticket> getTicketQrCodeSecret(Ticket ticket) async {
    return ticket.copyWith(
      qrCodeSecret: (await getOne(
        "tickets/${ticket.id}",
        suffix: "/secret/",
      ))['qr_code_secret'],
    );
  }
}
