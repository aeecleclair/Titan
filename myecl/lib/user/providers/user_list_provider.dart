import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';
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
      return state;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        state = AsyncValue.error(e);
        return state;
      }
    }
  }

  Future<AsyncValue<List<SimpleUser>>> filterUsers(String query) async {
    try {
      final userList = await _userListRepository.searchUser(query);
      return AsyncValue.data(userList);
    } catch (e) {
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        return AsyncValue.error(e);
      }
    }
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
