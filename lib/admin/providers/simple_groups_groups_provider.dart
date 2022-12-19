import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/group.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/map_provider.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class SimpleGroupsGroupsNotifier extends MapNotifier<String, Group> {
  SimpleGroupsGroupsNotifier({required super.token});
}

final simpleGroupsGroupsProvider = StateNotifierProvider<
    SimpleGroupsGroupsNotifier,
    AsyncValue<Map<String, AsyncValue<List<Group>>>>>((ref) {
  final token = ref.watch(tokenProvider);
  SimpleGroupsGroupsNotifier simpleGroupsGroupsNotifier =
      SimpleGroupsGroupsNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final simpleGroups = ref.watch(allGroupListProvider);
    simpleGroups.whenData((value) {
      simpleGroupsGroupsNotifier.loadTList(value.map((e) => e.id).toList());
    });
  });
  return simpleGroupsGroupsNotifier;
});
