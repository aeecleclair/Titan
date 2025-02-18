import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/tools/repository/repository.dart';

class StoresRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  Future<Store> createStore(Store store) async {
    return Store.fromJson(await create(store.toJson()));
  }

  Future<bool> updateStore(Store store) async {
    return await update(store.toJson(), store.id);
  }

  Future<bool> deleteStore(String id) async {
    return await delete(id);
  }

  Future<List<History>> getStoreHistory(String id) async {
    return List<History>.from(
      (await getList(suffix: "/$id/wallet/history"))
          .map((e) => History.fromJson(e)),
    );
  }
}

final storesRepositoryProvider = Provider<StoresRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return StoresRepository()..setToken(token);
});
