import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/ticket.dart';
import 'package:titan/tickets/repositories/ticket_event_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class EventTicketsNotifier extends ListNotifier<Ticket> {
  final TicketEventRepository ticketEventRepository;
  EventTicketsNotifier({required this.ticketEventRepository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<Ticket>>> loadEventTickets(String eventId) async {
    return await loadList(
      () => ticketEventRepository.getTicketsByEventId(eventId),
    );
  }
}

final eventTicketsProvider =
    StateNotifierProvider<EventTicketsNotifier, AsyncValue<List<Ticket>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final ticketEventRepository = TicketEventRepository()..setToken(token);
      return EventTicketsNotifier(ticketEventRepository: ticketEventRepository);
    });
