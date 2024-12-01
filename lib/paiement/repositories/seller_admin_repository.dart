import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/tools/repository/repository.dart';

class SellerAdminsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  Future<Seller> createSellerAdmin(String storeId, String userId) async {
    return Seller.fromJson(
      await create({"user_id": userId}, suffix: "/$storeId/admins"),
    );
  }

  Future<List<Seller>> getStoreAdmins(String storeId) async {
    return List<Seller>.from(
      (await getList(suffix: "/$storeId/admins"))
          .map((e) => Seller.fromJson(e)),
    );
  }

  Future<bool> deleteStoreAdmin(String storeId, String userId) async {
    return await delete("/$storeId/admins/$userId");
  }
}

final sellerAdminsRepositoryProvider = Provider<SellerAdminsRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return SellerAdminsRepository()..setToken(token);
});
