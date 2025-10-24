import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/paiement/class/tos.dart';
import 'package:titan/tools/repository/repository.dart';

class TosRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'mypayment/users/me/';

  Future<TOS> getTOS() async {
    return TOS.fromJson(await getOne("tos"));
  }

  Future<bool> signTOS(TOS tos) async {
    return await create(tos.toJson(), suffix: "tos");
  }
}

final tosRepositoryProvider = Provider<TosRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return TosRepository()..setToken(token);
});
