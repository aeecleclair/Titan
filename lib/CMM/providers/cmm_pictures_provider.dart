import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CMMPicturesNotifier extends MapNotifier<CMM, Image> {
  CMMPicturesNotifier() : super();
}

final cmmPicturesProvider = StateNotifierProvider<CMMPicturesNotifier,
    Map<CMM, AsyncValue<List<Image>>?>>((ref) {
  CMMPicturesNotifier cmmPicturesNotifier = CMMPicturesNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(cmmListProvider).maybeWhen(
      data: (cmm) {
        cmmPicturesNotifier.loadTList(cmm);
        return CMMPicturesNotifier;
      },
      orElse: () {
        cmmPicturesNotifier.loadTList([]);
        return cmmPicturesNotifier;
      },
    );
  });
  return cmmPicturesNotifier;
});
