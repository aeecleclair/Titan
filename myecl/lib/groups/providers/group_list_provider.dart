import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/groups/class/group.dart';
import 'package:myecl/groups/repositories/group_repository.dart';

class GroupListProvider extends StateNotifier<AsyncValue<List<Group>>> {
  final GroupRepository _groupRepository = GroupRepository();
  GroupListProvider() : super(const AsyncValue.loading());

  Future<AsyncValue<List<Group>>> loadGroups() async {
    try {
      final groups = await _groupRepository.getAllGroups();
      state = AsyncValue.data(groups);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<bool> createGroup(Group group) async {
    return state.when(
      data: (groups) async {
        try {
          await _groupRepository.createGroup(group);
          groups.add(group);
          state = AsyncValue.data(groups);
          return true;
        } catch (e) {
          state = AsyncValue.data(groups);
          return false;
        }
      },
      error: (e, s) {
        state = AsyncValue.error(e);
        return false;
      },
      loading: () {
        state = const AsyncValue.loading();
        return false;
      },
    );
  }

  Future<bool> updateGroup(Group group) async {
    return state.when(
      data: (groups) async {
        try {
          await _groupRepository.updateGroup(group);
          var index = groups.indexWhere((p) => p.id == group.id);
          groups [index] = group;
          state = AsyncValue.data(groups);
          return true;
        } catch (e) {
          state = AsyncValue.data(groups);
          return false;
        }
      },
      error: (e, s) {
        state = AsyncValue.error(e);
        return false;
      },
      loading: () {
        state = const AsyncValue.loading();
        return false;
      },
    );
  }

  Future<bool> deleteGroup(Group group) async {
    return state.when(
      data: (groups) async {
        try {
          await _groupRepository.deleteGroup(group.id);
          groups.removeWhere((e) => e.id == group.id);
          state = AsyncValue.data(groups);
          return true;
        } catch (e) {
          state = AsyncValue.data(groups);
          return false;
        }
      },
      error: (e, s) {
        state = AsyncValue.error(e);
        return false;
      },
      loading: () {
        state = const AsyncValue.loading();
        return false;
      },
    );
  }
}

final groupListProvider = StateNotifierProvider((ref) {
  GroupListProvider provider = GroupListProvider();
  provider.loadGroups();
  return provider;
});