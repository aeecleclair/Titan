import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/single_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/user/adapters/core_user.dart';

class UserNotifier extends SingleNotifierAPI<CoreUser> {
  Openapi get userRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<CoreUser> build() {
    final token = ref.watch(tokenProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final id = ref
        .watch(idProvider)
        .maybeWhen(data: (value) => value, orElse: () => "");
    if (isLoggedIn && id != "" && token != "") {
      loadMe();
    }
    return const AsyncValue.loading();
  }

  Future<AsyncValue<CoreUser>> loadUser(String userId) async {
    return await load(
      () async => userRepository.usersUserIdGet(userId: userId),
    );
  }

  Future<AsyncValue<CoreUser>> loadMe() async {
    return await load(userRepository.usersMeGet);
  }

  Future<bool> updateUser(CoreUser user) async {
    return await update(
      () => userRepository.usersUserIdPatch(
        body: user.toCoreUserUpdateAdmin(),
        userId: user.id,
      ),
      user,
    );
  }

  Future<bool> updateMe(CoreUser user) async {
    return await update(
      () async => userRepository.usersMePatch(body: user.toCoreUserUpdate()),
      user,
    );
  }

  Future<bool> changePassword(
    String oldPassword,
    String newPassword,
    CoreUser user,
  ) async {
    return (await userRepository.usersChangePasswordPost(
      body: ChangePasswordRequest(
        email: user.email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      ),
    )).isSuccessful;
  }

  Future<bool> deletePersonal() async {
    return await update(userRepository.usersMeAskDeletionPost, state.value!);
  }

  Future<bool> askMailMigration(String mail) async {
    return (await userRepository.usersMigrateMailPost(
      body: MailMigrationRequest(newEmail: mail),
    )).isSuccessful;
  }
}

final asyncUserProvider = NotifierProvider<UserNotifier, AsyncValue<CoreUser>>(
  UserNotifier.new,
);

final userProvider = Provider((ref) {
  return ref
      .watch(asyncUserProvider)
      .maybeWhen(
        data: (user) => user,
        orElse: () {
          return CoreUser.empty();
        },
      );
});
