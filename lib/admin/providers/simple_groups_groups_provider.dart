import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/providers/group_list_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/map_provider.dart';

class SimpleGroupsGroupsNotifier extends MapNotifier<String, CoreGroup> {
  SimpleGroupsGroupsNotifier();
}

final simpleGroupsGroupsProvider = StateNotifierProvider<
    SimpleGroupsGroupsNotifier,
    Map<String, AsyncValue<List<CoreGroup>>?>>((ref) {
  SimpleGroupsGroupsNotifier simpleGroupsGroupsNotifier =
      SimpleGroupsGroupsNotifier();
  final simpleGroups = ref.watch(allGroupListProvider);
  simpleGroups.whenData((value) {
    simpleGroupsGroupsNotifier.loadTList(value.map((e) => e.id).toList());
  });
  return simpleGroupsGroupsNotifier;
});
