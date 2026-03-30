import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/category.dart';
import 'package:titan/shotgun/class/session.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/tools/repository/repository.dart';

class ShotgunRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "tickets/";

  Future<List<Shotgun>> getAllShotgun() async {
    return (await getList(
      suffix: 'events',
    )).map((e) => Shotgun.fromJson(e)).toList();
  }

  Future<Shotgun> getShotgunById(String id) async {
    return Shotgun(
      categories: [
        Category(id: "1", name: "Cotisant", price: 10),
        Category(id: "2", name: "Non cotisant", price: 20),
      ],
      sessions: [
        Session(
          id: "3",
          name: "Bus 1",
          startDatetime: DateTime.parse("2026-03-29T20:30:00Z"),
          quota: 10,
        ),
        Session(
          id: "4",
          name: "Bus 2",
          startDatetime: DateTime.parse("2026-03-29T21:00:00Z"),
          quota: 20,
        ),
      ],
      id: id,
      name: "",
      storeId: "",
      quota: 0,
      openDatetime: DateTime.now(),
      closeDatetime: DateTime.now(),
    );
    // return Shotgun.fromJson(await getOne(id));
  }

  Future<List<Shotgun>> getShotgunListByAssociationId(String id) async {
    return (await getList(
      suffix: 'admin/association/$id/events',
    )).map((e) => Shotgun.fromJson(e)).toList();
  }

  Future<Shotgun> createShotgun(Shotgun shotgun) async {
    return Shotgun.fromJson(
      await create(shotgun.toJson(), suffix: 'admin/events'),
    );
  }

  Future<bool> editShotgun(Shotgun shotgun) async {
    return await update(shotgun.toJson(), shotgun.id);
  }

  Future<bool> deleteShotgun(String id) async {
    return await delete(id);
  }
}

final shotgunRepositoryProvider = Provider<ShotgunRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return ShotgunRepository()..setToken(token);
});
