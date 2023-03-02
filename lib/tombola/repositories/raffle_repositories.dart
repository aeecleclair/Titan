import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tools/repository/repository.dart';

class RaffleRepository extends Repository {
  @override
  Future<List<Raffle>> getRaffleList(raffleId) async {
    return List<Raffle>.from((await getList(suffix: "$raffleId/items")).map((x) => Raffle.fromJson(x)));
  }
}