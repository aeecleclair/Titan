import 'package:myecl/tombola/class/prize.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tools/repository/repository.dart';

class LotRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/prizes";

  Future<List<Prize>> getLotList(String raffle) async {
    return List<Prize>.from((await getList()).map((x) => Prize.fromJson(x)));
  }

  Future<Prize> getLot(String userId) async {
    return Prize.fromJson(await getOne(userId, suffix: "/lot"));
  }

  Future<Prize> createLot(Prize prize) async {
    return Prize.fromJson(await create(prize.toJson()));
  }

  Future<bool> updatePrize(Prize prize) async {
    return await update(prize.toJson(), "/${prize.id}");
  }

  Future<bool> deletePrize(String prizeId) async {
    return await delete("/$prizeId");
  }

  Future<List<Ticket>> drawPrize(Prize prize) async {
    return List<Ticket>.from(
        (await create(prize.toJson(), suffix: "/${prize.id}/draw"))
            .map((x) => Ticket.fromJson(x)));
  }
}
