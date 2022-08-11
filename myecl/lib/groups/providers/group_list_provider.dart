import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/groups/class/group.dart';
import 'package:myecl/groups/repositories/group_repository.dart';
import 'package:myecl/tools/exception.dart';

class GroupListProvider extends StateNotifier<AsyncValue<List<Group>>> {
  final GroupRepository _groupRepository = GroupRepository();
  GroupListProvider({required String token})
      : super(const AsyncValue.loading()) {
    _groupRepository.setToken(token);
  }

  Future<AsyncValue<List<Group>>> loadGroups() async {
    try {
      final groups = await _groupRepository.getAllGroups();
      state = AsyncValue.data(groups);
      return state;
    } catch (e) {
      state = AsyncValue.error(e);
      rethrow;
    }
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
        throw e as AppException;
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
          groups[index] = group;
          state = AsyncValue.data(groups);
          return true;
        } catch (e) {
          state = AsyncValue.data(groups);
          return false;
        }
      },
      error: (e, s) {
        state = AsyncValue.error(e);
        throw e as AppException;
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
        throw e as AppException;
      },
      loading: () {
        state = const AsyncValue.loading();
        return false;
      },
    );
  }
}

final groupListProvider = StateNotifierProvider((ref) {
  final token = ref.watch(tokenProvider);
  GroupListProvider provider = GroupListProvider(token: token);
  provider.loadGroups();
  return provider;
});
