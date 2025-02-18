import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/tools/repository/repository.dart';

class UsersMeRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/';

  Future<bool> register() async {
    return await create({}, suffix: 'register');
  }

  Future<List<History>> getMyHistory() async {
    return List<History>.from(
      (await getList(
        suffix: 'wallet/history',
      ))
          .map((e) => History.fromJson(e)),
    );
  }
}

final usersMeRepositoryProvider = Provider<UsersMeRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return UsersMeRepository()..setToken(token);
});
