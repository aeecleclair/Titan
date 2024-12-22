import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/repositories/cmm_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CMMListNotifier extends SingleNotifier<List<CMM>> {
  final CMMRepository _CMMRepository = CMMRepository();
  CMMListNotifier({required String token}) : super(const AsyncLoading()) {
    _CMMRepository.setToken(token);
  }

  Future<AsyncValue<List<CMM>>> getCMM() async {
    return await load(_CMMRepository.getCMM);
  }
}

final cmmListProvider =
    StateNotifierProvider<CMMListNotifier, AsyncValue<List<CMM>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = CMMListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getCMM();
  });
  return notifier;
});
