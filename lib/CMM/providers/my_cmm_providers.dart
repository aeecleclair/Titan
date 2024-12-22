import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/repositories/my_cmm_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MyCMMListNotifier extends SingleNotifier<List<CMM>> {
  final MyCMMRepository _myCMMRepository = MyCMMRepository();
  MyCMMListNotifier({required String token}) : super(const AsyncLoading()) {
    _myCMMRepository.setToken(token);
  }

  Future<AsyncValue<List<CMM>>> getMyCMM() async {
    return await load(_myCMMRepository.getMyCMM);
  }
}

final userCMMScoreProvider =
    StateNotifierProvider<MyCMMListNotifier, AsyncValue<List<CMM>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MyCMMListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getMyCMM();
  });
  return notifier;
});
