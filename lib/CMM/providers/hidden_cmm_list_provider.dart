import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/repositories/hidden_cmm_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class HiddenCMMListNotifier extends ListNotifier<CMM> {
  final HiddenCMMRepository _hiddenCMMRepository = HiddenCMMRepository();

  HiddenCMMListNotifier({required String token}) : super(const AsyncLoading()) {
    _hiddenCMMRepository.setToken(token);
  }

  Future<AsyncValue<List<CMM>>> getHiddenCMM(int page) async {
    return await loadList(() async => _hiddenCMMRepository.getBannedCMM(page));
  }

  Future<bool> hideCMM(String id) async {
    return await _hiddenCMMRepository.hideCMM(id);
  }

  Future<bool> showCMM(String id) async {
    return await _hiddenCMMRepository.showCMM(id);
  }
}

final hiddenCMMProvider =
    StateNotifierProvider<HiddenCMMListNotifier, AsyncValue<List<CMM>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = HiddenCMMListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getHiddenCMM(1);
  });
  return notifier;
});
