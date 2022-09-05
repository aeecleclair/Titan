import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/amap/class/product.dart';
import 'package:myecl/tools/repository/repository.dart';

class AmapUserRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/users/";
  final List<Product> loadedProducts = <Product>[];

  Future<List<Order>> getOrderList(String userId) async {
    return List<Order>.from((await getList(suffix: userId + "/orders"))
        .map((x) => Order.fromJson(x)));
  }

  Future<Cash> getCashByUser(String userId) async {
    return Cash.fromJson(await getOne(userId, suffix: "/cash"));
  }
}
