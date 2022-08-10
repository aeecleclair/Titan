import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final UserRepository _userRepository = UserRepository();
  UserNotifier({required String token}) : super(const AsyncValue.loading()) {
    _userRepository.setToken(token);
  }

  void setUser(User user) {
    try {
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void loadUser(String id) async {
    try {
      final user = await _userRepository.getUser(id);
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  void updateUser(User user) async {
    try {
      if (await _userRepository.updateUser(user.id, user)) {
        state = AsyncValue.data(user);
      } else {
        state = AsyncValue.error(Exception("Failed to update user"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }
}

final asyncUserProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final id = ref.watch(idProvider);
  final token = ref.watch(tokenProvider);
  UserNotifier userNotifier = UserNotifier(token: token);
  if (isLoggedIn && id != null) {
    return userNotifier..loadUser(id);
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
