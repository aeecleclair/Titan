import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/ticket.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class EventTicketsNotifier extends ListNotifier<Ticket> {
  final TicketsRepository _repository;
  EventTicketsNotifier({required this._repository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ticket>>> loadEventTickets(String eventId) async {
    return await loadList(() => _repository.getTicketsByEventId(eventId));
  }
}

final eventTicketsProvider =
    StateNotifierProvider<EventTicketsNotifier, AsyncValue<List<Ticket>>>((
      ref,
    ) {
      final repository = ref.watch(ticketsRepositoryProvider);
      return EventTicketsNotifier(repository: repository);
    });
