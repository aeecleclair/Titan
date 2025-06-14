import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/amap/class/cash.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/repository/repository.dart';

class CashRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "amap/users/";

  CashRepository(super.ref);

  Future<List<Cash>> getCashList() async {
    return List<Cash>.from(
      (await getList(suffix: "cash")).map((x) => Cash.fromJson(x)),
    );
  }

  Future<Cash> getCash(String userId) async {
    return Cash.fromJson(await getOne(userId, suffix: "/cash"));
  }

  Future<Cash> createCash(Cash cash) async {
    return Cash.fromJson(
      await create(cash.toJson(), suffix: "${cash.user.id}/cash"),
    );
  }

  Future<bool> updateCash(Cash cash) async {
    return await update(cash.toJson(), cash.user.id, suffix: "/cash");
  }
}

final cashRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return CashRepository(ref)..setToken(token);
});
