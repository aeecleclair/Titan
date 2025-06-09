import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/auth/providers/openid_provider.dart';
import 'package:myecl/raffle/class/pack_ticket.dart';
import 'package:myecl/raffle/class/tickets.dart';
import 'package:myecl/raffle/repositories/tickets_repository.dart';
import 'package:myecl/raffle/repositories/user_tickets_repository.dart';
import 'package:myecl/tools/providers/list_notifier.dart';
import 'package:myecl/tools/token_expire_wrapper.dart';

class UserTicketListNotifier extends ListNotifier<Ticket> {
  final UserDetailRepository _userDetailRepository;
  final TicketRepository _ticketsRepository;
  late String userId;
  UserTicketListNotifier(this._userDetailRepository, this._ticketsRepository)
    : super(const AsyncValue.loading());

  void setId(String id) {
    userId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    return await loadList(
      () async => _userDetailRepository.getTicketsListByUserId(userId),
    );
  }

  Future<bool> buyTicket(PackTicket packTicket) async {
    return addAll(
      (_) async => _ticketsRepository.buyTicket(packTicket.id, userId),
      [],
    );
  }
}

final userTicketListProvider =
    StateNotifierProvider<UserTicketListNotifier, AsyncValue<List<Ticket>>>((
      ref,
    ) {
      final userDetailRepository = ref.watch(userDetailRepositoryProvider);
      final ticketsRepository = ref.watch(ticketRepositoryProvider);
      UserTicketListNotifier notifier = UserTicketListNotifier(
        userDetailRepository,
        ticketsRepository,
      );
      tokenExpireWrapperAuth(ref, () async {
        final userId = ref.watch(userIdProvider);
        userId.whenData((value) async {
          notifier.setId(value);
          await notifier.loadTicketList();
        });
      });
      return notifier;
    });
