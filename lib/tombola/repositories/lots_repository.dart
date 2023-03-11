import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tools/repository/repository.dart';

class LotRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/lots/";

  Future<List<Lot>> getLotList() async {
    return List<Lot>.from(
        (await getList()).map((x) => Lot.fromJson(x)));
  }

  Future<List<Lot>> getLotListbyRaffle(String raffleId) async {
    return List<Lot>.from(
        (await getList(suffix: "$raffleId/")).map((x) => Lot.fromJson(x)));
  }

  Future<Lot> getLot(String userId) async {
    return Lot.fromJson(await getOne(userId, suffix: "/Lot"));
  }

  Future<Lot> createLot(Lot lot) async {
    return Lot.fromJson(await create(lot.toJson()));
  }

  Future<bool> updateLot(Lot lot) async {
    return await update(lot.toJson(), lot.id);
  }

  Future<bool> deleteLot(String lotId) async {
    return await delete(lotId);
  }
}
