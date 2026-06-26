import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class StoreTicketEventListNotifier extends ListNotifierAPI<EventSimple> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<EventSimple>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<EventSimple>>> loadStoreTicketEventList(
    String storeId,
  ) async {
    return await loadList(
      () => repository.ticketsAdminStoreStoreIdEventsGet(storeId: storeId),
    );
  }
}

final storeTicketEventListProvider =
    NotifierProvider<
      StoreTicketEventListNotifier,
      AsyncValue<List<EventSimple>>
    >(StoreTicketEventListNotifier.new);
