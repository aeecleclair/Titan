import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserTicketRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/users";

  Future<List<Ticket>> getTicketsListbyUserId(String userId) async {
    return List<Ticket>.from(
        (await getList(suffix: "/$userId/tickets")).map((x) => Ticket.fromJson(x)));
  }
}
