import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/raffle/";

  Future<List<TypeTicket>> getTypeTicketListFromRaffle(String raffleId) async {
    return List<TypeTicket>.from((await getList(suffix: "$raffleId/type-tickets"))
        .map((x) => TypeTicket.fromJson(x)));
  }

  
  Future<List<Ticket>> getTicketListFromRaffle(String raffleId) async {
    return List<Ticket>.from((await getList(suffix: "$raffleId/tickets"))
        .map((x) => Ticket.fromJson(x)));
  }

  Future<List<Lot>> getLotListFromRaffle(String raffleId) async {
    return List<Lot>.from((await getList(suffix: "$raffleId/lots"))
        .map((x) => Lot.fromJson(x)));
  }
}
