import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/class/contender.dart';
import 'package:myecl/vote/providers/contender_list_provider.dart';

class ContenderLogoNotifier extends MapNotifier<Contender, Image> {
  ContenderLogoNotifier() : super();
}

final contenderLogosProvider = StateNotifierProvider<ContenderLogoNotifier,
    AsyncValue<Map<Contender, AsyncValue<List<Image>>>>>((ref) {
  ContenderLogoNotifier contenderLogoNotifier =
      ContenderLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(contenderListProvider).when(data: (contender) {
      contenderLogoNotifier.loadTList(contender);
      for (final l in contender) {
        contenderLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return contenderLogoNotifier;
    }, error: (error, stackTrace) {
      contenderLogoNotifier.loadTList([]);
      return contenderLogoNotifier;
    }, loading: () {
      contenderLogoNotifier.loadTList([]);
      return contenderLogoNotifier;
    });
  });
  return contenderLogoNotifier;
});
