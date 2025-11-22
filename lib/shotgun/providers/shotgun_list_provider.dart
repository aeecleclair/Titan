import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ShotgunListNotifier extends ListNotifier<Shotgun> {
  ShotgunRepository repository = ShotgunRepository();
  ShotgunListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    repository.setToken(token);
  }

  Future<AsyncValue<List<Shotgun>>> loadShotguns() async {
    return await loadList(repository.getAllShotgun);
  }

  Future<bool> addShotgun(Shotgun shotgun) async {
    return await add(repository.addShotgun, shotgun);
  }

  Future<bool> updateShotgun(Shotgun shotgun) async {
    return await update(
      repository.updateShotgun,
      (shotguns, shotgun) =>
          shotguns..[shotguns.indexWhere((b) => b.id == shotgun.id)] = shotgun,
      shotgun,
    );
  }

  Future<bool> deleteShotgun(Shotgun shotgun) async {
    return await delete(
      repository.deleteShotgun,
      (shotguns, shotgun) => shotguns..removeWhere((b) => b.id == shotgun.id),
      shotgun.id,
      shotgun,
    );
  }
}

final shotgunListProvider =
    StateNotifierProvider<ShotgunListNotifier, AsyncValue<List<Shotgun>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      ShotgunListNotifier notifier = ShotgunListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadShotguns();
      });
      return notifier;
    });
