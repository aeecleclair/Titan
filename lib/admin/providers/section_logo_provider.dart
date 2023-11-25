import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class CoreGroupSimpleLogoNotifier extends MapNotifier<CoreGroupSimple, Image> {
  CoreGroupSimpleLogoNotifier() : super();
}

final allGroupLogosProvider = StateNotifierProvider<CoreGroupSimpleLogoNotifier,
    AsyncValue<Map<CoreGroupSimple, AsyncValue<List<Image>>>>>((ref) {
  CoreGroupSimpleLogoNotifier coreGroupSimpleLogoNotifier = CoreGroupSimpleLogoNotifier();
  tokenExpireWrapperAuth(ref, () async {
    ref.watch(allGroupListProvider).when(data: (allGroup) {
      coreGroupSimpleLogoNotifier.loadTList(allGroup);
      for (final l in allGroup) {
        coreGroupSimpleLogoNotifier.setTData(l, const AsyncValue.data([]));
      }
      return coreGroupSimpleLogoNotifier;
    }, error: (error, stackTrace) {
      coreGroupSimpleLogoNotifier.loadTList([]);
      return coreGroupSimpleLogoNotifier;
    }, loading: () {
      coreGroupSimpleLogoNotifier.loadTList([]);
      return coreGroupSimpleLogoNotifier;
    });
  });
  return coreGroupSimpleLogoNotifier;
});
