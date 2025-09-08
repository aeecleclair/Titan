import 'package:titan/raffle/class/prize.dart';
import 'package:titan/raffle/class/tickets.dart';
import 'package:titan/tools/repository/repository.dart';

class LotRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/lots";

  Future<List<Prize>> getLotList(String raffle) async {
    return List<Prize>.from((await getList()).map((x) => Prize.fromJson(x)));
  }

  Future<Prize> getLot(String userId) async {
    return Prize.fromJson(await getOne(userId, suffix: "/lot"));
  }

  Future<Prize> createLot(Prize lot) async {
    return Prize.fromJson(await create(lot.toJson()));
  }

  Future<bool> updateLot(Prize lot) async {
    return await update(lot.toJson(), "/${lot.id}");
  }

  Future<bool> deleteLot(String lotId) async {
    return await delete("/$lotId");
  }

  Future<List<Ticket>> drawLot(Prize lot) async {
    return List<Ticket>.from(
      (await create(
        lot.toJson(),
        suffix: "/${lot.id}/draw",
      )).map((x) => Ticket.fromJson(x)),
    );
  }
}
