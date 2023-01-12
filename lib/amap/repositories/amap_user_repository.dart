import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/amap/class/order.dart';
import 'package:myecl/tools/repository/repository.dart';

class AmapUserRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/users/";

  Future<List<Order>> getOrderList(String userId) async {
    print(await getList(suffix: "$userId/orders"));
    return List<Order>.from((await getList(suffix: "$userId/orders"))
        .map((x) => Order.fromJson(x)));
  }

  Future<Cash> getCashByUser(String userId) async {
    return Cash.fromJson(await getOne(userId, suffix: "/cash"));
  }
}
