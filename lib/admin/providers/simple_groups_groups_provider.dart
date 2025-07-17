import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/tools/providers/map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class SimpleGroupsGroupsNotifier extends MapNotifier<String, Group> {
  SimpleGroupsGroupsNotifier();
}

final simpleGroupsGroupsProvider =
    StateNotifierProvider<
      SimpleGroupsGroupsNotifier,
      Map<String, AsyncValue<List<Group>>?>
    >((ref) {
      SimpleGroupsGroupsNotifier simpleGroupsGroupsNotifier =
          SimpleGroupsGroupsNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final simpleGroups = ref.watch(allGroupListProvider);
        simpleGroups.whenData((value) {
          simpleGroupsGroupsNotifier.loadTList(value.map((e) => e.id).toList());
        });
      });
      return simpleGroupsGroupsNotifier;
    });
