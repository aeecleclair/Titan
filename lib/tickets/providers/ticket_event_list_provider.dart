import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket_event.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class TicketEventListNotifier extends ListNotifier<TicketEvent> {
  final TicketsRepository _repository;
  TicketEventListNotifier({required TicketsRepository repository})
    : _repository = repository,
      super(const AsyncValue.loading());

  Future<AsyncValue<List<TicketEvent>>> loadTicketEventList() async {
    return await loadList(() async => _repository.getAllTicketEvents());
  }

  Future<TicketEvent> loadTicketEventById(String id) async {
    return await _repository.getTicketEventById(id);
  }

  Future<bool> createTicketEvent(TicketEvent ticketEvent) async {
    return await add(_repository.createTicketEvent, ticketEvent);
  }

  Future<bool> deleteTicketEvent(TicketEvent ticketEvent) async {
    return await delete(
      _repository.deleteTicketEvent,
      (ticketEvents, ticketEvent) =>
          ticketEvents..removeWhere((toCheck) => toCheck.id == ticketEvent.id),
      ticketEvent.id,
      ticketEvent,
    );
  }
}

final ticketEventListProvider =
    StateNotifierProvider<
      TicketEventListNotifier,
      AsyncValue<List<TicketEvent>>
    >((ref) {
      final repository = ref.watch(ticketsRepositoryProvider);
      final notifier = TicketEventListNotifier(repository: repository);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadTicketEventList();
      });
      return notifier;
    });
