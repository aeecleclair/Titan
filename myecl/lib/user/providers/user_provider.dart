import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/user/class/user.dart';
import 'package:myecl/user/providers/user_id_provider.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class UserNotifier extends StateNotifier<AsyncValue<User>> {
  final UserRepository _userRepository = UserRepository();
  User lastLoadedUser = User.empty();
  UserNotifier() : super(const AsyncValue.loading());

  void setUser(User user) {
    try {
      state = AsyncValue.data(user);
      lastLoadedUser = user;
    } catch (e) {
      state = AsyncValue.error(e);
    }
  }

  Future<AsyncValue<User>> loadUser(String id) async {
    try {
      final user = await _userRepository.getUser(id);
      state = AsyncValue.data(user);
      lastLoadedUser = user;
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }

  Future<AsyncValue<User>> updateUser(User user) async {
    try {
      if (await _userRepository.updateUser(user.id, user)) {
        state = AsyncValue.data(user);
        lastLoadedUser = user;
      } else {
        state = AsyncValue.error(Exception("Failed to update user"));
      }
    } catch (e) {
      state = AsyncValue.error(e);
    }
    return state;
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<User>>((ref) {
  UserNotifier _userNotifier = UserNotifier();
  _userNotifier.loadUser(ref.watch(userIdProvider));
  return _userNotifier;
});

