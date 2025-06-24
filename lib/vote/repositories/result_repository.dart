import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tools/repository/repository.dart';
import 'package:titan/vote/class/result.dart';

class ResultRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'campaign/results';

  Future<List<Result>> getResult() async {
    return List<Result>.from((await getList()).map((e) => Result.fromJson(e)));
  }
}

final resultRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  return ResultRepository()..setToken(token);
});
