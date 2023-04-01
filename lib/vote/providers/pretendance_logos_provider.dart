import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/pretendance.dart';
import 'package:myecl/vote/providers/pretendance_list_provider.dart';

class PretendanceLogoNotifier extends MapNotifier<Pretendance, Image> {
  PretendanceLogoNotifier() : super();
}

final pretendanceLogosProvider = StateNotifierProvider<PretendanceLogoNotifier,
    AsyncValue<Map<Pretendance, AsyncValue<List<Image>>>>>((ref) {
  PretendanceLogoNotifier pretendanceLogoNotifier =
      PretendanceLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(pretendanceListProvider).when(data: (pretendance) {
      pretendanceLogoNotifier.loadTList(pretendance);
      for (final l in pretendance) {
        pretendanceLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return pretendanceLogoNotifier;
    }, error: (error, stackTrace) {
      pretendanceLogoNotifier.loadTList([]);
      return pretendanceLogoNotifier;
    }, loading: () {
      pretendanceLogoNotifier.loadTList([]);
      return pretendanceLogoNotifier;
    });
  });
  return pretendanceLogoNotifier;
});
