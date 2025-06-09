import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/class/tickets.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserDetailRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/users";

  UserDetailRepository(super.ref);

  Future<List<Ticket>> getTicketsListByUserId(String userId) async {
    return List<Ticket>.from(
      (await getList(
        suffix: "/$userId/tickets",
      )).map((x) => Ticket.fromJson(x)),
    );
  }

  Future<List<Prize>> getLotListByUserId(String userId) async {
    return List<Prize>.from(
      (await getList(suffix: "/$userId/lot")).map((x) => Prize.fromJson(x)),
    );
  }
}

final userDetailRepositoryProvider = Provider<UserDetailRepository>((ref) {
  return UserDetailRepository(ref);
});
