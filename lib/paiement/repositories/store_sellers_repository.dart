import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/tools/repository/repository.dart';

class SellerStoreRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  SellerStoreRepository(super.ref);

  Future<Seller> createSeller(String storeId, Seller seller) async {
    return Seller.fromJson(
      await create(seller.toJson(), suffix: "/$storeId/sellers"),
    );
  }

  Future<List<Seller>> getSellers(String storeId) async {
    return List<Seller>.from(
      (await getList(
        suffix: "/$storeId/sellers",
      )).map((e) => Seller.fromJson(e)),
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
