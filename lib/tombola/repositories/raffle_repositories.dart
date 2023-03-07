import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "raffles";

  Future<List<Raffle>> getRaffleList(raffleId) async {
    return List<Raffle>.from((await getList(suffix: "$raffleId/items"))
        .map((x) => Raffle.fromJson(x)));
  }
}
