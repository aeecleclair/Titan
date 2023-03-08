import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/raffles";

  Future<List<Raffle>> getRaffleList(raffleId) async {
    return List<Raffle>.from((await getList(suffix: "$raffleId/items"))
        .map((x) => Raffle.fromJson(x)));
  }

  Future<Raffle> getRaffle(String raffleId) async {
    return Raffle.fromJson(await getOne(raffleId, suffix: "/items"));
  }

  Future<Raffle> createRaffle(Raffle raffle) async {
    return Raffle.fromJson(await create(raffle.toJson()));
  }

  Future<bool> updateRaffle(Raffle raffle) async {
    return await update(raffle.toJson(), raffle.id);
  }

  Future<bool> deleteRaffle(String raffleId) async {
    return await delete(raffleId);
  }
}
