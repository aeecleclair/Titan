import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';
import 'package:titan/vote/class/result.dart';
import 'package:titan/vote/repositories/result_repository.dart';

class ResultNotifier extends ListNotifier<Result> {
  final ResultRepository resultRepository;
  ResultNotifier({required this.resultRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Result>>> loadResult() async {
    return await loadList(resultRepository.getResult);
  }
}

final resultProvider =
    StateNotifierProvider<ResultNotifier, AsyncValue<List<Result>>>((ref) {
      final resultRepository = ref.watch(resultRepositoryProvider);
      final resultNotifier = ResultNotifier(resultRepository: resultRepository);
      tokenExpireWrapperAuth(ref, () async {
        await resultNotifier.loadResult();
      });
      return resultNotifier;
    });
