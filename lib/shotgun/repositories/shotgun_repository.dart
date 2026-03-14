import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/tools/repository/repository.dart';

class ShotgunRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "shotgun/";

  Future<List<Shotgun>> getAllShotgun() async {
    return (await getList(suffix: '')).map((e) => Shotgun.fromJson(e)).toList();
  }

  Future<Shotgun> getShotgunById(String id) async {
    // return Shotgun.fromJson(await getOne(id));
    return Shotgun(
      id: id,
      date: DateTime.now(),
      prices: {"member": "10", "non_member": "20"},
    );
  }

  Future<Shotgun> addShotgun(Shotgun shotgun) async {
    return Shotgun.fromJson(await create(shotgun.toJson(), suffix: ''));
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
