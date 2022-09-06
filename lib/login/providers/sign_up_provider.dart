import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/login/class/account_type.dart';
import 'package:myecl/login/repositories/sign_up_repository.dart';

class SignUpProvider extends StateNotifier {
  SignUpProvider(state) : super(state);
  final SignUpRepository _repository = SignUpRepository();

  Future<bool> createUser(String email, String password, AccountType accountType) async {
    return await _repository.createUser(email, password, accountType);
  }

  Future<bool> recoverUser(String email) async {
    return await _repository.recoverUser(email);
  }
}

final signUpProvider = StateNotifierProvider((ref) => SignUpProvider(null));