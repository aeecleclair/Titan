import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/tools/repository/repository.dart';

class UsersMeRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/';

  Future<bool> register() async {
    return await create({}, suffix: 'register');
  }

  Future<List<History>> getMyHistory() async {
    return [
      History(
        id: "1",
        type: HistoryType.given,
        otherWalletName: 'WEI',
        total: 20000,
        creation: DateTime.now(),
        status: TransactionStatus.confirmed,
      ),
      History(
        id: "2",
        type: HistoryType.transfer,
        otherWalletName: 'Recharge',
        total: 5000,
        creation: DateTime.now().subtract(const Duration(days: 1)),
        status: TransactionStatus.confirmed,
      ),
      History(
        id: "3",
        type: HistoryType.received,
        otherWalletName: 'Bar//',
        total: 200,
        creation: DateTime.now().subtract(const Duration(days: 2)),
        status: TransactionStatus.confirmed,
      ),
      History(
        id: "4",
        type: HistoryType.given,
        otherWalletName: 'Commuz',
        total: 900,
        creation: DateTime.now().subtract(const Duration(days: 30)),
        status: TransactionStatus.canceled,
      ),
      History(
        id: "4",
        type: HistoryType.received,
        otherWalletName: 'Commuz',
        total: 900,
        creation: DateTime.now().subtract(const Duration(days: 35)),
        status: TransactionStatus.canceled,
      ),
    ];
    // return List<History>.from(
    //   (await getList(
    //     suffix: 'wallet/history',
    //   ))
    //       .map((e) => History.fromJson(e)),
    // );
  }

  Future<List<Store>> getMyStores() async {
    return [
      Store(
          id: "1",
          name: "WEI",
          walletId: "a",
          membership: AvailableAssociationMembership.AEECL),
      Store(
          id: "2",
          name: "Bar",
          walletId: "b",
          membership: AvailableAssociationMembership.AEECL),
      Store(
          id: "3",
          name: "Commuz",
          walletId: "c",
          membership: AvailableAssociationMembership.AEECL),
      Store(
          id: "4",
          name: "Raid",
          walletId: "d",
          membership: AvailableAssociationMembership.USEECL),
    ];
    // return List<Store>.from(
    //   (await getList(suffix: "stores")).map((e) => Store.fromJson(e)),
    // );
  }
}

final usersMeRepositoryProvider = Provider<UsersMeRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return UsersMeRepository()..setToken(token);
});
