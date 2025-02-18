import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/paiement/class/history.dart';
import 'package:myecl/paiement/repositories/users_me_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class HistoryNotifier extends ListNotifier<History> {
  final UsersMeRepository usersMeRepository;
  HistoryNotifier({required this.usersMeRepository})
      : super(const AsyncValue.loading());

  Future<AsyncValue<List<History>>> getHistory() async {
    return await loadList(usersMeRepository.getMyHistory);
  }
}

final historyProvider =
    StateNotifierProvider<HistoryNotifier, AsyncValue<List<History>>>((ref) {
  final historyRepository = ref.watch(usersMeRepositoryProvider);
  return HistoryNotifier(usersMeRepository: historyRepository)..getHistory();
});
