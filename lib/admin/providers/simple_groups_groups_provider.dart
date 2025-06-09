import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myemapp/admin/class/group.dart';
import 'package:myemapp/admin/providers/group_list_provider.dart';
import 'package:myemapp/tools/providers/map_provider.dart';
import 'package:myemapp/tools/token_expire_wrapper.dart';

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
