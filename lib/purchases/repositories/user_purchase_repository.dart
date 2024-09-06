import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/tools/repository/repository.dart';

class UserPurchaseRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/me/";

  Future<List<Purchase>> getPurchaseList() async {
    print((await getList(suffix: "purchases/")));
    return List<Purchase>.from(
      (await getList(suffix: "purchases/")).map((x) => Purchase.fromJson(x)),
    );
  }
}
