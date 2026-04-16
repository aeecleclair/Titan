import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/tickets/class/user_ticket.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserTicketsNotifier extends ListNotifier<UserTicket> {
  final TicketsRepository _ticketsRepository = TicketsRepository();
  UserTicketsNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _ticketsRepository.setToken(token);
  }

  Future<AsyncValue<List<UserTicket>>> loadUserTickets() async {
    return await loadList(() async => _ticketsRepository.getUserTickets());
  }
}

final userTicketsProvider =
    StateNotifierProvider<UserTicketsNotifier, AsyncValue<List<UserTicket>>>((
      ref,
    ) {
      final token = ref.watch(tokenProvider);
      final notifier = UserTicketsNotifier(token: token);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadUserTickets();
      });
      return notifier;
    });
