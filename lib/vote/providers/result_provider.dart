import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/vote/class/result.dart';
import 'package:myecl/vote/repositories/result_repository.dart';

class ResultNotifier extends ListNotifier<Result> {
  final resultRepository = ResultRepository();
  ResultNotifier({required String token}) : super(const AsyncValue.loading()) {
    resultRepository.setToken(token);
  }

  Future<AsyncValue<List<Result>>> loadResult() async {
    return await loadList(resultRepository.getResult);
  }
}

final resultProvider =
    StateNotifierProvider<ResultNotifier, AsyncValue<List<Result>>>((ref) {
  final token = ref.watch(tokenProvider);
  final resultNotifier = ResultNotifier(token: token);
  resultNotifier.loadResult();
  return resultNotifier;
});