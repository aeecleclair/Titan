import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/login/class/create_account.dart';
import 'package:myecl/login/class/recover_request.dart';
import 'package:myecl/login/repositories/sign_up_repository.dart';

class SignUpProvider extends StateNotifier {
  SignUpProvider(state) : super(state);
  final SignUpRepository _repository = SignUpRepository();

  Future<bool> createUser(String email, AccountType accountType) async {
    return await _repository.createUser(email, accountType);
  }

  Future<bool> recoverUser(String email) async {
    return await _repository.recoverUser(email);
  }

  Future<bool> activateUser(CreateAccount createAccount) async {
    return await _repository.activateUser(createAccount);
  }

  Future<bool> resetPassword(RecoverRequest recoverRequest) async {
      return await _repository.resetPassword(recoverRequest);
  }
}

final signUpProvider = StateNotifierProvider((ref) => SignUpProvider(null));
