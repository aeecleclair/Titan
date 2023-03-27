import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/tickets.dart';
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
    // return await loadList(
    //     () async => _ticketsRepository.getTicketsListbyRaffleId(raffleId));
    return state = AsyncData([
      Ticket(
        id: "1",
        raffleId: "1",
        userId: "1",
        groupId: '',
        nbTicket: 1,
        typeId: '',
        unitPrice: 1,
        winningLot: '',
      ),
      Ticket(
        id: "1",
        raffleId: "1",
        userId: "1",
        groupId: '',
        nbTicket: 3,
        typeId: '',
        unitPrice: 2,
        winningLot: '',
      )
    ]);
  }

  Future<bool> addTicket(Ticket ticket) async {
    return add(_ticketsRepository.createTicket, ticket);
  }

  Future<bool> deleteTicket(Ticket ticket) async {
    return delete(
      _ticketsRepository.deleteTicket,
      (tickets, t) => tickets..removeWhere((e) => e.id == t.id),
      ticket.id,
      ticket,
    );
  }

  Future<bool> updateTicket(Ticket ticket) async {
    return update(
        _ticketsRepository.updateTicket,
        (tickets, t) => tickets..[tickets.indexWhere((e) => e.id == t.id)] = t,
        ticket);
  }
}

final ticketsListProvider =
    StateNotifierProvider<TicketsListNotifier, AsyncValue<List<Ticket>>>((ref) {
  final token = ref.watch(tokenProvider);
  return TicketsListNotifier(token: token);
});
