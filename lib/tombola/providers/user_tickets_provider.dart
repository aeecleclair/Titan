import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/class/type_ticket_simple.dart';
import 'package:myecl/tombola/repositories/raffle_detail_repository.dart';
import 'package:myecl/tombola/repositories/tickets_repository.dart';
import 'package:myecl/tombola/repositories/user_tickets_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserTicketListNotifier extends ListNotifier<Ticket> {
  final UserDetailRepository _userDetailRepository =
      UserDetailRepository();
  final TicketRepository _ticketsRepository = TicketRepository();
  late String userId;
  UserTicketListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _userDetailRepository.setToken(token);
    _ticketsRepository.setToken(token);
  }

  void setId(String id) {
    userId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    return await loadList(
        () async => _userDetailRepository.getTicketsListbyUserId(userId));
  }

  
  Future<bool> addTicket(TypeTicketSimple typeTicketSimple) async {
    return add(
      (_) async => _ticketsRepository.buyTicket(typeTicketSimple.id, userId),
      Ticket.empty());
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
