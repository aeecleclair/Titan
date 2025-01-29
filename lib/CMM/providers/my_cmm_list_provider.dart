import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/repositories/my_cmm_repository.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class MyCMMListNotifier extends ListNotifier<CMM> {
  final MyCMMRepository _myCMMRepository = MyCMMRepository();
  MyCMMListNotifier({required String token}) : super(const AsyncLoading()) {
    _myCMMRepository.setToken(token);
  }

  Future<AsyncValue<List<CMM>>> getMyCMM(int page, int pagesize) async {
    return await loadList(
      () async => _myCMMRepository.getMyCMM(page, pagesize),
    );
  }

  Future<bool> addCMM(Uint8List bytes) async {
    final success = await _myCMMRepository.addCMM(bytes);
    return success;
  }
}

final myCMMListProvider =
    StateNotifierProvider<MyCMMListNotifier, AsyncValue<List<CMM>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = MyCMMListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.getMyCMM(0, 0);
  });
  return notifier;
});
