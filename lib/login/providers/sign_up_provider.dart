import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/repository/repository2.dart';

class SignUpProvider extends StateNotifier {
  final Openapi repository;
  SignUpProvider({required this.repository}) : super(null);

  Future<bool> createUser(String email) async {
    return (await repository.usersCreatePost(
            body: CoreUserCreateRequest(
      email: email,
    )))
        .isSuccessful;
  }

  Future<bool> recoverUser(String email) async {
    return (await repository.usersRecoverPost(
            body: BodyRecoverUserUsersRecoverPost(email: email)))
        .isSuccessful;
  }

  Future<bool> activateUser(CoreUserActivateRequest createAccount) async {
    return (await repository.usersActivatePost(body: createAccount))
        .isSuccessful;
  }

  Future<bool> resetPassword(ResetPasswordRequest recoverRequest) async {
    return (await repository.usersResetPasswordPost(body: recoverRequest))
        .isSuccessful;
  }
}

final signUpProvider = StateNotifierProvider((ref) {
  final signUpRepository = ref.watch(repositoryProvider);
  return SignUpProvider(repository: signUpRepository);
});
