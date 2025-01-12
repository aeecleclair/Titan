import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/providers/page_provider.dart';
import 'package:myecl/CMM/repositories/cmm_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class CMMListNotifier extends ListNotifier<CMM> {
  final CMMRepository _cmmRepository = CMMRepository();
  CMMListNotifier({required String token}) : super(const AsyncLoading()) {
    _cmmRepository.setToken(token);
  }

  Future<AsyncValue<List<CMM>>> getCMM(int page) async {
    return await loadList(() async => _cmmRepository.getCMM(page));
  }

  Future<Uint8List> getCMMImage(String id) async {
    return await _cmmRepository.getCMMImage(id);
  }

  Future<bool> addVoteToCMM(CMM cmm, bool positive) async {
    return await _cmmRepository.addVoteToCMM(cmm, positive);
  }

  Future<bool> updateVoteToCMM(CMM cmm, bool positive) async {
    return await update(
      (cmm) => _cmmRepository.updateVoteToCMM(cmm, positive),
      (cmms, cmm) => cmms..[cmms.indexWhere((b) => b.id == cmm.id)] = cmm,
      cmm,
    );
  }
}

final cmmListProvider =
    StateNotifierProvider<CMMListNotifier, AsyncValue<List<CMM>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = CMMListNotifier(token: token);
  final page = ref.watch(pageProvider);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getCMM(page);
  });
  return notifier;
});
