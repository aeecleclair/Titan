import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class SimpleGroupLogoNotifier extends MapNotifier<SimpleGroup, Image> {
  SimpleGroupLogoNotifier({required String token}) : super(token: token);
}

final allgroupLogosProvider = StateNotifierProvider<SimpleGroupLogoNotifier,
    AsyncValue<Map<SimpleGroup, AsyncValue<List<Image>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  SimpleGroupLogoNotifier simpleGroupLogoNotifier =
      SimpleGroupLogoNotifier(token: token);
  ref.watch(allGroupListProvider).when(data: (allgroup) {
    simpleGroupLogoNotifier.loadTList(allgroup);
    for (final l in allgroup) {
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
  return simpleGroupLogoNotifier;
});
