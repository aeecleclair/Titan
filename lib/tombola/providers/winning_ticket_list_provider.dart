import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/providers/ticket_list_provider.dart';
import 'package:myecl/tombola/repositories/lots_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class WinningTicketNotifier extends ListNotifier<Ticket> {
  final LotRepository _lotRepository = LotRepository();
  WinningTicketNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _lotRepository.setToken(token);
  }

  void setData(List<Ticket> tickets) {
    state = AsyncValue.data(tickets);
  }

  Future<AsyncValue<List<Ticket>>> drawLot(Lot lot) async {
    final drawnList = await _lotRepository.drawLot(lot);
    state.when(
        data: (list) {
          state = AsyncValue.data(list + drawnList);
        },
        error: (e, s) {},
        loading: () {
          state = AsyncValue.data(drawnList);
        });
    return state;
  }
}

final winningTicketListProvider =
    StateNotifierProvider<WinningTicketNotifier, AsyncValue<List<Ticket>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  WinningTicketNotifier notifier = WinningTicketNotifier(token: token);
  final ticketFromRaffle = ref.watch(ticketsListProvider);
  final winningTickets = ticketFromRaffle.when<List<Ticket>>(
      data: (data) => data.where((element) => element.lot != null).toList(),
      loading: () => [],
      error: (Object e, StackTrace? s) => []);
  notifier.setData(winningTickets);
  return notifier;
});
