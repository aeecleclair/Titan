import 'package:myecl/purchases/class/purchase.dart';
import 'package:myecl/tools/repository/repository.dart';

class PurchaseRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/me/purchases";

  Future<List<Purchase>> getPurchaseList() async {
    return List<Purchase>.from(
      (await getList()).map((x) => Purchase.fromJson(x)),
    );
  }
}
