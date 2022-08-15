import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/groups/class/group.dart';
import 'package:myecl/groups/repositories/group_repository.dart';
import 'package:myecl/tools/providers/list_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

class GroupListProvider extends ListProvider<Group> {
  final GroupRepository _groupRepository = GroupRepository();
  GroupListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _groupRepository.setToken(token);
  }

  Future<AsyncValue<List<Group>>> loadGroups() async {
    return await loadList(_groupRepository.getGroupList);
  }

  Future<AsyncValue<List<Group>>> loadGroupsFromUser(User user) async {
    return await loadList(() async {
      return user.groups;
    });
  }

  Future<bool> createGroup(Group group) async {
    return await add(_groupRepository.createGroup, group);
  }

  Future<bool> updateGroup(Group group) async {
    return await update(_groupRepository.updateGroup, group);
  }

  Future<bool> deleteGroup(Group group) async {
    return await delete(_groupRepository.deleteGroup, group.id, group);
  }
}

final allGroupListProvider =
    StateNotifierProvider<GroupListProvider, AsyncValue<List<Group>>>((ref) {
  final token = ref.watch(tokenProvider);
  GroupListProvider provider = GroupListProvider(token: token);
  provider.loadGroups();
  return provider;
});

final userGroupListProvider =
    StateNotifierProvider<GroupListProvider, AsyncValue<List<Group>>>((ref) {
  final token = ref.watch(tokenProvider);
  GroupListProvider provider = GroupListProvider(token: token);
  provider.loadGroupsFromUser(ref.watch(userProvider));
  return provider;
});
