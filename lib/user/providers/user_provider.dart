import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/tools/builders/empty_models.dart';
import 'package:myecl/user/adapters/users.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier_api.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserNotifier extends SingleNotifierAPI<CoreUser> {
  final Openapi userRepository;
  UserNotifier({required this.userRepository}) : super(const AsyncLoading());

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
    ))
        .isSuccessful;
  }

  Future<bool> deletePersonal() async {
    return await delete(
      () => userRepository.usersMeAskDeletionPost(),
    );
  }

  Future<bool> askMailMigration(String mail) async {
    return (await userRepository.usersMigrateMailPost(
      body: MailMigrationRequest(newEmail: mail),
    ))
        .isSuccessful;
  }
}

final asyncUserProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<CoreUser>>((ref) {
  final userRepository = ref.watch(repositoryProvider);
  UserNotifier userNotifier = UserNotifier(userRepository: userRepository);
  final token = ref.watch(tokenProvider);
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final id =
      ref.watch(idProvider).maybeWhen(data: (value) => value, orElse: () => "");
  if (isLoggedIn && id != "" && token != "") {
    return userNotifier..loadMe();
  }
  return userNotifier;
});

final userProvider = Provider((ref) {
  return ref.watch(asyncUserProvider).maybeWhen(
        data: (user) => user,
        orElse: () {
          return EmptyModels.empty<CoreUser>();
        },
      );
});
