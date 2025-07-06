import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/providers/single_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/user/class/user.dart';
import 'package:titan/user/repositories/user_repository.dart';

class UserNotifier extends SingleNotifier<User> {
  final UserRepository userRepository;
  UserNotifier({required this.userRepository})
    : super(const AsyncValue.loading());

  Future<bool> setUser(User user) async {
    return await add((u) async => u, user);
  }

  Future<AsyncValue<User>> loadUser(String userId) async {
    return await load(() async => userRepository.getUser(userId));
  }

  Future<AsyncValue<User>> loadMe() async {
    return await load(userRepository.getMe);
  }

  Future<bool> updateUser(User user) async {
    return await update(userRepository.updateUser, user);
  }

  Future<bool> updateMe(User user) async {
    return await update(userRepository.updateMe, user);
  }

  Future<bool> deletePersonal() async {
    return await userRepository.deletePersonalData();
  }

  Future<bool> askMailMigration(String mail) async {
    return await userRepository.askMailMigration(mail);
  }
}

final asyncUserProvider = StateNotifierProvider<UserNotifier, AsyncValue<User>>(
  (ref) {
    final UserRepository userRepository = ref.watch(userRepositoryProvider);
    UserNotifier userNotifier = UserNotifier(userRepository: userRepository);
    final token = ref.watch(tokenProvider);
    tokenExpireWrapperAuth(ref, () async {
      final isLoggedIn = ref.watch(isLoggedInProvider);
      final id = ref
          .watch(idProvider)
          .maybeWhen(data: (value) => value, orElse: () => "");
      if (isLoggedIn && id != "" && token != "") {
        return userNotifier..loadMe();
      }
    });
    return userNotifier;
  },
);

final userProvider = Provider((ref) {
  return ref
      .watch(asyncUserProvider)
      .maybeWhen(
        data: (user) => user,
        orElse: () {
          return User.empty();
        },
      );
});
