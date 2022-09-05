import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/admin/class/simple_group.dart';
import 'package:myecl/admin/repositories/group_repository.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_provider.dart';

class GroupListNotifier extends ListNotifier<SimpleGroup> {
  final GroupRepository _groupRepository = GroupRepository();
  GroupListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _groupRepository.setToken(token);
  }

  Future<AsyncValue<List<SimpleGroup>>> loadGroups() async {
    return await loadList(_groupRepository.getGroupList);
  }

  Future<AsyncValue<List<SimpleGroup>>> loadGroupsFromUser(User user) async {
    return await loadList(() async {
      return user.groups;
    });
  }

  Future<bool> createGroup(SimpleGroup group) async {
    return await add(_groupRepository.createGroup, group);
  }

  Future<bool> updateGroup(SimpleGroup group) async {
    return await update(
        _groupRepository.updateGroup,
        (groups, group) =>
            groups..[groups.indexWhere((g) => g.id == group.id)] = group,
        group);
  }

  Future<bool> deleteGroup(SimpleGroup group) async {
    return await delete(
        _groupRepository.deleteGroup,
        (groups, group) => groups..removeWhere((i) => i.id == group.id),
        group.id,
        group);
  }

  void setGroup(SimpleGroup group) {
    state.whenData(
      (d) {
        state =
            AsyncValue.data(d..[d.indexWhere((g) => g.id == group.id)] = group);
      },
    );
  }
}

final allGroupListProvider =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<SimpleGroup>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  GroupListNotifier provider = GroupListNotifier(token: token);
  provider.loadGroups();
  return provider;
});

final userGroupListNotifier =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<SimpleGroup>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  GroupListNotifier provider = GroupListNotifier(token: token);
  provider.loadGroupsFromUser(ref.watch(userProvider));
  return provider;
});
