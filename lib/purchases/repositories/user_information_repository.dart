import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserInformationRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/users/me/";

  UserInformationRepository(super.ref);

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

final userInformationRepositoryProvider = Provider<UserInformationRepository>((
  ref,
) {
  final token = ref.watch(tokenProvider);
  return UserInformationRepository(ref)..setToken(token);
});
