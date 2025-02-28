import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/adapters/users.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/repositories/user_repository.dart';

class UserNotifier extends SingleNotifier2<CoreUser> {
  final Openapi userRepository;
  UserNotifier({required this.userRepository}) : super(const AsyncLoading());

  Future<AsyncValue<CoreUser>> loadUser(String userId) async {
    return await load(() async => userRepository.getUser(userId));
  }

  Future<AsyncValue<CoreUser>> loadMe() async {
    return await load(userRepository.getMe);
  }

  Future<bool> updateUser(CoreUser user) async {
    return await update(
        (user) => userRepository.updateUser(
            coreUserUpdateAdminAdapter(user), user.id),
        user);
  }

  Future<bool> updateMe(CoreUser user) async {
    return await update(
        (user) async => userRepository.updateMe(coreUserUpdateAdapter(user)),
        user);
  }

  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
    CoreUser user,
  ) async {
    return (await userRepository.changePassword(
          oldPassword,
      newPassword,
      user.email,
    ))
        .isSuccessful;
  }

  Future<bool> deletePersonal() async {
    return (await userRepository.deletePersonalData()).isSuccessful;
  }

  Future<bool> askMailMigration(String mail) async {
    return (await userRepository.askMailMigration(mail)).isSuccessful;
  }
}

final asyncUserProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<CoreUser>>((ref) {
  final token = ref.watch(tokenProvider);
  UserNotifier userNotifier = UserNotifier(userRepository: token);
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
});

final userProvider = Provider((ref) {
  return ref.watch(asyncUserProvider).maybeWhen(
        data: (user) => user,
        orElse: () {
          return User.empty();
        },
      );
});
