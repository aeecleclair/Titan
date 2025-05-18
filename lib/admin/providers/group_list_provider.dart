import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/providers/user_provider.dart';
import 'package:myecl/admin/adapters/groups.dart';

class GroupListNotifier extends ListNotifierAPI<CoreGroupSimple> {
  final Openapi groupRepository;
  GroupListNotifier({required this.groupRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<CoreGroupSimple>>> loadGroups() async {
    return await loadList(groupRepository.groupsGet);
  }

  Future<AsyncValue<List<CoreGroupSimple>>> loadGroupsFromUser(
    CoreUser user,
  ) async {
    return await loadFromList(user.groups);
  }

  Future<bool> createGroup(CoreGroupCreate group) async {
    return await add(() => groupRepository.groupsPost(body: group), group);
  }

  Future<bool> updateGroup(CoreGroupSimple group) async {
    return await update(
      () => groupRepository.groupsGroupIdPatch(
        groupId: group.id,
        body: group.toCoreGroupUpdate(),
      ),
      (g) => g.id,
      group,
    );
  }

  Future<bool> deleteGroup(String groupId) async {
    return await delete(
      () => groupRepository.groupsGroupIdDelete(groupId: groupId),
      (g) => g.id,
      groupId,
    );
  }

  void setGroup(CoreGroupSimple group) {
    state.whenData(
      (d) {
        if (d.indexWhere((g) => g.id == group.id) == -1) return;
        state =
            AsyncValue.data(d..[d.indexWhere((g) => g.id == group.id)] = group);
      },
    );
  }
}

final allGroupListProvider =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<CoreGroupSimple>>>(
        (ref) {
  final groupRepository = ref.watch(repositoryProvider);
  return GroupListNotifier(groupRepository: groupRepository)..loadGroups();
});

final userGroupListNotifier =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<CoreGroupSimple>>>(
        (ref) {
  final groupRepository = ref.watch(repositoryProvider);
  return GroupListNotifier(groupRepository: groupRepository)
    ..loadGroupsFromUser(ref.watch(userProvider));
});
