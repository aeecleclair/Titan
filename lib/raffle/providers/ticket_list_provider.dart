import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/raffle/class/raffle.dart';
import 'package:titan/raffle/class/tickets.dart';
import 'package:titan/raffle/providers/raffle_id_provider.dart';
import 'package:titan/raffle/repositories/raffle_detail_repository.dart';
import 'package:titan/tools/providers/list_notifier.dart';

class TicketsListNotifier extends ListNotifier<Ticket> {
  final RaffleDetailRepository _raffleDetailRepository =
      RaffleDetailRepository();
  late String raffleId;
  TicketsListNotifier({required String token})
    : super(const AsyncValue.loading()) {
    _raffleDetailRepository.setToken(token);
  }

  void setId(String id) {
    raffleId = id;
  }

  Future<AsyncValue<List<Ticket>>> loadTicketList() async {
    return await loadList(
      () async => _raffleDetailRepository.getTicketListFromRaffle(raffleId),
    );
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
