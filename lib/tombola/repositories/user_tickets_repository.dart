import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserDetailRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/users";

  Future<List<Ticket>> getTicketsListbyUserId(String userId) async {
    print((await getList(suffix: "/$userId/tickets")));
    return List<Ticket>.from(
        (await getList(suffix: "/$userId/tickets")).map((x) => Ticket.fromJson(x)));
  }

  Future<List<Lot>> getLotListByUserId(String userId) async {
    return List<Lot>.from(
        (await getList(suffix: "/$userId/lot")).map((x) => Lot.fromJson(x)));
  }
}
