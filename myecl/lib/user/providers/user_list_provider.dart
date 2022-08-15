import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/user/class/list_users.dart';
import 'package:myecl/user/repositories/user_list_repository.dart';

class UserListNotifier extends ListNotifier<SimpleUser> {
  final UserListRepository _userListRepository = UserListRepository();
  UserListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _userListRepository.setToken(token);
  }

  Future<AsyncValue<List<SimpleUser>>> filterUsers(String query) async {
    return await loadList(() async => _userListRepository.searchUser(query));
  }
}

final userList =
    StateNotifierProvider<UserListNotifier, AsyncValue<List<SimpleUser>>>(
  (ref) {
    final token = ref.watch(tokenProvider);
    UserListNotifier userListNotifier = UserListNotifier(token: token);
    userListNotifier.filterUsers("");
    return userListNotifier;
  },
);
