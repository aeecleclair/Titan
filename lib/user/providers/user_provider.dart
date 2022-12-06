import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/single_notifier.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class UserNotifier extends SingleNotifier<User> {
  final UserRepository _userRepository = UserRepository();
  UserNotifier({required String token}) : super(const AsyncValue.loading()) {
    _userRepository.setToken(token);
  }

  Future<bool> setUser(User user) async {
    return await add((u) async => u, user);
  }

  Future<AsyncValue<User>> loadUser(String userId) async {
    return await load(() async => _userRepository.getUser(userId));
  }

  Future<AsyncValue<User>> loadMe() async {
    return await load(_userRepository.getMe);
  }

  Future<bool> updateUser(User user) async {
    return await update(_userRepository.updateUser, user);
  }

  Future<bool> updateMe(User user) async {
    return await update(_userRepository.updateMe, user);
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, User user) async {
    return await _userRepository.changePassword(
        oldPassword, newPassword, user.id);
  }

  Future<bool> deletePersonal() async {
    return await _userRepository.deletePersonalData();
  }
}

final asyncUserProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final id = ref.watch(idProvider);
  final token = ref.watch(tokenProvider);
  UserNotifier userNotifier = UserNotifier(token: token);
  if (isLoggedIn && id != null) {
    return userNotifier..loadMe();
  }
  return userNotifier;
});

final userProvider = Provider((ref) {
  return ref.watch(asyncUserProvider).when(
    data: (user) {
      return user;
    },
    error: (e, s) {
      return User.empty();
    },
    loading: () {
      return User.empty();
    },
  );
});
