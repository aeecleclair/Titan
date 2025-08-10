import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/group.dart';
import 'package:titan/admin/providers/group_list_provider.dart';
import 'package:titan/tools/providers/single_map_provider.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class GroupFromSimpleGroupNotifier extends SingleMapNotifier<String, Group> {
  GroupFromSimpleGroupNotifier() : super();
}

final groupFromSimpleGroupProvider =
    StateNotifierProvider<
      GroupFromSimpleGroupNotifier,
      Map<String, AsyncValue<Group>?>
    >((ref) {
      GroupFromSimpleGroupNotifier groupFromSimpleGroupNotifier =
          GroupFromSimpleGroupNotifier();
      tokenExpireWrapperAuth(ref, () async {
        final simpleGroups = ref.watch(allGroupListProvider);
        simpleGroups.whenData((value) {
          groupFromSimpleGroupNotifier.loadTList(
            value.map((e) => e.id).toList(),
          );
        });
      });
      return groupFromSimpleGroupNotifier;
    });
