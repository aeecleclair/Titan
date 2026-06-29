import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class StoreTicketEventListNotifier extends ListNotifier<TicketEvent> {
  final TicketsRepository _repository;
  StoreTicketEventListNotifier({required TicketsRepository repository})
    : _repository = repository,
      super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketEvent>>> loadStoreTicketEventList(
    String storeId,
  ) async {
    return await loadList(
      () => _repository.getTicketEventListByStoreId(storeId),
    );
  }
}

final storeTicketEventListProvider =
    StateNotifierProvider<
      StoreTicketEventListNotifier,
      AsyncValue<List<TicketEvent>>
    >((ref) {
      final repository = ref.watch(ticketsRepositoryProvider);
      return StoreTicketEventListNotifier(repository: repository);
    });
