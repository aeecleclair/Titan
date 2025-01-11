import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/tools/repository/repository.dart';

class SellerStoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  Future<bool> createSeller(String storeId, String userId) async {
    return await create(
      {
        "user_id": userId,
      },
      suffix: "/$storeId/sellers",
    );
  }

  Future<List<Seller>> getSellers(String storeId) async {
    // return [
    //   Seller(id: "1", name: "Seller 1", order: 1),
    //   Seller(id: "2", name: "Seller 2", order: 2),
    //   Seller(id: "3", name: "Seller 3", order: 3),
    // ];
    return List<Seller>.from(
      (await getList(suffix: "/$storeId/sellers"))
          .map((e) => Seller.fromJson(e)),
    );
  }

  Future<bool> deleteSeller(String storeId, String userId) async {
    return await delete("/$storeId/sellers/$userId");
  }

  Future<bool> updateSeller(
    String storeId,
    String userId,
    Seller seller,
  ) async {
    return await update(seller.toJson(), "/$storeId/sellers/$userId");
  }
}

final sellerStoreRepositoryProvider = Provider<SellerStoreRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return SellerStoreRepository()..setToken(token);
});
