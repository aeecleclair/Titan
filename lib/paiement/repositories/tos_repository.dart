import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/paiement/class/tos.dart';
import 'package:myecl/tools/repository/repository.dart';

class TosRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'myeclpay/users/me/';

  TosRepository(super.ref);

  Future<TOS> getTOS() async {
    return TOS.fromJson(await getOne("tos"));
  }

  Future<bool> signTOS(TOS tos) async {
    return await create(tos.toJson(), suffix: "tos");
  }
}

final tosRepositoryProvider = Provider<TosRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TosRepository(ref)..setToken(token);
});
