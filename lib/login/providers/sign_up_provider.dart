import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/login/class/account_type.dart';
import 'package:titan/login/class/create_account.dart';
import 'package:titan/login/class/recover_request.dart';
import 'package:titan/login/repositories/sign_up_repository.dart';

class SignUpProvider extends StateNotifier {
  final SignUpRepository repository;
  SignUpProvider({required this.repository}) : super(null);

  Future<bool> createUser(String email, AccountType accountType) async {
    return await repository.createUser(email, accountType);
  }

  Future<bool> recoverUser(String email) async {
    return await repository.recoverUser(email);
  }

  Future<bool> activateUser(CreateAccount createAccount) async {
    return await repository.activateUser(createAccount);
  }

  Future<bool> resetPassword(RecoverRequest recoverRequest) async {
    return await repository.resetPassword(recoverRequest);
  }
}

final signUpProvider = StateNotifierProvider((ref) {
  final signUpRepository = ref.watch(signUpRepositoryProvider);
  return SignUpProvider(repository: signUpRepository);
});
