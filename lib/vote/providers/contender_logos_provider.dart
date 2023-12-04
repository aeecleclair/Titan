import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/vote/providers/contender_list_provider.dart';

class ContenderLogoNotifier extends MapNotifier<ListReturn, Image> {
  ContenderLogoNotifier() : super();
}

final contenderLogosProvider = StateNotifierProvider<ContenderLogoNotifier,
    AsyncValue<Map<ListReturn, AsyncValue<List<Image>>>>>((ref) {
  ContenderLogoNotifier contenderLogoNotifier = ContenderLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(contenderListProvider).maybeWhen(data: (contender) {
      contenderLogoNotifier.loadTList(contender);
      for (final l in contender) {
        contenderLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return contenderLogoNotifier;
    }, orElse: () {
      contenderLogoNotifier.loadTList([]);
      return contenderLogoNotifier;
    });
  });
  return contenderLogoNotifier;
});
