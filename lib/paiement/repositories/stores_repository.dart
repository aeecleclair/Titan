import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/tools/repository/repository.dart';

class StoresRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  Future<List<Store>> getStores() async {
    return [
      Store(
        id: "1",
        name: "Bar",
        walletId: "1",
        membership: AvailableAssociationMembership.AEECL,
      ),
      Store(
        id: "2",
        name: "Bar//",
        walletId: "2",
        membership: AvailableAssociationMembership.AEECL,
      ),
      Store(
        id: "3",
        name: "Challenge",
        walletId: "3",
        membership: AvailableAssociationMembership.USEECL,
      ),
    ];
    // return List<Store>.from(
    //   (await getList()).map((e) => Store.fromJson(e)),
    // );
  }

  Future<Store> createStore(Store store) async {
    return Store.fromJson(await create(store.toJson()));
  }

  Future<bool> updateStore(Store store) async {
    return await update(store.toJson(), store.id);
  }

  Future<bool> deleteStore(String id) async {
    return await delete("/$id");
  }

  Future<List<History>> getStoreHistory(String id) async {
    return [
      History(
        id: "3",
        type: HistoryType.received,
        otherWalletName: 'Bar//',
        total: 200,
        creation: DateTime.now().subtract(const Duration(days: 2)),
        status: TransactionStatus.confirmed,
      ),
      History(
        id: "3",
        type: HistoryType.received,
        otherWalletName: 'Bar//',
        total: 300,
        creation: DateTime.now().subtract(const Duration(days: 2)),
        status: TransactionStatus.confirmed,
      ),
      History(
        id: "4",
        type: HistoryType.received,
        otherWalletName: 'Bar//',
        total: 20000,
        creation: DateTime.now(),
        status: TransactionStatus.canceled,
      ),
    ];
    // return List<History>.from(
    //   (await getList(suffix: "/$id/wallet/history"))
    //       .map((e) => History.fromJson(e)),
    // );
  }
}

final storesRepositoryProvider = Provider<StoresRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return StoresRepository()..setToken(token);
});
