import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/admin/class/simple_group.dart';
import 'package:titan/admin/repositories/group_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/providers/user_provider.dart';

class GroupListNotifier extends ListNotifier<SimpleGroup> {
  final GroupRepository groupRepository;
  GroupListNotifier({required this.groupRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<SimpleGroup>>> loadGroups() async {
    return await loadList(groupRepository.getGroupList);
  }

  Future<AsyncValue<List<SimpleGroup>>> loadGroupsFromUser(User user) async {
    return await loadList(() async => user.groups);
  }

  Future<bool> createGroup(SimpleGroup group) async {
    return await add(groupRepository.createGroup, group);
  }

  Future<bool> updateGroup(SimpleGroup group) async {
    return await update(
      groupRepository.updateGroup,
      (groups, group) =>
          groups..[groups.indexWhere((g) => g.id == group.id)] = group,
      group,
    );
  }

  Future<bool> deleteGroup(SimpleGroup group) async {
    return await delete(
      groupRepository.deleteGroup,
      (groups, group) => groups..removeWhere((i) => i.id == group.id),
      group.id,
      group,
    );
  }

  void setGroup(SimpleGroup group) {
    state.whenData((d) {
      if (d.indexWhere((g) => g.id == group.id) == -1) return;
      state = AsyncValue.data(
        d..[d.indexWhere((g) => g.id == group.id)] = group,
      );
    });
  }
}

final allGroupListProvider =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<SimpleGroup>>>((
      ref,
    ) {
      final groupRepository = ref.watch(groupRepositoryProvider);
      GroupListNotifier provider = GroupListNotifier(
        groupRepository: groupRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadGroups();
      });
      return provider;
    });

final userGroupListNotifier =
    StateNotifierProvider<GroupListNotifier, AsyncValue<List<SimpleGroup>>>((
      ref,
    ) {
      final groupRepository = ref.watch(groupRepositoryProvider);
      GroupListNotifier provider = GroupListNotifier(
        groupRepository: groupRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        await provider.loadGroupsFromUser(ref.watch(userProvider));
      });
      return provider;
    });
