import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ShotgunListNotifier extends ListNotifier<Shotgun> {
  final ShotgunRepository _shotgunRepository = ShotgunRepository();
  ShotgunListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _shotgunRepository.setToken(token);
  }

  Future<AsyncValue<List<Shotgun>>> loadShotgunList() async {
    return await loadList(() async => _shotgunRepository.getAllShotgun());
  }

  Future<Shotgun> loadShotgunById(String id) async {
    return await _shotgunRepository.getShotgunById(id);
  }

  Future<bool> addShotgun(Shotgun shotgun) async {
    return await add(_shotgunRepository.addShotgun, shotgun);
  }

  Future<bool> editShotgun(Shotgun shotgun) async {
    return await delete(
      _shotgunRepository.deleteShotgun,
      (shotguns, shotgun) =>
          shotguns..removeWhere((toCheck) => toCheck.id == shotgun.id),
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
      final notifier = ShotgunListNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadShotgunList();
      });
      return notifier;
    });
