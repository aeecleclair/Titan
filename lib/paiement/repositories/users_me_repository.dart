import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/class/user_store.dart';
import 'package:titan/paiement/class/wallet.dart';
import 'package:titan/tools/repository/repository.dart';

class UsersMeRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/';

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
  return UsersMeRepository()..setToken(token);
});
