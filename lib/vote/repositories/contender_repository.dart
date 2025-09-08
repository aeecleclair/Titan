import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/vote/class/contender.dart';

class ContenderRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "campaign/lists";

  Future<bool> deleteContender(String contenderId) async {
    return await delete("/$contenderId");
  }

  Future<bool> updateContender(Contender contender) async {
    return await update(contender.toJson(), "/${contender.id}");
  }

  Future<Contender> createContender(Contender contender) async {
    return Contender.fromJson(await create(contender.toJson()));
  }

  Future<List<Contender>> getContenders() async {
    return (await getList()).map((e) => Contender.fromJson(e)).toList();
  }

  Future<bool> deleteContenders(String type) {
    return delete("/?list_type=$type");
  }
}

final contenderRepositoryProvider = Provider<ContenderRepository>((ref) {
  final token = ref.watch(tokenProvider);
  return ContenderRepository()..setToken(token);
});
