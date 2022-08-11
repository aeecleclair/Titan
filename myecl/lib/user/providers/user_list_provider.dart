import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/repositories/user_list_repository.dart';

class UserListNotifier extends StateNotifier<AsyncValue<List<SimpleUser>>> {
  final UserListRepository _userListRepository = UserListRepository();
  UserListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _userListRepository.setToken(token);
  }

  Future<AsyncValue<List<SimpleUser>>> loadUserList() async {
    try {
      final userList = await _userListRepository.getAllUsers();
      state = AsyncValue.data(userList);
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<List<SimpleUser>>> filterUsers(String filter) async {
    return state.when(
      data: (userList) {
        final lowerQuery = filter.toLowerCase();
        return AsyncValue.data(userList
            .where((user) =>
                user.name.toLowerCase().contains(lowerQuery) ||
                user.firstname.toLowerCase().contains(lowerQuery) ||
                user.nickname.toLowerCase().contains(lowerQuery))
            .toList());
      },
      error: (e, s) {
        return AsyncValue.error(e);
      },
      loading: () {
        return const AsyncValue.loading();
      },
    );
  }
}

final userList =
    StateNotifierProvider<UserListNotifier, AsyncValue<List<SimpleUser>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    UserListNotifier userListNotifier = UserListNotifier(token: token);
    userListNotifier.loadUserList();
    return userListNotifier;
  },
);
