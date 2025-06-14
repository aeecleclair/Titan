import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/user_store.dart';
import 'package:myecl/paiement/class/wallet.dart';
import 'package:myecl/tools/repository/repository.dart';

class UsersMeRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/';

  UsersMeRepository(super.ref);

  Future<bool> register() async {
    return await create({}, suffix: 'register');
  }

  Future<List<History>> getMyHistory() async {
    return List<History>.from(
      (await getList(suffix: 'wallet/history')).map((e) => History.fromJson(e)),
    );
  }

  Future<List<UserStore>> getMyStores() async {
    return List<UserStore>.from(
      (await getList(suffix: "stores")).map((e) => UserStore.fromJson(e)),
    );
  }

  Future<Wallet> getMyWallet() async {
    return Wallet.fromJson(await getOne("wallet"));
  }
}

final usersMeRepositoryProvider = Provider<UsersMeRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return UsersMeRepository(ref)..setToken(token);
});
