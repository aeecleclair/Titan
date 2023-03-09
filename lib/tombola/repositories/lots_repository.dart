import 'package:myecl/tombola/class/lots.dart';
import 'package:myecl/tools/repository/repository.dart';

class LotRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tombola/lots/";

  Future<List<Lot>> getLotsList(String raffleId) async {
    return List<Lot>.from((await getList(suffix: "$raffleId/"))
        .map((x) => Lot.fromJson(x)));
  }

  Future<Lot> getLot(String id) async {
    return Lot.fromJson(await getOne(id));
  }

  Future<Lot> createLot(Lot lot) async {
    return Lot.fromJson(await create(lot.toJson()));
  }

  Future<bool> updateLot(Lot lot) async {
    return await update(lot.toJson(), "TODO");
  }

  Future<bool> deleteLot(String id) async {
    return await delete(id);
  }
}
