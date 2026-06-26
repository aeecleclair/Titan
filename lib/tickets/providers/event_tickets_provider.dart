import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/generated/openapi.swagger.dart';
import 'package:titan/tools/providers/list_notifier_api.dart';
import 'package:titan/tools/repository/repository.dart';

class EventTicketsNotifier
    extends ListNotifierAPI<AppCoreTicketsSchemasTicketsTicket> {
  Openapi get repository => ref.watch(repositoryProvider);

  @override
  AsyncValue<List<AppCoreTicketsSchemasTicketsTicket>> build() {
    return const AsyncValue.loading();
  }

  Future<AsyncValue<List<AppCoreTicketsSchemasTicketsTicket>>> loadEventTickets(
    String eventId,
  ) async {
    return await loadList(
      () => repository.ticketsAdminEventsEventIdTicketsGet(eventId: eventId),
    );
  }
}

final eventTicketsProvider =
    NotifierProvider<
      EventTicketsNotifier,
      AsyncValue<List<AppCoreTicketsSchemasTicketsTicket>>
    >(EventTicketsNotifier.new);
