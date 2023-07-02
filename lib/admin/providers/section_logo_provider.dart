import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SimpleGroupLogoNotifier extends MapNotifier<SimpleGroup, Image> {
  SimpleGroupLogoNotifier() : super();
}

final allGroupLogosProvider = StateNotifierProvider<SimpleGroupLogoNotifier,
    AsyncValue<Map<SimpleGroup, AsyncValue<List<Image>>>>>((ref) {
  SimpleGroupLogoNotifier simpleGroupLogoNotifier =
      SimpleGroupLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(allGroupListProvider).when(data: (allGroup) {
      simpleGroupLogoNotifier.loadTList(allGroup);
      for (final l in allGroup) {
        simpleGroupLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return simpleGroupLogoNotifier;
    }, error: (error, stackTrace) {
      simpleGroupLogoNotifier.loadTList([]);
      return simpleGroupLogoNotifier;
    }, loading: () {
      simpleGroupLogoNotifier.loadTList([]);
      return simpleGroupLogoNotifier;
    });
  });
  return simpleGroupLogoNotifier;
});
