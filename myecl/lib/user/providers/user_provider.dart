import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/oauth2_provider.dart';
import 'package:myecl/tools/exception.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final UserRepository _userRepository = UserRepository();
  UserNotifier({required String token}) : super(const AsyncValue.loading()) {
    _userRepository.setToken(token);
  }

  Future<bool> setUser(User user) async {
    try {
      state = AsyncValue.data(user);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        state = AsyncValue.error(e);
        return false;
      }
    }
  }

  Future<bool> loadUser(String id) async {
    try {
      final user = await _userRepository.getUser(id);
      state = AsyncValue.data(user);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        state = AsyncValue.error(e);
        return false;
      }
    }
  }

  Future<bool> loadMe() async {
    try {
      final user = await _userRepository.getMe();
      state = AsyncValue.data(user);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        state = AsyncValue.error(e);
        return false;
      }
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user.id, user);
      state = AsyncValue.data(user);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        state = AsyncValue.error(e);
        return false;
      }
    }
  }

  Future<bool> updateMe(User user) async {
    try {
      await _userRepository.updateMe(user);
      state = AsyncValue.data(user);
      return true;
    } catch (e) {
      state = AsyncValue.error(e);
      if (e is AppException && e.type == ErrorType.tokenExpire) {
        rethrow;
      } else {
        state = AsyncValue.error(e);
        return false;
      }
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
