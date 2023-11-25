import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/adapters/users.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/user.dart';

class UserNotifier extends SingleNotifier2<CoreUser> {
  final Openapi userRepository;
  UserNotifier({required this.userRepository}) : super(const AsyncLoading());

  Future<AsyncValue<CoreUser>> loadUser(String userId) async {
    return await load(
        () async => userRepository.usersUserIdGet(userId: userId));
  }

  Future<AsyncValue<CoreUser>> loadMe() async {
    return await load(userRepository.usersMeGet);
  }

  Future<bool> updateUser(CoreUser user) async {
    return await update(
        (user) => userRepository.usersUserIdPatch(
            body: coreUserUpdateAdminAdapter(user), userId: user.id),
        user);
  }

  Future<bool> updateMe(CoreUser user) async {
    return await update(
        (user) async =>
            userRepository.usersMePatch(body: coreUserUpdateAdapter(user)),
        user);
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, CoreUser user) async {
    return (await userRepository.usersChangePasswordPost(
            body: ChangePasswordRequest(
                oldPassword: oldPassword,
                newPassword: newPassword,
                email: user.email)))
        .isSuccessful;
  }

  Future<bool> deletePersonal() async {
    return (await userRepository.usersMeAskDeletionPost()).isSuccessful;
  }

  Future<bool> askMailMigration(String mail) async {
    return (await userRepository.usersMigrateMailPost(
            body: MailMigrationRequest(newEmail: mail)))
        .isSuccessful;
  }
}

final asyncUserProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<CoreUser>>((ref) {
  final repository = ref.watch(repositoryProvider);
  UserNotifier userNotifier = UserNotifier(userRepository: repository);
  tokenExpireWrapperAuth(ref, () async {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final id = ref
        .watch(idProvider)
        .maybeWhen(data: (value) => value, orElse: () => "");
    if (isLoggedIn && id != "") {
      return userNotifier..loadMe();
    }
  });
  return userNotifier;
});

final userProvider = Provider<CoreUser>((ref) {
  return ref
      .watch(asyncUserProvider)
      .maybeWhen(data: (user) => user, orElse: () => CoreUser.fromJson({}));
});

final userProvider2 = Provider<User>((ref) {
  return ref.watch(asyncUserProvider).maybeWhen(
      data: (user) => User.fromCoreUser(user), orElse: () => User.empty());
});
