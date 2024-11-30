import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/seller.dart';
import 'package:myecl/tools/repository/repository.dart';
import 'package:myecl/user/class/list_users.dart';

class SellerAdminsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/stores';

  Future<bool> createSellerAdmin(String storeId, String userId) async {
    return await create(
      {
        "user_id": userId,
      },
      suffix: "/$storeId/admins",
    );
  }

  Future<List<Seller>> getStoreAdmins(String storeId) async {
    return [
      Seller(
        userId: "1",
        user: SimpleUser(
          id: "1",
          name: "1",
          firstname: "User",
          nickname: null,
        ),
        storeId: "1",
        canBank: true,
        canSeeHistory: true,
        canCancel: true,
        canManageSellers: true,
        storeAdmin: true,
      ),
      Seller(
        userId: "2",
        user: SimpleUser(
          id: "2",
          name: "2",
          firstname: "User",
          nickname: null,
        ),
        storeId: "1",
        canBank: true,
        canSeeHistory: true,
        canCancel: false,
        canManageSellers: true,
        storeAdmin: false,
      ),
      Seller(
        userId: "3",
        user: SimpleUser(
          id: "3",
          name: "3",
          firstname: "User",
          nickname: null,
        ),
        storeId: "1",
        canBank: false,
        canSeeHistory: false,
        canCancel: false,
        canManageSellers: false,
        storeAdmin: false,
      ),
    ];
    // return List<Seller>.from(
    //   (await getList(suffix: "/$storeId/admins"))
    //       .map((e) => Seller.fromJson(e)),
    // );
  }

  Future<bool> deleteStoreAdmin(String storeId, String userId) async {
    return await delete("/$storeId/admins/$userId");
  }
}

final sellerAdminsRepositoryProvider = Provider<SellerAdminsRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return SellerAdminsRepository()..setToken(token);
});
