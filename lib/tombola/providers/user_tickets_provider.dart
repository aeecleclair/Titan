import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/tombola/class/lot.dart';
import 'package:myecl/tombola/class/tickets.dart';
import 'package:myecl/tombola/class/type_ticket.dart';
import 'package:myecl/tombola/repositories/tickets_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';
import 'package:myecl/user/class/list_users.dart';

class UserTicketListNotifier extends ListNotifier<Ticket> {
  final TicketRepository _ticketsRepository = TicketRepository();
  late String userId;
  UserTicketListNotifier({required String token})
      : super(const AsyncValue.loading()) {
    _ticketsRepository.setToken(token);
  }

  void setId(String id) {
    userId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    return await loadList(
        () async => _ticketsRepository.getTicketsListbyUserId(userId));
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
