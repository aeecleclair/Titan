import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/raffle.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/providers/raffle_id_provider.dart';
import 'package:myecl/tombola/repositories/tickets_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';

class TicketsListNotifier extends ListNotifier<Ticket> {
  final TicketRepository _ticketsRepository = TicketRepository();
  late String raffleId;
  TicketsListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _ticketsRepository.setToken(token);
  }

  void setId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    return await loadList(
        () async => _ticketsRepository.getTicketsListbyRaffleId(raffleId)
        );
  }

  Future<bool> addTicket(Ticket ticket) async {
    return add(
      // _ticketsRepository.createTicket,
      (ticket) async => ticket,
      ticket);
  }
}

final ticketsListProvider =
    StateNotifierProvider<TicketsListNotifier, AsyncValue<List<Ticket>>>((ref) {
  final token = ref.watch(tokenProvider);
  final notifier = TicketsListNotifier(token: token);
      final raffleId = ref.watch(raffleIdProvider);
    if (raffleId != Raffle.empty().id) {
      notifier.setId(raffleId);
      notifier.loadTicketList();
    }
  return notifier;
});
