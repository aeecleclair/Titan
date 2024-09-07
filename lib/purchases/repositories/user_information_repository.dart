import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

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
    final json = await getList(suffix: "tickets/");
    print(json);
    final tickets = List<Ticket>.from(json.map((x) => Ticket.fromJson(x)));
    // final tickets = List<Ticket>.from(
    //   (await getList(suffix: "tickets/")).map((x) => Ticket.fromJson(x)),
    // );
    print(tickets);
    return tickets;
  }

  Future<Ticket> getTicketQrCodeSecret(Ticket ticket) async {
    String secret = (await getOne(
      "tickets/${ticket.id}",
      suffix: "/secret/",
    ))['qr_code_secret'];
    return ticket.copyWith(
      qrCodeSecret: secret,
    );
  }
}
