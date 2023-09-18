import 'package:myecl/raffle/class/prize.dart';
import 'package:myecl/raffle/class/stats.dart';
import 'package:myecl/raffle/class/tickets.dart';
import 'package:myecl/raffle/class/type_ticket_simple.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleDetailRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/raffle/";

  Future<List<TypeTicketSimple>> getTypeTicketSimpleListFromRaffle(
      String raffleId) async {
    return List<TypeTicketSimple>.from(
        (await getList(suffix: "$raffleId/type_tickets"))
            .map((x) => TypeTicketSimple.fromJson(x)));
  }

  Future<List<Ticket>> getTicketListFromRaffle(String raffleId) async {
    return List<Ticket>.from((await getList(suffix: "$raffleId/tickets"))
        .map((x) => Ticket.fromJson(x)));
  }

  Future<List<Prize>> getLotListFromRaffle(String raffleId) async {
    return List<Prize>.from((await getList(suffix: "$raffleId/lots"))
        .map((x) => Prize.fromJson(x)));
  }

  Future<RaffleStats> getRaffleStats(String raffleId) async {
    return RaffleStats.fromJson(await getOne(raffleId, suffix: "/stats"));
  }
}
