import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/paiement/class/history.dart';
import 'package:titan/paiement/repositories/users_me_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class MyHistoryNotifier extends ListNotifier<History> {
  final UsersMeRepository usersMeRepository;
  MyHistoryNotifier({required this.usersMeRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<History>>> getHistory() async {
    return await loadList(usersMeRepository.getMyHistory);
  }
}

final myHistoryProvider =
    StateNotifierProvider<MyHistoryNotifier, AsyncValue<List<History>>>((ref) {
      final historyRepository = ref.watch(usersMeRepositoryProvider);
      return MyHistoryNotifier(usersMeRepository: historyRepository)
        ..getHistory();
    });
