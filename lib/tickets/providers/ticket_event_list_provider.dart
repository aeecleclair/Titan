import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class ShotgunListNotifier extends ListNotifierAPI<EventSimple> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<EventSimple>> build() {
    loadShotgunList();
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<EventSimple>>> loadShotgunList() async {
    return await loadList(repository.ticketsEventsGet);
  }

  Future<bool> createTicketEvent(EventCreate event) async {
    final response = await repository.ticketsAdminEventsPost(body: event);
    if (response.isSuccessful) {
      await loadShotgunList();
      return true;
    }
    return false;
  }
}

final ticketEventListProvider =
    NotifierProvider<ShotgunListNotifier, AsyncValue<List<EventSimple>>>(
      ShotgunListNotifier.new,
    );
