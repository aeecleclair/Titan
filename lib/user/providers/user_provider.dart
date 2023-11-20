import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/adapters/users.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository2.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserNotifier extends SingleNotifier2<CoreUser> {
  final Openapi _userRepository;
  UserNotifier({required String token})
      : _userRepository = getRepository(token),
        super(const AsyncLoading());

  Future<AsyncValue<CoreUser>> loadUser(String userId) async {
    return await load(
        () async => _userRepository.usersUserIdGet(userId: userId));
  }

  Future<AsyncValue<CoreUser>> loadMe() async {
    return await load(_userRepository.usersMeGet);
  }

  Future<bool> updateUser(CoreUser user) async {
    return await update(
        (user) => _userRepository.usersUserIdPatch(
            body: coreUserUpdateAdminAdapter(user), userId: user.id),
        user);
  }

  Future<bool> updateMe(CoreUser user) async {
    return await update(
        (user) async =>
            _userRepository.usersMePatch(body: coreUserUpdateAdapter(user)),
        user);
  }

  Future<bool> changePassword(
      String oldPassword, String newPassword, CoreUser user) async {
    return (await _userRepository.usersChangePasswordPost(
            body: ChangePasswordRequest(
                oldPassword: oldPassword,
                newPassword: newPassword,
                email: user.email)))
        .isSuccessful;
  }

  Future<bool> deletePersonal() async {
    return (await _userRepository.usersMeAskDeletionPost()).isSuccessful;
  }

  Future<bool> askMailMigration(String mail) async {
    return (await _userRepository.usersMigrateMailPost(
            body: MailMigrationRequest(newEmail: mail)))
        .isSuccessful;
  }
}

final asyncUserProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<CoreUser>>((ref) {
  final token = ref.watch(tokenProvider);
  UserNotifier userNotifier = UserNotifier(token: token);
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
