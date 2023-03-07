import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/repositories/tickets_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserTicketListNotifier extends ListNotifier<Ticket> {
  final TicketRepository _ticketsRepository = TicketRepository();
  late final String userId;
  UserTicketListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _ticketsRepository.setToken(token);
  }

  void setId(String id) {
    userId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    // return await loadList(
    //     () async => _ticketsRepository.getTicketsListbyUserId(userId));
    return state = AsyncData([
      Ticket(
        id: '1',
        typeId: '1',
        winningLot: '',
        userId: '',
        raffleId: "1",
        price: 1,
        nbTicket: 1,
      ),
      Ticket(
        id: '2',
        typeId: '2',
        winningLot: '',
        userId: '',
        raffleId: "1",
        price: 2,
        nbTicket: 3,
      ),
      Ticket(
        id: '3',
        typeId: '3',
        winningLot: '',
        userId: '',
        raffleId: "azertyuiop",
        price: 20,
        nbTicket: 50,
      )
    ]);
  }
}

final userTicketListProvider =
    StateNotifierProvider<UserTicketListNotifier, AsyncValue<List<Ticket>>>(
        (ref) {
  final token = ref.watch(tokenProvider);
  UserTicketListNotifier notifier = UserTicketListNotifier(token: token);
  tokenExpireWrapperAuth(ref, () async {
    final userId = ref.watch(idProvider);
    userId.whenData((value) async {
      notifier.setId(value);
      await notifier.loadTicketList();
    });
  });
  return notifier;
});
