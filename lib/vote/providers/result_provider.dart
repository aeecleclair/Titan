import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myemapp/tools/providers/list_notifier.dart';
import 'package:myemapp/tools/token_expire_wrapper.dart';
import 'package:myemapp/vote/class/result.dart';
import 'package:myemapp/vote/repositories/result_repository.dart';

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
