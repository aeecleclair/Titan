import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/purchases/class/ticket.dart';
import 'package:myecl/purchases/class/ticket_information.dart';
import 'package:myecl/purchases/repositories/scanner_repository.dart';
import 'package:myecl/purchases/repositories/user_information_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class TicketListNotifier extends ListNotifier<Ticket> {
  final UserInformationRepository ticketRepository =
      UserInformationRepository();
  final ScannerRepository scannerRepository = ScannerRepository();
  AsyncValue<List<Ticket>> ticketList = const AsyncValue.loading();
  TicketListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    ticketRepository.setToken(token);
  }

  Future<AsyncValue<List<Ticket>>> loadTickets() async {
    return await loadList(ticketRepository.getTicketList);
  }

  Future<bool> consumeTicket(TicketInformation ticket, String tag) async {
    return await update(
      (Ticket fakeTicket) => scannerRepository.consumeTicket(ticket, tag),
      (tickets, ticket) {
        List<String> tags = ticket.tags;
        tags.add(tag);
        return tickets
          ..[tickets.indexWhere((g) => g.id == ticket.id)] =
              ticket.copyWith(tags: tags, scanLeft: ticket.scanLeft - 1);
      },
      ticket.ticket,
    );
  }
}

final ticketListProvider =
    StateNotifierProvider<TicketListNotifier, AsyncValue<List<Ticket>>>((ref) {
  final token = ref.watch(tokenProvider);
  TicketListNotifier notifier = TicketListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    await notifier.loadTickets();
  });
  return notifier;
});
