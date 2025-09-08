import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/amap/class/cash.dart';
import 'package:titan/amap/class/order.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';

class AmapUserRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/users/";

  Future<List<Order>> getOrderList(String userId) async {
    return List<Order>.from(
      (await getList(suffix: "$userId/orders")).map((x) => Order.fromJson(x)),
    );
  }

  Future<Cash> getCashByUser(String userId) async {
    return Cash.fromJson(await getOne(userId, suffix: "/cash"));
  }
}

final amapUserRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return AmapUserRepository()..setToken(token);
});
