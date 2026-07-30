import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/tickets/class/user_ticket.dart';
import 'package:titan/tickets/repositories/tickets_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';
import 'package:titan/tools/token_expire_wrapper.dart';

class UserTicketsNotifier extends ListNotifier<UserTicket> {
  final TicketsRepository _repository;
  UserTicketsNotifier({required this._repository})
    : super(const AsyncValue.loading());

  Future<AsyncValue<List<UserTicket>>> loadUserTickets() async {
    return await loadList(() async => _repository.getUserTickets());
  }
}

final userTicketsProvider =
    StateNotifierProvider<UserTicketsNotifier, AsyncValue<List<UserTicket>>>((
      ref,
    ) {
      final repository = ref.watch(ticketsRepositoryProvider);
      final notifier = UserTicketsNotifier(repository: repository);
      tokenExpireWrapperAuth(ref, () async {
        await notifier.loadUserTickets();
      });
      return notifier;
    });
