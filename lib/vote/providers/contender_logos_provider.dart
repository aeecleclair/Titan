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
    AsyncValue<Map<Contender, AsyncValue<List<Image>>?>>>((ref) {
  ContenderLogoNotifier contenderLogoNotifier = ContenderLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(contenderListProvider).maybeWhen(data: (contender) {
      contenderLogoNotifier.loadTList(contender);
      return contenderLogoNotifier;
    }, orElse: () {
      contenderLogoNotifier.loadTList([]);
      return contenderLogoNotifier;
    });
  });
  return contenderLogoNotifier;
});
