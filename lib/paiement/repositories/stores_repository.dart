import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/class/qr_code_data.dart';
import 'package:myecl/paiement/class/store.dart';
import 'package:myecl/tools/repository/repository.dart';

class StoresRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  Future<bool> updateStore(Store store) async {
    return await update(store.toJson(), "/${store.id}");
  }

  Future<bool> deleteStore(String id) async {
    return await delete("/$id");
  }

  Future<List<History>> getStoreHistory(String id) async {
    return List<History>.from(
      (await getList(suffix: "/$id/history")).map((e) => History.fromJson(e)),
    );
  }

  Future<bool> scan(String id, QrCodeData data) async {
    return await create(data.toJson(), suffix: "/$id/scan");
  }
}

final storesRepositoryProvider = Provider<StoresRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return StoresRepository()..setToken(token);
});
