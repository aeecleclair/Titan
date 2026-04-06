import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/checkout.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/tools/functions.dart';
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
    return Shotgun.fromJson(await getOne("admin/events/$id"));
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

  Future<Checkout> checkoutShotgun(Shotgun shotgun) async {
    return Checkout.fromJson(
      await create(
        checkoutFromShotgun(shotgun).toJson(),
        suffix: 'events/${shotgun.id}/checkout',
      ),
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
