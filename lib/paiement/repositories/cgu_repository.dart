import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/cgu.dart';
import 'package:myecl/tools/repository/repository.dart';

class CguRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/';

  Future<CGU> getCGU() async {
    return CGU.fromJson(await getOne("cgu"));
  }

  Future<bool> signCGU(CGU cgu) async {
    return await create(cgu.toJson(), suffix: "cgu");
  }
}

final cguRepositoryProvider = Provider<CguRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return CguRepository()..setToken(token);
});
