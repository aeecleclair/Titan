import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/list_notifier2.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/providers/user_provider.dart';

class GroupListNotifier extends ListNotifier2<CoreGroupSimple> {
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
        body: CoreGroupUpdate(
          name: group.name,
          description: group.description,
        ),
      ),
      (groups, group) =>
          groups..[groups.indexWhere((g) => g.id == group.id)] = group,
      group,
    );
  }

  Future<bool> deleteGroup(CoreGroupSimple group) async {
    return await delete(
      () => groupRepository.groupsGroupIdDelete(groupId: group.id),
      (groups, group) => groups..removeWhere((i) => i.id == group.id),
      group,
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
  GroupListNotifier provider =
      GroupListNotifier(groupRepository: groupRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadGroups();
  });
  return provider;
});

final userGroupListNotifier =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<CoreGroupSimple>>>(
        (ref) {
  final groupRepository = ref.watch(repositoryProvider);
  GroupListNotifier provider =
      GroupListNotifier(groupRepository: groupRepository);
  tokenExpireWrapperAuth(ref, () async {
    await provider.loadGroupsFromUser(ref.watch(userProvider));
  });
  return provider;
});
