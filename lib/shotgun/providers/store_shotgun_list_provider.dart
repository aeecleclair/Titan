import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class StoreShotgunListNotifier extends ListNotifier<Shotgun> {
  final ShotgunRepository shotgunRepository;
  StoreShotgunListNotifier({required this.shotgunRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Shotgun>>> loadStoreShotgunList(String storeId) async {
    return await loadList(
      () => shotgunRepository.getShotgunListByStoreId(storeId),
    );
  }
}

final storeShotgunListProvider =
    StateNotifierProvider<StoreShotgunListNotifier, AsyncValue<List<Shotgun>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final shotgunRepository = ShotgunRepository()..setToken(token);
      return StoreShotgunListNotifier(shotgunRepository: shotgunRepository);
    });
