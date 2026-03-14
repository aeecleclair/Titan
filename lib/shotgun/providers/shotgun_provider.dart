import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/shotgun/class/shotgun.dart';
import 'package:titan/shotgun/repositories/shotgun_repository.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class ShotgunByIdNotifier extends StateNotifier<AsyncValue<Shotgun>> {
  ShotgunByIdNotifier({required String token, required String id})
    : _id = id,
      super(const AsyncValue.loading()) {
    _repository = ShotgunRepository()..setToken(token);
  }

  final String _id;
  late final ShotgunRepository _repository;

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final shotgun = await _repository.getShotgunById(_id);
      state = AsyncValue.data(shotgun);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final shotgunByIdProvider =
    StateNotifierProvider.family<
      ShotgunByIdNotifier,
      AsyncValue<Shotgun>,
      String
    >((ref, id) {
      final token = ref.watch(tokenProvider);
      final notifier = ShotgunByIdNotifier(token: token, id: id);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.load();
      });
      return notifier;
    });
