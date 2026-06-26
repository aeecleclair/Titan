import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class MyHistoryNotifier extends ListNotifierAPI<History> {
  Openapi get usersMeRepository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<History>> build() {
    getHistory();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<History>>> getHistory() async {
    return await loadList(usersMeRepository.mypaymentUsersMeWalletHistoryGet);
  }
}

final myHistoryProvider =
    NotifierProvider<MyHistoryNotifier, AsyncValue<List<History>>>(
      MyHistoryNotifier.new,
    );
