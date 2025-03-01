import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/client_index.dart';
import 'package:myecl/generated/openapi.models.swagger.dart';
import 'package:myecl/tools/repository/repository.dart';

class SignUpProvider extends StateNotifier {
  final Openapi signUpRepository;
  SignUpProvider({required this.signUpRepository}) : super(null);

  Future<bool> createUser(String email) async {
    return (await signUpRepository.usersCreatePost(body: CoreUserCreateRequest(email: email))).isSuccessful;
  }

  Future<bool> recoverUser(String email) async {
    return (await signUpRepository.usersRecoverPost(body: BodyRecoverUserUsersRecoverPost(email: email))).isSuccessful;
  }

  Future<bool> activateUser(CoreUserActivateRequest createAccount) async {
    return (await signUpRepository.usersActivatePost(body: createAccount)).isSuccessful;
  }

  Future<bool> resetPassword(ResetPasswordRequest recoverRequest) async {
    return (await signUpRepository.usersResetPasswordPost(body: recoverRequest)).isSuccessful;
  }
}

final signUpProvider = StateNotifierProvider((ref) {
  final signUpRepository = ref.watch(repositoryProvider);
  return SignUpProvider(signUpRepository: signUpRepository);
});
