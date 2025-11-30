import 'package:titan/purchases/class/purchase.dart';
import 'package:titan/tools/repository/repository.dart';

class UserPurchaseRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/me/";

  Future<List<Purchase>> getPurchaseList() async {
    return List<Purchase>.from(
      (await getList(suffix: "purchases/all")).map((x) => Purchase.fromJson(x)),
    );
  }
}
