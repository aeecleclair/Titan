import 'package:myecl/purchases/class/seller.dart';
import 'package:myecl/tools/repository/repository.dart';

class SellerRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "cdr/me/sellers/";

  Future<List<Seller>> getSellerList() async {
    return List<Seller>.from(
      (await getList()).map((x) => Seller.fromJson(x)),
    );
  }
}
