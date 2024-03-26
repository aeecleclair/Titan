import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/ph/class/ph.dart';
import 'package:myecl/tools/repository/repository.dart';

class PhRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "ph/";

  Future<List<Ph>> getPhList() async {
    return List<Ph>.from(
        (await getList(suffix: "")).map((x) => Ph.fromJson(x)));
  }
}

final phRepositoryProvider = Provider<PhRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return PhRepository()..setToken(token);
});
