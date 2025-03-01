import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/generated/openapi.swagger.dart';
import 'package:myecl/tools/providers/single_notifier%20copy.dart';
import 'package:myecl/tools/repository/repository.dart';

class TicketNotifier extends SingleNotifier2<Ticket> {
  final Openapi ticketRepository;
  TicketNotifier({required this.ticketRepository})
      : super(const AsyncValue.loading());

  void setTicket(Ticket i) {
    state = AsyncValue.data(i);
  }

  Future<AsyncValue<TicketSecret>> loadTicketSecret() async {
    return state.maybeWhen(orElse: () async {
      return AsyncValue.error('Ticket is not loaded', StackTrace.current);
    }, data: (value) async {
      final response = await ticketRepository
          .cdrUsersMeTicketsTicketIdSecretGet(ticketId: value.id);
      if (response.isSuccessful) {
        return AsyncValue.data(response.body!);
      }
      return AsyncValue.error(response.error.toString(), StackTrace.current);
    });
  }
}

final ticketProvider =
    StateNotifierProvider<TicketNotifier, AsyncValue<Ticket>>((ref) {
  final ticketRepository = ref.watch(repositoryProvider);
  TicketNotifier notifier = TicketNotifier(ticketRepository: ticketRepository);
  return notifier;
});
