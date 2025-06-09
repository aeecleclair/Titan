import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserPurchaseRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/me/";

  UserPurchaseRepository(super.ref);

  Future<List<Purchase>> getPurchaseList() async {
    return List<Purchase>.from(
      (await getList(suffix: "purchases/")).map((x) => Purchase.fromJson(x)),
    );
  }
}

final userPurchaseRepositoryProvider = Provider<UserPurchaseRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return UserPurchaseRepository(ref)..setToken(token);
});
